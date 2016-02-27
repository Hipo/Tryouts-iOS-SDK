//
//  TRYFeedbackViewController.m
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import "TRYFeedbackViewController.h"
#import <PureLayout/PureLayout.h>

@implementation TRYFeedbackViewController

- (void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];


    UIView *feedbackView = [UIView newAutoLayoutView];

    [self.view addSubview:feedbackView];

    [feedbackView autoSetDimension:ALDimensionWidth toSize:300.0];
    [feedbackView autoSetDimension:ALDimensionHeight toSize:350.0];
    [feedbackView autoCenterInSuperview];


    UIImageView *backgroundImage = [UIImageView newAutoLayoutView];

    [backgroundImage setImage:[UIImage imageNamed:@"bg-feedback"]];

    [feedbackView addSubview:backgroundImage];

    [backgroundImage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];


    UIImageView *tryoutsIcon = [UIImageView newAutoLayoutView];

    [tryoutsIcon setImage:[UIImage imageNamed:@"icon-tryouts"]];

    [feedbackView addSubview:tryoutsIcon];

    [tryoutsIcon autoSetDimension:ALDimensionWidth toSize:80.0];
    [tryoutsIcon autoSetDimension:ALDimensionHeight toSize:80.0];
    [tryoutsIcon autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [tryoutsIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-40.0];


    UITextField *usernameField = [UITextField newAutoLayoutView];


    usernameField.placeholder = NSLocalizedString(@"Enter your username", nil);
    usernameField.textAlignment = NSTextAlignmentCenter;
    usernameField.layer.masksToBounds = YES;
    usernameField.layer.cornerRadius = 10.0;
    usernameField.layer.borderWidth = 1.0;
    usernameField.layer.borderColor = [UIColor colorWithRed:38.0
                                                      green:171
                                                       blue:188
                                                      alpha:1.0].CGColor;

    [feedbackView addSubview:usernameField];

    [usernameField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tryoutsIcon];
    [usernameField autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:40.0];
    [usernameField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:40.0];
}

@end
