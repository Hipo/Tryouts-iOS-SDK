//
//  TRYFeedbackViewController.m
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import "TRYFeedbackViewController.h"
#import "TRYFeedbackOverlayView.h"

@interface TRYFeedbackOverlayView () <TRYFeedbackOverlayViewDelegate>

@end

@implementation TRYFeedbackViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(didTapBackground:)]];

    [self configureView];
}

#pragma mark - Layout

- (void)configureView {
    TRYFeedbackOverlayView *feedBackOverlayView = [[TRYFeedbackOverlayView alloc]
                                                   initWithFrame:self.view.bounds];
    feedBackOverlayView.delegate = self;

//    feedBackOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
//
//
//    NSMutableDictionary *views = [[NSMutableDictionary alloc]
//                                  initWithDictionary:@{ @"feedBackView":feedBackOverlayView }];
//
    [self.view addSubview:feedBackOverlayView];
//
//    NSArray *horizontalConstraints = [NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"H:|-[feedBackView]-|"
//                                      options:NSLayoutFormatAlignAllTop
//                                      metrics:nil
//                                      views:views];
//
//    NSArray *verticalConstraints = [NSLayoutConstraint
//                                    constraintsWithVisualFormat:@"V:|-50-[feedBackView]-50-|"
//                                    options:NSLayoutFormatAlignAllTop
//                                    metrics:nil
//                                    views:views];
//
//    [NSLayoutConstraint activateConstraints:horizontalConstraints];
//    [NSLayoutConstraint activateConstraints:verticalConstraints];
}

#pragma mark - Actions

- (void)didTapBackground:(id)sender {

}

- (void)feedbackOverlayViewDidTapCloseButton:(TRYFeedbackOverlayView *)feedbackOverlayView {
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate feedbackViewControllerDismissed:self];
    }];
}

@end
