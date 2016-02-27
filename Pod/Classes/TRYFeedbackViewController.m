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


    UIImageView *tryoutsIcon = [[UIImageView alloc] initForAutoLayout];

    [tryoutsIcon setImage:[UIImage imageNamed:@"icon-tryouts"]];

    [self.view addSubview:tryoutsIcon];

    [tryoutsIcon autoSetDimension:ALDimensionWidth toSize:50.0];
    [tryoutsIcon autoSetDimension:ALDimensionHeight toSize:50.0];
    [tryoutsIcon autoCenterInSuperview];
}

@end
