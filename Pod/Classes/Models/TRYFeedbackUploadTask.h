//
//  TRYFeedbackUploadTask.h
//  Pods
//
//  Created by Eray on 22/04/16.
//
//

#import <Foundation/Foundation.h>

@class TRYFeedback;

@interface TRYFeedbackUploadTask : NSObject

@property (nonatomic, assign, readonly) NSUInteger taskIdentifier;
@property (nonatomic, strong, readonly) NSNumber *feedbackIdentifier;
@property (nonatomic, strong, readonly) NSString *username;
@property (nonatomic, strong, readonly) NSString *message;
@property (nonatomic, strong, readonly) NSString *screenshot;
@property (nonatomic, strong, readonly) NSString *releaseVersion;
@property (nonatomic, strong, readonly) NSString *dataPath;
@property (nonatomic, strong, readonly) NSDate *creationDate;

- (instancetype)initWithInfo:(NSDictionary *)taskInfo;
- (instancetype)initFeedbackTaskWithFeedback:(TRYFeedback *)feedback;

- (NSDictionary *)serializedTask;

@end
