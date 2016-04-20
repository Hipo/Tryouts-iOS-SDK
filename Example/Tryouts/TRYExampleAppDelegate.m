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

@implementation TRYExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Tryouts initializeWithAppIdentifier:@"QOCWOqT0"
                                  APIKey:@"5fa26ce4c439a879c047f34b10f64f99"
                                  secret:@"3498ac2fed57069b388868aefd7b3099715043b0"];

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:[[TRYExampleViewController alloc] init]];

    [window setRootViewController:navController];
    [window makeKeyAndVisible];

    [self setWindow:window];

    return YES;
}

@end
