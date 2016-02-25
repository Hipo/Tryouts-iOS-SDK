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

    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [feedbackButton setFrame:CGRectMake((self.view.bounds.size.width / 2) - 50,
                                        self.view.bounds.size.height / 2,
                                        100,
                                        25.0)];

    [feedbackButton.layer setBorderWidth:1.0];

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
}

#pragma mark - Actions

- (void)didTapFeedbackButton:(id)sender {
    NSLog(@"GIVE FEEDBACK");
}

@end
