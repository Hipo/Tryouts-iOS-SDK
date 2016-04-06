//
//  TRYFeedbackViewController.m
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import "TRYFeedbackViewController.h"
#import "TRYFeedbackOverlayView.h"

@implementation TRYFeedbackViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(didTapBackground:)]];


    TRYFeedbackOverlayView *feedBackOverlayView = [TRYFeedbackOverlayView new];

    feedBackOverlayView.translatesAutoresizingMaskIntoConstraints = NO;

    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"feedBackView":feedBackOverlayView }];

    [self.view addSubview:feedBackOverlayView];


    NSArray *horizontalConstraints = [NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|-[feedBackView]-|"
                                                          options:NSLayoutFormatAlignAllTop
                                                          metrics:nil
                                                            views:views];

    NSArray *verticalConstraints = [NSLayoutConstraint
                                    constraintsWithVisualFormat:@"V:|-50-[feedBackView]-50-|"
                                                        options:NSLayoutFormatAlignAllTop
                                                        metrics:nil
                                                          views:views];

    [NSLayoutConstraint activateConstraints:horizontalConstraints];
    [NSLayoutConstraint activateConstraints:verticalConstraints];

    [feedBackOverlayView.layer setBackgroundColor:[UIColor blueColor].CGColor];
    [feedBackOverlayView.superview.layer setBackgroundColor:[UIColor redColor].CGColor];
}

- (void)didTapBackground:(id)sender {

}

@end
