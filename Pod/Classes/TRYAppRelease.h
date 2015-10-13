//
//  TRYAppRelease.h
//  Pods
//
//  Created by Taylan Pince on 2015-10-11.
//
//

#import <Foundation/Foundation.h>


@interface TRYAppRelease : NSObject

@property (nonatomic, strong, readonly) NSString *appVersion;
@property (nonatomic, strong, readonly) NSString *appShortVersion;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *binarySize;
@property (nonatomic, strong, readonly) NSURL *downloadURL;
@property (nonatomic, strong, readonly) NSURL *iconURL;
@property (nonatomic, strong, readonly) NSURL *installURL;
@property (nonatomic, strong, readonly) NSDate *creationDate;

- (instancetype)initWithReleaseInfo:(NSDictionary *)releaseInfo;

@end
