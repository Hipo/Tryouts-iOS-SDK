//
//  Tryouts.h
//  Pods
//
//  Created by Taylan Pince on 2015-09-27.
//
//

#import <Foundation/Foundation.h>


@interface Tryouts : NSObject

+ (Tryouts *)sharedManager;
+ (Tryouts *)initializeWithAppIdentifier:(NSString *)appIdentifier
                                  APIKey:(NSString *)APIKey
                                  secret:(NSString *)secret;

@end
