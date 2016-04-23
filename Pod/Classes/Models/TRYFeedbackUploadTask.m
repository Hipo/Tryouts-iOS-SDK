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
        _dataPath           = [taskInfo valueForKey:@"path"];
        _taskIdentifier     = [[taskInfo valueForKey:@"task_id"] integerValue];
        _feedbackIdentifier = [taskInfo valueForKey:@"id"];
        _message            = [taskInfo valueForKey:@"message"];
        _screenshot         = [taskInfo objectForKey:@"screenshot"];
        _releaseVersion     = [taskInfo valueForKey:@"release_version"];
    }

    return self;
}

- (instancetype)initFeedbackTaskWithFeedback:(TRYFeedback *)feedback {
    self = [super init];

    if (self) {
        _taskIdentifier = NSNotFound;
        _creationDate   = [NSDate date];
        _screenshot     = feedback.screenshot;
        _message        = feedback.message;
    }

    return self;
}

@end
