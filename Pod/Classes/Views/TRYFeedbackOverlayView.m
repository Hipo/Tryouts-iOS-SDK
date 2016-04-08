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
@property (nonatomic, strong) UIImageView *panelView;
@property (nonatomic, strong) UIImageView *usernameBackgroundView;
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

    // Username field
    [self configureUsernameBackgroundView];

    UITextField *usernameField = [self configureUsernameField];


    // Auto layout constraints
    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"shieldView"         : _shieldView,
                                                        @"panelView"          : _panelView,
                                                        @"closeButton"        : closeButton,
                                                        @"usernameBackground" : _usernameBackgroundView,
                                                        @"usernameField"      : usernameField }];

    // Auto layout constraints - Shield view
    NSArray *shieldViewHorizontalConstraints = [self constraintsWithFormatString:@"H:|-(-10)-[shieldView]-(-10)-|"
                                                                        andViews:views];

    NSArray *shieldViewVerticalConstraints = [self constraintsWithFormatString:@"V:|-(-10)-[shieldView]-(-10)-|"
                                                                      andViews:views];

    // Auto layout constraints - Panel view
    NSArray *panelViewHorizontalConstraints = [self constraintsWithFormatString:@"H:[panelView(300)]"
                                                                       andViews:views];

    NSArray *panelViewVerticalConstraints = [self constraintsWithFormatString:@"V:[panelView(350)]"
                                                                     andViews:views];

    NSLayoutConstraint *panelViewCenterHorizontallyConstraint = [NSLayoutConstraint
                                                                 constraintWithItem:_panelView
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:_panelView.superview
                                                                          attribute:NSLayoutAttributeCenterX
                                                                         multiplier:1.0
                                                                           constant:0.0];

    NSLayoutConstraint *panelViewCenterVerticallyConstraint = [NSLayoutConstraint
                                                               constraintWithItem:_panelView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_panelView.superview
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:20.0];


    // Auto layout constraints - Close button
    NSArray *closeButtonHorizontalConstraints = [self constraintsWithFormatString:@"H:[closeButton(20)]-15-|"
                                                                         andViews:views];

    NSArray *closeButtonVerticalConstraints = [self constraintsWithFormatString:@"V:|-10-[closeButton(20)]"
                                                                       andViews:views];

    // Auto layout constraints - Username field
    NSArray *usernameBackgroundHorizontalConstraints = [self constraintsWithFormatString:@"H:|-35-[usernameBackground]-35-|"
                                                                                andViews:views];

    NSArray *usernameBackgroundVerticalConstraints = [self constraintsWithFormatString:@"V:|-40-[usernameBackground]"
                                                                              andViews:views];


    // Auto layout constraints - Username field
    NSArray *usernameFieldHorizontalConstraints = [self constraintsWithFormatString:@"H:|-5-[usernameField]-5-|"
                                                                           andViews:views];

    NSArray *usernameFieldVerticalConstraints = [self constraintsWithFormatString:@"V:|-5-[usernameField]-5-|"
                                                                         andViews:views];

    // Activating constraints
    [NSLayoutConstraint activateConstraints:panelViewHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:panelViewVerticalConstraints];
    [NSLayoutConstraint activateConstraints:shieldViewHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:shieldViewVerticalConstraints];
    [NSLayoutConstraint activateConstraints:closeButtonHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:closeButtonVerticalConstraints];
    [NSLayoutConstraint activateConstraints:@[panelViewCenterHorizontallyConstraint,
                                              panelViewCenterVerticallyConstraint]];

    [NSLayoutConstraint activateConstraints:usernameBackgroundHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:usernameBackgroundVerticalConstraints];
    [NSLayoutConstraint activateConstraints:usernameFieldHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:usernameFieldVerticalConstraints];
}

- (void)configureShieldView {
    _shieldView = [UIView new];

    _shieldView.translatesAutoresizingMaskIntoConstraints = NO;
    _shieldView.backgroundColor = [UIColor clearColor];

    [_shieldView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTriggerShieldTapRecognizer:)]];
    [self addSubview:_shieldView];
}

- (void)configurePanelView {
    _panelView = [UIImageView new];

    _panelView.translatesAutoresizingMaskIntoConstraints = NO;
    _panelView.userInteractionEnabled = YES;

    [_panelView setImage:[[UIImage imageNamed:@"bg-feedback"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 15.0, 20.0, 15.0)
                          resizingMode:UIImageResizingModeStretch]];

    [_shieldView addSubview:_panelView];
}

- (UIButton *)configureCloseButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);

    [closeButton setImage:[UIImage imageNamed:@"bt-close"]
                 forState:UIControlStateNormal];

    [closeButton addTarget:self
                    action:@selector(didTapCloseButton:)
          forControlEvents:UIControlEventTouchUpInside];

    [_panelView addSubview:closeButton];

    return closeButton;
}

- (void)configureUsernameBackgroundView {
    _usernameBackgroundView = [[UIImageView alloc]
                               initWithImage:[[UIImage imageNamed:@"bg-rounded-blue"]
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0)
                                              resizingMode:UIImageResizingModeStretch]];

    _usernameBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _usernameBackgroundView.userInteractionEnabled = YES;

    [_panelView addSubview:_usernameBackgroundView];
}

- (UITextField *)configureUsernameField {
    UITextField *usernameField = [UITextField new];

    usernameField.translatesAutoresizingMaskIntoConstraints = NO;
    usernameField.placeholder = NSLocalizedString(@"USERNAME", nil);
    usernameField.textAlignment = NSTextAlignmentCenter;
    usernameField.font = [UIFont systemFontOfSize:10.0
                                           weight:UIFontWeightRegular];

    [_usernameBackgroundView addSubview:usernameField];

    return usernameField;
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
