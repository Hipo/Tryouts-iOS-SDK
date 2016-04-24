//
//  TRYFeedbackUploadTask.m
//  Pods
//
//  Created by Eray on 22/04/16.
//
//

#import "TRYFeedbackUploadTask.h"
#import "TRYFeedback.h"

@implementation TRYFeedbackUploadTask

- (instancetype)initWithInfo:(NSDictionary *)taskInfo {
    self = [super init];

    if (self) {
        _creationDate       = [taskInfo valueForKey:@"date"];
        _storagePath        = [taskInfo valueForKey:@"path"];
        _taskIdentifier     = [[taskInfo valueForKey:@"task_id"] integerValue];
        _feedbackIdentifier = [taskInfo valueForKey:@"id"];
        _message            = [taskInfo valueForKey:@"message"];
        _screenshot         = [taskInfo objectForKey:@"screenshot"];
        _releaseVersion     = [taskInfo valueForKey:@"release_version"];
    }

    return self;
}

- (instancetype)initFeedbackUploadTaskWithFeedback:(TRYFeedback *)feedback
                                    releaseVersion:(NSString *)appVersion
                                     appIdentifier:(NSString *)appIdentifier
                                            apiKey:(NSString *)APIKey
                                         apiSecret:(NSString *)APISecret {
    self = [super init];

    if (self) {
        _taskIdentifier = NSNotFound;
        _creationDate   = [NSDate date];
        _username       = feedback.username;
        _screenshot     = feedback.screenshot;
        _message        = feedback.message;
        _releaseVersion = appVersion;
        _appIdentifier  = appIdentifier;
        _APIKey         = APIKey;
        _APISecret      = APISecret;
    }

    return self;
}

- (NSDictionary *)serializedTask {
    NSMutableDictionary
    *serializedTask = [NSMutableDictionary
                       dictionaryWithDictionary:@{ @"date"    : _creationDate,
                                                   @"task_id" : @(_taskIdentifier),
                                                   @"post_id" : _feedbackIdentifier }];

    if (_storagePath != nil) {
        [serializedTask setValue:_storagePath forKey:@"path"];
    }

    if (_message != nil) {
        [serializedTask setValue:_message forKey:@"message"];
    }

    if (_screenshot != nil) {
        [serializedTask setValue:_screenshot forKey:@"screenshot"];
    }

    return serializedTask;
}

- (void)setTaskIdentifier:(NSUInteger)taskIdentifier
           andStoragePath:(NSString *)storagePath {
    
    _taskIdentifier = taskIdentifier;
    _storagePath = storagePath;
}

@end
