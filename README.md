# Tryouts

[![Version](https://img.shields.io/cocoapods/v/Tryouts.svg?style=flat)](http://cocoapods.org/pods/Tryouts)
[![License](https://img.shields.io/cocoapods/l/Tryouts.svg?style=flat)](http://cocoapods.org/pods/Tryouts)
[![Platform](https://img.shields.io/cocoapods/p/Tryouts.svg?style=flat)](http://cocoapods.org/pods/Tryouts)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To set it up for your own app, navigate to the Integrations section on your Tryouts dashboard, and find the following keys:

* App identifier
* API Key
* API Secret

In your app delegate's `application:didFinishLaunchingWithOptions:` method, initialize the Tryouts SDK:

```objc
[Tryouts initializeWithAppIdentifier:@"<App Identifier>"
                              APIKey:@"<API Key>"
                              secret:@"<API Secret>"];

```

Tryouts SDK will automatically check for new releases every time the app becomes active and alert users when there is a new version available.

### Feedback

Tryouts SDK can be used to gather in-app feedback from your users. The method to be used is `presentFeedbackControllerFromViewController:animated:`

```objc
[Tryouts presentFeedbackControllerFromViewController:presentingViewController
                                            animated:animated];
```

Feedback overlay view will be presented on presentingViewController when this method called. Feedback overlay view has username and feedback fields, feedback is optional while username is required. Also, a snapshot of the screen is taken in the background when feedback overlay view is being presented, and sent to your Tryouts account.

Tryouts SDK also has support for presenting the feedback view by using shake motion. This functionality is optional. To use the functionality, simply initialize your application's window with `TRYMotionRecognizingWindow` class, and implement `motionRecognizingWindowDidRecognizeShakeMotion:andTopMostController:` delegate method conforming `TRYMotionRecognizingWindowDelegate` protocol.

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	...
    TRYMotionRecognizingWindow *motionRecognizingWindow = [[TRYMotionRecognizingWindow alloc]
                                                           initWithFrame:[[UIScreen mainScreen] bounds]];
    motionRecognizingWindow.motionDelegate = self;
	...
}

- (void)motionRecognizingWindowDidRecognizeShakeMotion:(TRYMotionRecognizingWindow *)motionRecognizingWindow
                                  andTopMostController:(UIViewController *)topMostController {

    if ([topMostController isKindOfClass:[TRYFeedbackViewController class]]) {
        return;
    }

    [Tryouts presentFeedbackControllerFromViewController:topMostController
                                                animated:YES];
}
```


## Installation

Tryouts is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Tryouts"
```

## Author

Taylan Pince, taylan@hipolabs.com

## License

Tryouts is available under the MIT license. See the LICENSE file for more info.
