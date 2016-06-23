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
@property (nonatomic, strong, readonly) NSString * username;
@property (nonatomic, strong, readonly) NSString * message;
@property (nonatomic, strong, readonly) NSString * screenshot;
@property (nonatomic, strong, readonly) NSString * releaseVersion;
@property (nonatomic, strong, readonly) NSString * storagePath;
@property (nonatomic, strong, readonly) NSDate   * creationDate;

@property (nonatomic, strong, readonly) NSString * appIdentifier;
@property (nonatomic, strong, readonly) NSString * APIKey;
@property (nonatomic, strong, readonly) NSString * APISecret;

- (instancetype)initWithInfo:(NSDictionary *)taskInfo;

- (instancetype)initFeedbackUploadTaskWithFeedback:(TRYFeedback *)feedback
                                    releaseVersion:(NSString *)appVersion
                                     appIdentifier:(NSString *)appIdentifier
                                            apiKey:(NSString *)APIKey
                                         apiSecret:(NSString *)APISecret;

- (void)setTaskIdentifier:(NSUInteger)taskIdentifier
           andStoragePath:(NSString *)storagePath;

- (NSDictionary *)serializedTask;

@end
