//
//  Tryouts.h
//  Pods
//
//  Created by Taylan Pince on 2015-09-27.
//
//

#import <Foundation/Foundation.h>


@interface Tryouts : NSObject

/**
 *  @method
 *  
 *  @abstract
 *  Returns a shared instance to interact with the Tryouts API
 *
 *  @discussion
 *  `initializeWithAppIdentifier:APIKey:secret:` needs to be called before this shortcut
 *  can be used. If initialization has not happened yet, it will return `nil`.
 *
 *  @return Shared manager instance for the Tryouts API
 */
+ (Tryouts *)sharedManager;

/**
 *  @method
 *  
 *  @abstract
 *  Designated initializer for the Tryouts API, needs to be called before any other method
 *
 *  @discussion
 *  It's recommended to call this method with your app-specific identifier, API key and 
 *  secret key from your app's `application:didFinishLaunchingWithOptions:` method as 
 *  early as possible during app start. This method will automatically trigger a version
 *  check against the Tryouts API every time the app becomes active. Then the Tryouts SDK
 *  will display an update alert if there is a newer, non-private version available.
 *
 *  @param appIdentifier Identifier hash for your Tryouts app
 *  @param APIKey        API key for your Tryouts app
 *  @param secret        API secret for your Tryouts app
 *
 *  @return Initialized Tryouts shared manager object
 */
+ (Tryouts *)initializeWithAppIdentifier:(NSString *)appIdentifier
                                  APIKey:(NSString *)APIKey
                                  secret:(NSString *)secret;

+ (void)presentFeedBackControllerFromViewController:(UIViewController *)viewController
                                           animated:(BOOL)animated;

@end
