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
