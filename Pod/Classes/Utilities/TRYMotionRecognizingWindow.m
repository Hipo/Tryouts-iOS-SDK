//
//  TRYMotionRecognizingWindow.m
//  Pods
//
//  Created by Eray on 22/06/16.
//
//

#import "TRYMotionRecognizingWindow.h"

@implementation TRYMotionRecognizingWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion
        && event.subtype == UIEventSubtypeMotionShake) {

        if ([_motionDelegate respondsToSelector:@selector(motionRecognizingWindowDidRecognizeShakeMotion:)]) {
            [_motionDelegate motionRecognizingWindowDidRecognizeShakeMotion:self];
        }
    }
}

@end
