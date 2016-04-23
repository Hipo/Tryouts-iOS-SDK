//
//  TRYFeedbackUploadManager.h
//  Pods
//
//  Created by Eray on 22/04/16.
//
//

#import <Foundation/Foundation.h>

@interface TRYFeedbackUploadManager : NSObject

+ (TRYFeedbackUploadManager *)sharedManager;

- (void)addTask;

@end
