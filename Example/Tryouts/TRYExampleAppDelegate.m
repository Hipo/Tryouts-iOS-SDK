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

    [Tryouts initializeWithAppIdentifier:@"QOCWOqT0"
                                  APIKey:@"5fa26ce4c439a879c047f34b10f64f99"
                                  secret:@"3498ac2fed57069b388868aefd7b3099715043b0"];

    TRYMotionRecognizingWindow *window = [[TRYMotionRecognizingWindow alloc]
                                          initWithFrame:[[UIScreen mainScreen] bounds]];
    window.motionDelegate = self;


    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:[[TRYExampleViewController alloc] init]];

    [window setRootViewController:navController];
    [window makeKeyAndVisible];

    [self setWindow:window];

    return YES;
}

#pragma mark - Motion Recognization

- (void)motionRecognizingWindowDidRecognizeShakeMotion:(TRYMotionRecognizingWindow *)motionRecognizingWindow {
    if ([[self topMostController] isKindOfClass:[TRYFeedbackViewController class]]) {
        return;
    }

    [Tryouts presentFeedBackControllerFromViewController:[self topMostController]
                                                animated:YES];
}

- (UIViewController *)topMostController {
    UIViewController *topMostController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topMostController.presentedViewController) {
        topMostController = topMostController.presentedViewController;
    }

    return topMostController;
}


@end
