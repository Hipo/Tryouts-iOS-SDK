//
//  Tryouts.m
//  Pods
//
//  Created by Taylan Pince on 2015-09-27.
//
//

#import "Tryouts.h"

#import "TRYAppRelease.h"


static NSString * const TRYAPIVersionCheckURL = @"https://staging.tryouts.io/applications/%@/";


@interface Tryouts ()

@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *APIKey;
@property (nonatomic, strong) NSString *APISecret;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appShortVersion;

- (instancetype)initWithAppIdentifier:(NSString *)appIdentifier
                               APIKey:(NSString *)APIKey
                               secret:(NSString *)secret;

- (void)didReceiveApplicationDidBecomeActiveNotification:(NSNotification *)notification;

- (NSComparisonResult)compareWithVersion:(NSString *)version
                            buildVersion:(NSString *)buildVersion;

- (void)fetchLatestVersion;
- (void)compareWithRelease:(TRYAppRelease *)release;

@end


@implementation Tryouts

static Tryouts *_sharedManager = nil;

+ (Tryouts *)initializeWithAppIdentifier:(NSString *)appIdentifier
                                  APIKey:(NSString *)APIKey
                                  secret:(NSString *)secret {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[Tryouts alloc] initWithAppIdentifier:appIdentifier
                                                         APIKey:APIKey
                                                         secret:secret];
    });
    
    return _sharedManager;
}

+ (Tryouts *)sharedManager {
    return _sharedManager;
}

- (instancetype)initWithAppIdentifier:(NSString *)appIdentifier
                               APIKey:(NSString *)APIKey
                               secret:(NSString *)secret {
    
    self = [super init];
    
    if (self == nil) {
        return nil;
    }
    
    _appIdentifier = [appIdentifier copy];
    _APIKey = [APIKey copy];
    _APISecret = [secret copy];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];

    _appVersion = infoDict[@"CFBundleVersion"];
    _appShortVersion = infoDict[@"CFBundleShortVersionString"];
    
    NSLog(@"LOCAL VERSION: %@ / LOCAL SHORT VERSION: %@", _appVersion, _appShortVersion);
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveApplicationDidBecomeActiveNotification:)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    
    return self;
}

#pragma mark - Notifications

- (void)didReceiveApplicationDidBecomeActiveNotification:(NSNotification *)notification {
    [self fetchLatestVersion];
}

#pragma mark - Fetching

- (void)fetchLatestVersion {
    NSLog(@">>> CHECK FOR UPDATES");

    NSString *requestURL = [NSURL URLWithString:[NSString stringWithFormat:
                                                 TRYAPIVersionCheckURL, _appIdentifier]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%@:%@", _APIKey, _APISecret] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
                                      
                                      NSInteger statusCode = 0;
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          statusCode = [(NSHTTPURLResponse *)response statusCode];
                                      }
                                      
                                      if (error == nil && data != nil && statusCode == 200) {
                                          NSDictionary *responseData = [NSJSONSerialization
                                                                        JSONObjectWithData:data
                                                                        options:0
                                                                        error:nil];
                                          
                                          NSLog(@">>> %@", responseData);
                                          
                                          NSDictionary *releaseInfo = responseData[@"latest_release"];
                                          
                                          if (response != nil && ![response isEqual:[NSNull null]]) {
                                              [self compareWithRelease:[[TRYAppRelease alloc]
                                                                        initWithReleaseInfo:releaseInfo]];
                                          } else {
                                              NSLog(@">>> NO LAST RELEASE FOUND");
                                          }
                                      } else {
                                          NSLog(@"%@ / %@", response, error);
                                      }
                                  }];
    
    [task resume];
}

#pragma mark - Comparison

- (void)compareWithRelease:(TRYAppRelease *)release {
    NSLog(@">>> LATEST RELEASE: %@ - %@ (%@)",
          release.name, release.appShortVersion, release.appVersion);
    
    NSComparisonResult result = [self compareWithVersion:release.appShortVersion
                                            buildVersion:release.appVersion];
    
    if (result == NSOrderedSame) {
        NSLog(@"SAME RELEASE");
    } else if (result == NSOrderedAscending) {
        NSLog(@"NEW RELEASE (Ascending)");
    } else {
        NSLog(@"NO NEW RELEASE (Descending)");
    }
}

- (NSComparisonResult)compareWithVersion:(NSString *)version
                            buildVersion:(NSString *)buildVersion {
    
    NSComparisonResult comparison = [_appShortVersion compare:version options:NSNumericSearch];
    
    if (comparison == NSOrderedSame) {
        comparison = [_appVersion compare:buildVersion options:NSNumericSearch];
    }
    
    return comparison;
}

@end
