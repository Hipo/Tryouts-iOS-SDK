//
//  TRYFeedbackUploadManager.h
//  Pods
//
//  Created by Eray on 22/04/16.
//
//

#import <Foundation/Foundation.h>

@class TRYFeedbackUploadTask;

@interface TRYFeedbackUploadManager : NSObject

+ (TRYFeedbackUploadManager *)sharedManager;

- (void)createUploadTaskForFeedback:(TRYFeedbackUploadTask *)feedback;

@end
