//
//  TRYViewController.m
//  Tryouts
//
//  Created by Taylan Pince on 09/27/2015.
//  Copyright (c) 2015 Taylan Pince. All rights reserved.
//

#import <Tryouts/Tryouts.h>

#import "TRYViewController.h"
#import <Tryouts/TRYFeedbackViewController.h>

@interface TRYViewController () <TRYFeedbackViewControllerDelegate>

@end


@implementation TRYViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];

    feedbackButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [feedbackButton setTitle:NSLocalizedString(@"Feedback", nil)
                    forState:UIControlStateNormal];

    [feedbackButton setTitleColor:[UIColor blueColor]
                         forState:UIControlStateNormal];

    [feedbackButton setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.5]
                         forState:UIControlStateHighlighted];

    [feedbackButton addTarget:self
                       action:@selector(didTapFeedbackButton:)
             forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:feedbackButton];

    NSLayoutConstraint *feedbackButtonCenterHorizontallyConstraint = [NSLayoutConstraint
                                                                      constraintWithItem:feedbackButton
                                                                      attribute:NSLayoutAttributeCenterX
                                                                      relatedBy:NSLayoutRelationEqual
                                                                      toItem:feedbackButton.superview
                                                                      attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.0
                                                                      constant:0.0];

    NSLayoutConstraint *feedbackButtonCenterVerticallyConstraint = [NSLayoutConstraint
                                                                    constraintWithItem:feedbackButton
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                    toItem:feedbackButton.superview
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                    constant:0.0];


    [NSLayoutConstraint activateConstraints:@[feedbackButtonCenterHorizontallyConstraint,
                                              feedbackButtonCenterVerticallyConstraint]];
}

#pragma mark - Actions

- (void)didTapFeedbackButton:(id)sender {
    [Tryouts presentFeedBackViewControllerFromViewController:self
                                                    animated:YES];
}

#pragma mark - Feedback view controller delegate 

- (void)feedbackViewControllerDismissed:(TRYFeedbackViewController *)feedbackViewController {
    NSLog(@"FEEDBACK VIEW CONTROLLER DISMISSED");
}

@end
