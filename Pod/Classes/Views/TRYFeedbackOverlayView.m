//
//  TRYFeedbackOverlayView.m
//  Pods
//
//  Created by Eray on 24/03/16.
//
//

#import "TRYFeedbackOverlayView.h"

@interface TRYFeedbackOverlayView()

@property (nonatomic, strong) UIView *shieldView;
@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) NSLayoutConstraint *panelViewConstraint;

@end

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
    //        [self setAlpha:0.0];
    //        [self setHidden:YES];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight)];

    _shieldView = [UIView new];

    [_shieldView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];

    [_shieldView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTriggerShieldTapRecognizer:)]];
    [self addSubview:_shieldView];




    _panelView = [UIView new];

    [_panelView setBackgroundColor:[UIColor whiteColor]];
    [_panelView.layer setCornerRadius:4.0];
    [_panelView.layer setMasksToBounds:YES];

    [self addSubview:_panelView];

    [self.layer setBorderWidth:1.0];

    [self configureCloseButton];
}

- (void)configureCloseButton {
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
                                    options:NSLayoutFormatAlignAllRight
                                    metrics:nil
                                    views:views];

    [NSLayoutConstraint activateConstraints:horizontalConstraints];
    [NSLayoutConstraint activateConstraints:verticalConstraints];
}

#pragma mark - Actions

- (void)didTapCloseButton:(id)sender {
    [_delegate feedbackOverlayViewDidTapCloseButton:self];
}

- (void)didTriggerShieldTapRecognizer:(UITapGestureRecognizer *)tapRecognizer {

}

@end
