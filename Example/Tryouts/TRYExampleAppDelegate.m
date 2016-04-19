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

    [Tryouts initializeWithAppIdentifier:@"RiAP2VpK"
                                  APIKey:@"5fd41c19b826fa10d659c0615a611576"
                                  secret:@"e6c428c4c191cb31777e7776a13fbb98a541b0ba"];

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:[[TRYExampleViewController alloc] init]];

    [window setRootViewController:navController];
    [window makeKeyAndVisible];

    [self setWindow:window];

    return YES;
}

@end
