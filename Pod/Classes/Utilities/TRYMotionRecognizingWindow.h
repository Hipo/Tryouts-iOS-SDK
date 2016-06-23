//
//  TRYMotionRecognizingWindow.h
//  Pods
//
//  Created by Eray on 22/06/16.
//
//

#import <UIKit/UIKit.h>

@protocol TRYMotionRecognizingWindowDelegate;


@interface TRYMotionRecognizingWindow : UIWindow

@property (nonatomic, weak) id<TRYMotionRecognizingWindowDelegate> motionDelegate;

@end


@protocol TRYMotionRecognizingWindowDelegate <NSObject>

- (void)motionRecognizingWindowDidRecognizeShakeMotion:(TRYMotionRecognizingWindow *)motionRecognizingWindow
                                  andTopMostController:(UIViewController *)topMostController;

@end
