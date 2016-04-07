//
//  TRYFeedbackOverlayView.m
//  Pods
//
//  Created by Eray on 24/03/16.
//
//

#import "TRYFeedbackOverlayView.h"

@implementation TRYFeedbackOverlayView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self configureLayout];
    }

    return self;
}

#pragma mark - Layout

- (void)configureLayout {
    self.backgroundColor = [UIColor whiteColor];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [closeButton setTranslatesAutoresizingMaskIntoConstraints:NO];

    [closeButton setImage:[UIImage imageNamed:@"bt-close"]
                 forState:UIControlStateNormal];

    [closeButton addTarget:self
                    action:@selector(didTapCloseButton:)
          forControlEvents:UIControlEventTouchUpInside];

    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"closeButton":closeButton }];

    [self addSubview:closeButton];

    NSArray *horizontalConstraints = [NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:[closeButton]-10-|"
                                      options:NSLayoutFormatAlignAllTop
                                      metrics:nil
                                      views:views];

    NSArray *verticalConstraints = [NSLayoutConstraint
                                    constraintsWithVisualFormat:@"V:|-10-[closeButton]"
                                    options:NSLayoutFormatAlignAllTop
                                    metrics:nil
                                    views:views];

    [NSLayoutConstraint activateConstraints:horizontalConstraints];
    [NSLayoutConstraint activateConstraints:verticalConstraints];
}

#pragma mark - Actions

- (void)didTapCloseButton:(id)sender {
    [_delegate feedbackOverlayViewDidTapCloseButton:self];
}

@end
