//
//  Tryouts.m
//  Pods
//
//  Created by Taylan Pince on 2015-09-27.
//
//

#import "Tryouts.h"

#import "TRYAppRelease.h"
#import "TRYFeedbackViewController.h"
#import "TRYFeedback.h"
#import "TRYFeedbackUploadManager.h"
#import "TRYFeedbackUploadTask.h"


static NSString * const TRYAPIVersionCheckURL = @"https://api.tryouts.io/v1/applications/%@/";

static NSTimeInterval const TRYAPIUpdateCheckInterval = 15.0 * 60.0;


@interface Tryouts () <UIAlertViewDelegate, TRYFeedbackViewControllerDelegate>

@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *APIKey;
@property (nonatomic, strong) NSString *APISecret;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appShortVersion;
@property (nonatomic, strong) TRYAppRelease *latestRelease;
@property (nonatomic, strong) NSDate *lastUpdateCheckDate;

- (instancetype)initWithAppIdentifier:(NSString *)appIdentifier
                               APIKey:(NSString *)APIKey
                               secret:(NSString *)secret;

- (void)didReceiveApplicationDidBecomeActiveNotification:(NSNotification *)notification;

- (NSComparisonResult)compareWithVersion:(NSString *)version
                            buildVersion:(NSString *)buildVersion;

- (void)fetchLatestVersion;
- (void)compareWithRelease:(TRYAppRelease *)release;
- (void)sendFeedback:(TRYFeedback *)feedback;

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

        [TRYFeedbackUploadManager sharedManager];
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
    
    _lastUpdateCheckDate = nil;
    _appIdentifier = [appIdentifier copy];
    _APIKey = [APIKey copy];
    _APISecret = [secret copy];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];

    _appVersion = infoDict[@"CFBundleVersion"];
    _appShortVersion = infoDict[@"CFBundleShortVersionString"];
    
    if ([_appVersion hasPrefix:_appShortVersion]) {
        _appVersion = [_appVersion stringByReplacingOccurrencesOfString:_appShortVersion
                                                             withString:@""];
    }
    
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
    if (_lastUpdateCheckDate != nil && -[_lastUpdateCheckDate timeIntervalSinceNow] < TRYAPIUpdateCheckInterval) {
        return;
    }
    
    _lastUpdateCheckDate = [NSDate date];
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:
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
                                          
                                          NSDictionary *releaseInfo = responseData[@"latest_release"];
                                          
                                          if (response != nil && ![response isEqual:[NSNull null]]) {
                                              [self compareWithRelease:[[TRYAppRelease alloc]
                                                                        initWithReleaseInfo:releaseInfo]];
                                          }
                                      } else {
                                          _lastUpdateCheckDate = nil;
                                      }
                                  }];
    
    [task resume];
}

#pragma mark - Comparison

- (void)compareWithRelease:(TRYAppRelease *)release {
    NSComparisonResult result = [self compareWithVersion:release.appShortVersion
                                            buildVersion:release.appVersion];
    
    if (result != NSOrderedAscending) {
        return;
    }

    _latestRelease = release;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"New Version Found", nil)
                                  message:[NSString stringWithFormat:
                                           NSLocalizedString(@"%@ is available as an update.", nil),
                                           _latestRelease.name]
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"Remind me later", nil)
                                  otherButtonTitles:NSLocalizedString(@"Update now", nil), nil];
        
        [alertView show];
    });
}

- (NSComparisonResult)compareWithVersion:(NSString *)version
                            buildVersion:(NSString *)buildVersion {
    
    NSComparisonResult comparison = [_appShortVersion compare:version options:NSNumericSearch];
    
    if (comparison == NSOrderedSame) {
        comparison = [_appVersion compare:buildVersion options:NSNumericSearch];
    }
    
    return comparison;
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 1) {
        return;
    }
    
    if (_latestRelease == nil) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:_latestRelease.installURL];
}

#pragma mark - Feedback

+ (void)presentFeedbackControllerFromViewController:(UIViewController *)presentingViewController
                                           animated:(BOOL)animated {

    TRYFeedbackViewController *controller = [[TRYFeedbackViewController alloc] init];

    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    controller.delegate = _sharedManager;

    [presentingViewController presentViewController:controller
                                           animated:animated
                                         completion:nil];
}

#pragma mark - Feedback delegate

- (void)feedbackViewControllerDidFinishWithFeedback:(TRYFeedback *)feedback {
    if (feedback == nil) {
        return;
    }

    TRYFeedbackUploadTask *uploadTask = [[TRYFeedbackUploadTask alloc]
                                         initFeedbackUploadTaskWithFeedback:feedback
                                         releaseVersion:_appVersion
                                         appIdentifier:_appIdentifier
                                         apiKey:_APIKey
                                         apiSecret:_APISecret];
    
    [[TRYFeedbackUploadManager sharedManager] createUploadTaskForFeedback:uploadTask];
}

@end
