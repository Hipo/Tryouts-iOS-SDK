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

- (UIImage *)imageWithScreenshotOfActiveWindow;
- (NSString *)stringWithEncodedScreenshotImageOfActiveWindow;

@end

@implementation TRYFeedbackViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        _feedback = [TRYFeedback new];

        _feedback.screenshot = [self stringWithEncodedScreenshotImageOfActiveWindow];
    }

    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(didTapBackground:)]];

    [self configureView];
}

#pragma mark - Layout

- (void)configureView {
    self.view.backgroundColor = [UIColor clearColor];

    TRYFeedbackOverlayView *feedBackOverlayView = [[TRYFeedbackOverlayView alloc]
                                                   initWithFrame:self.view.bounds];
    [feedBackOverlayView focusOnUsernameField];
    feedBackOverlayView.delegate = self;

    [self.view addSubview:feedBackOverlayView];

    [feedBackOverlayView layoutIfNeeded];
    [feedBackOverlayView showAnimated:YES];
}

#pragma mark - Actions

- (void)didTapBackground:(id)sender {

}

- (void)feedbackOverlayViewDidTapCloseButton:(TRYFeedbackOverlayView *)feedbackOverlayView {
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

- (UIImage *)imageWithScreenshotOfActiveWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenshotImage;
}

- (NSString *)stringWithEncodedScreenshotImageOfActiveWindow {
    UIImage *screenshotImage = [self imageWithScreenshotOfActiveWindow];

    NSData *imageData = UIImageJPEGRepresentation(screenshotImage, 1.0);

    return [imageData base64Encoding];
}

@end
