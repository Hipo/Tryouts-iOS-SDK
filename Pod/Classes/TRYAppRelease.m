//
//  TRYAppRelease.m
//  Pods
//
//  Created by Taylan Pince on 2015-10-11.
//
//

#import "TRYAppRelease.h"


@interface TRYAppRelease ()

- (id)nonNullValueForKey:(NSString *)key
          fromDictionary:(NSDictionary *)dict;

@end


@implementation TRYAppRelease

- (instancetype)initWithReleaseInfo:(NSDictionary *)releaseInfo {
    self = [super init];
    
    if (self == nil) {
        return nil;
    }
    
    _name = [self nonNullValueForKey:@"name" fromDictionary:releaseInfo];
    _appVersion = [self nonNullValueForKey:@"cf_bundle_version" fromDictionary:releaseInfo];
    _appShortVersion = [self nonNullValueForKey:@"cf_bundle_short_version_string" fromDictionary:releaseInfo];
    _binarySize = [self nonNullValueForKey:@"size" fromDictionary:releaseInfo];
    
    NSString *downloadLink = [self nonNullValueForKey:@"download_link" fromDictionary:releaseInfo];
    NSString *iconLink = [self nonNullValueForKey:@"icon_thumbnail" fromDictionary:releaseInfo];
    
    if (downloadLink != nil) {
        _downloadURL = [NSURL URLWithString:downloadLink];
    }
    
    if (iconLink != nil) {
        _iconURL = [NSURL URLWithString:iconLink];
    }
    
    NSString *dateInfo = [self nonNullValueForKey:@"date_created" fromDictionary:releaseInfo];
    
    if (dateInfo != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLocale *northAmericanLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [formatter setLocale:northAmericanLocale];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        
        _creationDate = [formatter dateFromString:dateInfo];
    }
    
    return self;
}

- (id)nonNullValueForKey:(NSString *)key
          fromDictionary:(NSDictionary *)dict {
    
    id value = dict[key];
    
    if (value == nil || [value isEqual:[NSNull null]]) {
        return nil;
    }
    
    return value;
}

@end
