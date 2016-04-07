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

    // Shield view
    [self configureShieldView];

    // Panel view
    [self configurePanelView];

    // Close button
    UIButton *closeButton = [self configureCloseButton];

    // Auto layout constraints
    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"shieldView"  : _shieldView,
                                                        @"panelView"   : _panelView,
                                                        @"closeButton" : closeButton }];

    NSArray *closeButtonHorizontalConstraints = [self constraintsWithFormatString:@"H:[closeButton]-10-|"
                                                                         andViews:views];

    NSArray *closeButtonVerticalConstraints = [self constraintsWithFormatString:@"V:|-10-[closeButton]"
                                                                       andViews:views];

    [NSLayoutConstraint activateConstraints:closeButtonHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:closeButtonVerticalConstraints];

    [self.layer setBorderWidth:1.0];
}

- (void)configureShieldView {
    _shieldView = [UIView new];

    [_shieldView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];

    [_shieldView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTriggerShieldTapRecognizer:)]];
    [self addSubview:_shieldView];
}

- (void)configurePanelView {
    _panelView = [UIView new];

    [_panelView setBackgroundColor:[UIColor whiteColor]];
    [_panelView.layer setCornerRadius:4.0];
    [_panelView.layer setMasksToBounds:YES];

    [self addSubview:_panelView];
}

- (UIButton *)configureCloseButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [closeButton setTranslatesAutoresizingMaskIntoConstraints:NO];

    [closeButton setImage:[UIImage imageNamed:@"bt-close"]
                 forState:UIControlStateNormal];

    [closeButton addTarget:self
                    action:@selector(didTapCloseButton:)
          forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:closeButton];

    return closeButton;
}

#pragma mark - Actions

- (void)didTapCloseButton:(id)sender {
    [_delegate feedbackOverlayViewDidTapCloseButton:self];
}

- (void)didTriggerShieldTapRecognizer:(UITapGestureRecognizer *)tapRecognizer {

}

#pragma mark - Helper Methods

- (NSArray *)constraintsWithFormatString:(NSString *)formatString
                                andViews:(NSArray *)views {

    return [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                   options:NSLayoutFormatAlignAllTop
                                                   metrics:nil
                                                     views:views];
}

@end
