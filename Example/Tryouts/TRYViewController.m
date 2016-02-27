//
//  TRYViewController.m
//  Tryouts
//
//  Created by Taylan Pince on 09/27/2015.
//  Copyright (c) 2015 Taylan Pince. All rights reserved.
//

#import <Tryouts/Tryouts.h>

#import "TRYViewController.h"
#import <PureLayout/PureLayout.h>

@interface TRYViewController ()

@end


@implementation TRYViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

    [feedbackButton autoCenterInSuperview];
}

#pragma mark - Actions

- (void)didTapFeedbackButton:(id)sender {
    [Tryouts presentFeedBackViewControllerFromViewController:self animated:YES];
}

@end
