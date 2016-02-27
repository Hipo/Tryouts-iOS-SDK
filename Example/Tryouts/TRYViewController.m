//
//  TRYViewController.m
//  Tryouts
//
//  Created by Taylan Pince on 09/27/2015.
//  Copyright (c) 2015 Taylan Pince. All rights reserved.
//

#import <Tryouts/Tryouts.h>

#import "TRYViewController.h"


@interface TRYViewController ()

@end


@implementation TRYViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];


    UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [feedbackButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [feedbackButton setTitleColor:[UIColor blueColor]
                         forState:UIControlStateNormal];

    [feedbackButton setTitle:NSLocalizedString(@"Feedback", nil)
                    forState:UIControlStateNormal];

    [feedbackButton setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.5]
                         forState:UIControlStateHighlighted];

    [feedbackButton addTarget:self
                       action:@selector(didTapFeedbackButton:)
             forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:feedbackButton];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:feedbackButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:feedbackButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
}

#pragma mark - Actions

- (void)didTapFeedbackButton:(id)sender {
    [Tryouts presentFeedBackViewControllerFromViewController:self animated:YES];
    
    NSLog(@"GIVE FEEDBACK");
}

@end
