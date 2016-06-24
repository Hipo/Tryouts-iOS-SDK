//
//  TRYAppDelegate.m
//  Tryouts
//
//  Created by Taylan Pince on 09/27/2015.
//  Copyright (c) 2015 Taylan Pince. All rights reserved.
//

#import <Tryouts/Tryouts.h>
#import "TRYExampleAppDelegate.h"
#import "TRYExampleViewController.h"
#import <Tryouts/TRYFeedbackViewController.h>
#import <Tryouts/TRYMotionRecognizingWindow.h>


@interface TRYExampleAppDelegate ()<TRYMotionRecognizingWindowDelegate>

@end

@implementation TRYExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Tryouts initializeWithAppIdentifier:@"7HB7Ke6X"
                                  APIKey:@"b9d09ac13e52c0f09dd988f302dca833"
                                  secret:@"de55be15922da790c0862d3db152c5d75e18fbb0"];

    TRYMotionRecognizingWindow *motionRecognizingWindow = [[TRYMotionRecognizingWindow alloc]
                                                           initWithFrame:[[UIScreen mainScreen] bounds]];

    motionRecognizingWindow.motionDelegate = self;


    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:[[TRYExampleViewController alloc] init]];

    [motionRecognizingWindow setRootViewController:navController];
    [motionRecognizingWindow makeKeyAndVisible];

    [self setWindow:motionRecognizingWindow];

    return YES;
}

#pragma mark - Motion Recognization

- (void)motionRecognizingWindowDidRecognizeShakeMotion:(TRYMotionRecognizingWindow *)motionRecognizingWindow
                                  andTopMostController:(UIViewController *)topMostController {

    if ([topMostController isKindOfClass:[TRYFeedbackViewController class]]) {
        return;
    }

    [Tryouts presentFeedBackControllerFromViewController:topMostController
                                                animated:YES];
}

@end
