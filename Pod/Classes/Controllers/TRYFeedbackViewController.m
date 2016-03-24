//
//  TRYFeedbackViewController.m
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import "TRYFeedbackViewController.h"
#import "PureLayout.h"
#import "TRYFeedbackOverlayView.h"

@implementation TRYFeedbackViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                             action:@selector(didTapBackground:)]];

    
    TRYFeedbackOverlayView *feedBackOverlayView = [TRYFeedbackOverlayView newAutoLayoutView];

    [self.view addSubview:feedBackOverlayView];

    [feedBackOverlayView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(30.0, 30.0, 30.0, 30.0)];

    [feedBackOverlayView.layer setBorderWidth:1.0];
    [feedBackOverlayView.layer setBorderColor:[UIColor blueColor].CGColor];

    [feedBackOverlayView.superview.layer setBorderWidth:1.0];
    [feedBackOverlayView.superview.layer setBorderColor:[UIColor redColor].CGColor];
}

- (void)didTapBackground:(id)sender {

}

@end
