//
//  TRYFeedbackViewController.m
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import "TRYFeedbackViewController.h"
#import "TRYFeedbackOverlayView.h"
#import "TRYFeedback.h"
#import "TRYMessageView.h"

@interface TRYFeedbackViewController () <TRYFeedbackOverlayViewDelegate>

@property (nonatomic, strong) TRYFeedback *feedback;

- (UIImage *)screenShotOfWindow;
- (NSString *)encodedStringOfScreenshot;

@end

@implementation TRYFeedbackViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(didTapBackground:)]];
    if (!_feedback) {
        _feedback = [TRYFeedback new];
    }

    _feedback.screenshot = [self encodedStringOfScreenshot];

    [self configureView];
}

#pragma mark - Layout

- (void)configureView {
    self.view.backgroundColor = [UIColor clearColor];

    [self screenShotOfWindow];

    TRYFeedbackOverlayView *feedBackOverlayView = [[TRYFeedbackOverlayView alloc]
                                                   initWithFrame:self.view.bounds];
    feedBackOverlayView.delegate = self;

    [self.view addSubview:feedBackOverlayView];
}

#pragma mark - Actions

- (void)didTapBackground:(id)sender {

}

- (void)feedbackOverlayViewDidTapCloseButton:(TRYFeedbackOverlayView *)feedbackOverlayView {
//    [self dismissViewControllerAnimated:YES completion:^{
//        [_delegate feedbackViewControllerDismissed:self];
//    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)feedbackOverlayViewDidTapSubmitButton:(TRYFeedbackOverlayView *)feedbackOverlayView {
    _feedback.username = feedbackOverlayView.usernameField.text;
    _feedback.message = feedbackOverlayView.messageView.text;

    if ([_delegate respondsToSelector:@selector(feedbackViewControllerDidFinishWithFeedback:)]) {
        [_delegate feedbackViewControllerDidFinishWithFeedback:_feedback];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Screenshot

- (UIImage *)screenShotOfWindow {
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIGraphicsBeginImageContext(screenRect.size);

    CGContextRef currentContex = UIGraphicsGetCurrentContext();

    [[UIColor blackColor] set];
    CGContextFillRect(currentContex, screenRect);

    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    [window.layer renderInContext:currentContex];

    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenshotImage;
}

- (NSString *)encodedStringOfScreenshot {
    UIImage *screenshotImage = [self screenShotOfWindow];

    NSData *imageData = UIImageJPEGRepresentation(screenshotImage, 1.0);

    return [imageData base64Encoding];
}

@end
