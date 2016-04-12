//
//  TRYFeedbackViewController.m
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import "TRYFeedbackViewController.h"
#import "TRYFeedbackOverlayView.h"

@interface TRYFeedbackViewController () <TRYFeedbackOverlayViewDelegate>

@property (nonatomic, strong) NSString *encodedScreenshot;

- (UIImage *)screenShotOfWindow;
- (NSString *)encodedStringOfScreenshot;

@end

@implementation TRYFeedbackViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(didTapBackground:)]];

    _encodedScreenshot = [self encodedStringOfScreenshot];

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
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate feedbackViewControllerDismissed:self];
    }];
}

- (void)feedbackOverlayViewDidTapSubmitButton:(TRYFeedbackOverlayView *)feedbackOverlayView {
    NSLog(@"Triggered");
}

#pragma mark - Screen shot

- (UIImage *)screenShotOfWindow {
    // Create graphics context with screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIGraphicsBeginImageContext(screenRect.size);

    CGContextRef currentContex = UIGraphicsGetCurrentContext();

    [[UIColor blackColor] set];
    CGContextFillRect(currentContex, screenRect);

    // Referance to current window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    // Transfering content into the context
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
