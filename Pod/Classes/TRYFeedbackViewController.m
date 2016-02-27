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


    UIImageView *backgroundView = [UIImageView newAutoLayoutView];

    [backgroundView setImage:[UIImage imageNamed:@"bg-feedback"]];
    [backgroundView.layer setBorderWidth:1.0];
    [backgroundView.layer setBorderColor:[UIColor redColor].CGColor];

    [self.view addSubview:backgroundView];

    [backgroundView autoSetDimension:ALDimensionWidth toSize:180.0];
    [backgroundView autoSetDimension:ALDimensionHeight toSize:211.0];
    [backgroundView autoCenterInSuperview];


    UIImageView *tryoutsIcon = [UIImageView newAutoLayoutView];

    [tryoutsIcon setImage:[UIImage imageNamed:@"icon-tryouts"]];
    [tryoutsIcon.layer setBorderWidth:1.0];
    [tryoutsIcon.layer setBorderColor:[UIColor greenColor].CGColor];

    [backgroundView addSubview:tryoutsIcon];

    [tryoutsIcon autoSetDimension:ALDimensionWidth toSize:50.0];
    [tryoutsIcon autoSetDimension:ALDimensionHeight toSize:50.0];
    [tryoutsIcon autoCenterInSuperview];
}

@end
