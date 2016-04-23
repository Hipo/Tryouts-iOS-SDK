//
//  TRYFeedbackUploadManager.m
//  Pods
//
//  Created by Eray on 22/04/16.
//
//

#import "TRYFeedbackUploadManager.h"
#import "TRYFeedbackUploadTask.h"

static NSString * const kStorageDirectoryName        = @"kStorageDirectoryName";
static NSString * const kTasksKey                    = @"kTasksKey";
static NSString * const kBackgroundSessionIdentifier = @"kBackgroundSessionIdentifier";

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
        NSArray *savedTasks = [[NSUserDefaults standardUserDefaults] objectForKey:kTasksKey];

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
    }

    return self;
}

- (void)addTask {
    NSLog(@"Task added");
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

}

@end
