//
//  TRYFeedbackUploadManager.m
//  Pods
//
//  Created by Eray on 22/04/16.
//
//

#import "TRYFeedbackUploadManager.h"
#import "TRYFeedbackUploadTask.h"

static NSString * const kStorageDirectoryName            = @"com.hipo.tryouts.kStorageDirectoryName";
static NSString * const kNSUserDefaultTasksKey           = @"com.hipo.tryouts.kNSUserDefaultTasksKey";
static NSString * const kBackgroundSessionIdentifier     = @"com.hipo.tryouts.kBackgroundSessionIdentifier";
static NSString * const kAPIFeedbackSendURL              = @"https://api.tryouts.io/v1/applications/%@/feedback/";


@interface TRYFeedbackUploadManager () <NSURLSessionTaskDelegate,
                                        NSURLSessionDataDelegate>

@property (nonatomic, strong) NSString       *storageDirectoryPath;
@property (nonatomic, strong) NSMutableArray *uploadTasks;
@property (nonatomic, strong) NSURLSession   *uploadSession;
@property (nonatomic, strong) NSMutableData  *receivedData;

@end

@implementation TRYFeedbackUploadManager

+ (TRYFeedbackUploadManager *)sharedManager {
    static TRYFeedbackUploadManager *_sharedManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedManager = [[TRYFeedbackUploadManager alloc] init];
    });

    return _sharedManager;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        _uploadTasks = [[NSMutableArray alloc] init];

        // Configure file path to save tasks
        NSFileManager *fileManager = [NSFileManager defaultManager];

        _storageDirectoryPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
                                  lastObject]
                                 stringByAppendingPathComponent:kStorageDirectoryName];

        BOOL storageDirectoryExists = NO;

        if (![fileManager fileExistsAtPath:_storageDirectoryPath
                               isDirectory:&storageDirectoryExists]) {

            [fileManager createDirectoryAtPath:_storageDirectoryPath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }

        // Get saved tasks into _uploadTasks
        NSArray *savedTasks = [[NSUserDefaults standardUserDefaults]
                               objectForKey:kNSUserDefaultTasksKey];

        for (NSDictionary *savedTask in savedTasks) {
            [_uploadTasks addObject:[[TRYFeedbackUploadTask alloc]
                                     initWithInfo:savedTask]];
        }

        // Init uploadSession
        NSURLSessionConfiguration *sessionConf = [NSURLSessionConfiguration
                                                  backgroundSessionConfigurationWithIdentifier:
                                                  kBackgroundSessionIdentifier];

        _uploadSession = [NSURLSession sessionWithConfiguration:sessionConf
                                                       delegate:self
                                                  delegateQueue:[NSOperationQueue mainQueue]];
        [self checkForNextTask];
    }

    return self;
}

#pragma mark - Upload

- (void)checkForNextTask { // Check for next task that is not assigned yet.
    [_uploadSession getTasksWithCompletionHandler:^(NSArray *dataTasks,
                                                    NSArray *uploadTasks,
                                                    NSArray *downloadTasks) {

        NSUInteger activeTaskIdentifier = NSNotFound;

        for (NSURLSessionUploadTask *uploadTask in uploadTasks) {
            if (uploadTask.state == NSURLSessionTaskStateRunning
                || uploadTask.state == NSURLSessionTaskStateSuspended) {
                activeTaskIdentifier = uploadTask.taskIdentifier;

                break;
            }
        }

        if (activeTaskIdentifier == NSNotFound && [_uploadTasks count] > 0) {
            for (TRYFeedbackUploadTask *nextTask in _uploadTasks) {
                if (nextTask.taskIdentifier == activeTaskIdentifier) {
                    [self beginUploadForTask:nextTask];

                    break;
                }
            }
        }

    }];
}

- (void)beginUploadForTask:(TRYFeedbackUploadTask *)uploadTask {

    // Configure request
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:
                                              kAPIFeedbackSendURL, uploadTask.appIdentifier]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];

    NSDictionary *params = @{ @"user_name"       : uploadTask.username,
                              @"release_version" : uploadTask.releaseVersion,
                              @"message"         : uploadTask.message,
                              @"screenshot"      : uploadTask.screenshot };

    NSError *error;
    NSData *serializedBody = [NSJSONSerialization dataWithJSONObject:params
                                                             options:0
                                                               error:&error];
    if (error != nil) {
        NSLog(@"Error when parsing post body parameters");

        return;
    }

    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString
                       stringWithFormat:@"%@:%@", uploadTask.APIKey,
                       uploadTask.APISecret] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:serializedBody];

    // Get filepath
    NSString *storagePath = uploadTask.storagePath;

    if (storagePath == nil) { // Write body data into file
        storagePath = [_storageDirectoryPath
                       stringByAppendingPathComponent:[NSString
                                                       stringWithFormat:@"%1.0f",
                                                       [[NSDate date] timeIntervalSince1970]]];

        [serializedBody writeToFile:storagePath atomically:YES];
    }

    NSURL *storageURL = [NSURL fileURLWithPath:storagePath];
    NSURLSessionTask *backgroundTask = [_uploadSession uploadTaskWithRequest:request
                                                                    fromFile:storageURL];

    [uploadTask setTaskIdentifier:backgroundTask.taskIdentifier
                   andStoragePath:storagePath];

    [backgroundTask resume];
}

#pragma mark - Adding task

- (void)createUploadTaskForFeedback:(TRYFeedbackUploadTask *)feedback {
    [_uploadTasks addObject:feedback];

    [self checkForNextTask];
    [self saveTasksInUserDefaults];
}

#pragma mark - Saving task

- (void)saveTasksInUserDefaults {
    NSMutableArray *tasks = [NSMutableArray array];

    for (TRYFeedbackUploadTask *task in _uploadTasks) {
        [tasks addObject:[task serializedTask]];
    }

    [[NSUserDefaults standardUserDefaults] setObject:tasks
                                              forKey:kNSUserDefaultTasksKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {

    if (_receivedData == nil) {
        _receivedData = [NSMutableData new];
    }

    [_receivedData appendData:data];
}

-   (void)URLSession:(NSURLSession *)session
                task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {

    if (error != nil) {
        NSLog(@"URL SESSION ERROR: %@", error);

        return;
    }

    // Remove uploaded task from array
    TRYFeedbackUploadTask *uploadedTask = nil;

    for (TRYFeedbackUploadTask *aTask in _uploadTasks) {
        if (aTask.taskIdentifier == task.taskIdentifier) {
            uploadedTask = aTask;

            break;
        }
    }

    if (uploadedTask == nil) {
        return;
    }

    [_uploadTasks removeObject:uploadedTask];

    if (_receivedData != nil) { // Parse response data
        NSError *parseError = nil;

        NSDictionary *response = [NSJSONSerialization
                                  JSONObjectWithData:_receivedData
                                             options:0
                                               error:&parseError];
        if (parseError != nil) {
            NSLog(@"%@", parseError);

            return;
        }

        NSDictionary *error = [response objectForKey:@"error"];

        if (error != nil) {
            NSLog(@"Error code: %@, message: %@", [error objectForKey:@"code"],
                                                  [error objectForKey:@"message"]);
        }
    }

    _receivedData = nil;

    [self saveTasksInUserDefaults];

    if (_uploadTasks.count == 0) { // No need to go on
        return;
    }

    [self checkForNextTask];
}

@end
