//
//  TRYFeedbackOverlayView.m
//  Pods
//
//  Created by Eray on 24/03/16.
//
//

#import "TRYFeedbackOverlayView.h"


/* METRICS */

// DEFAULT
static NSString const *kDefaultVerticalOffsetKey = @"DEFAULT_VERTICAL";
static NSString const *kDefaultHorizontalOffsetKey = @"DEFAULT_HORIZONTAL";
static CGFloat  const kDefaultVerticalOffsetValue = 0.0;
static CGFloat  const kDefaultHorizontalOffsetValue = 0.0;

// PANEL VIEW
static NSString const *kPanelViewWidthKey = @"PANEL_VIEW_WIDTH";
static NSString const *kPanelViewHeightKey = @"PANEL_VIEW_HEIGHT";
static CGFloat  const kPanelViewWidthValue = 300.0;
static CGFloat  const kPanelViewHeightValue = 350.0;

// CLOSE BUTTON
static NSString const *kCloseButtonWidthKey = @"CLOSE_BUTTON_WIDTH";
static NSString const *kCloseButtonHeightKey = @"CLOSE_BUTTON_HEIGHT";
static CGFloat  const kCloseButtonWidthValue = 20.0;
static CGFloat  const kCloseButtonHeightValue = 20.0;

static NSString const *kCloseButtonTopOffsetKey = @"CLOSE_BUTTON_TOP";
static NSString const *kCloseButtonRightOffsetKey = @"CLOSE_BUTTON_RIGHT";
static CGFloat  const kCloseButtonTopOffsetValue = 10.0;
static CGFloat  const kCloseButtonRightOffsetValue = 15.0;

// TRYOUTS ICON
static NSString const *kTryoutsIconTopOffsetKey = @"TRYOUTS_ICON_TOP";
static NSString const *kTryoutsIconWidthKey = @"TRYOUTS_ICON_WIDTH";
static NSString const *kTryoutsIconHeightKey = @"TRYOUTS_ICON_HEIGHT";
static CGFloat  const kTryoutsIconTopOffsetValue = -33.0;
static CGFloat  const kTryoutsIconHeightValue = 66.0;
static CGFloat  const kTryoutsIconWidthValue = 79.0;

// USERNAME BACKGROUND
static NSString const *kUsernameBackgroundHorizontalOffsetKey = @"USERNAME_BACKG_HORIZONTAL";
static CGFloat  const kUsernameBackgroundHorizontalOffsetValue = 35.0;

// USERNAME FIELD
static NSString const *kUsernameFieldHorizontalOffsetKey = @"USERNAME_FIELD_HORIZONTAL";
static NSString const *kUsernameFieldVerticalOffsetKey = @"USERNAME_FIELD_VERTICAL";
static CGFloat  const kUsernameFieldHorizontalOffsetValue = 5.0;
static CGFloat  const kUsernameFieldVerticalOffsetValue = 5.0;

// MESSAGE VIEW BACKGROUND
static NSString const *kMessageViewBackgroundHorizontalOffsetKey = @"MESSAGE_VIEW_BACKG_HORIZONTAL";
static NSString const *kMessageViewBackgroundTopOffsetKey = @"MESSAGE_VIEW_BACKG_TOP";
static CGFloat  const kMessageViewBackgroundHorizontalOffsetValue = 35.0;
static CGFloat  const kMessageViewBackgroundTopOffsetValue = 30.0;

// MESSAGE VIEW

// SUBMIT BUTTON
static NSString const *kSubmitButtonHorizontalOffsetKey = @"SUBMIT_BUTTON_HORIZONTAL";
static NSString const *kSubmitButtonTopOffsetKey = @"SUBMIT_BUTTON_TOP";
static CGFloat  const kSubmitButtonHorizontalOffsetValue = 35.0;
static CGFloat  const kSubmitButtonTopOffsetValue = 30.0;


@interface TRYFeedbackOverlayView()

@property (nonatomic, strong) UIView *shieldView;
@property (nonatomic, strong) UIImageView *panelView;
@property (nonatomic, strong) UIImageView *usernameBackgroundView;
@property (nonatomic, strong) UIImageView *messageBackgroundView;
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

    // Tryouts icon
    UIImageView *tryoutsIconView = [self configureTryoutsIconView];

    // Username field background
    [self configureUsernameBackgroundView];

    // Username field
    UITextField *usernameField = [self configureUsernameField];

    // Message view background
    [self configureMessageBackgroundView];

    // Message view

    // Submit button
    UIButton *submitButton = [self configureSubmitButton];

    // Auto layout constraints
    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"shieldView"         : _shieldView,
                                                        @"panelView"          : _panelView,
                                                        @"closeButton"        : closeButton,
                                                        @"usernameBackground" : _usernameBackgroundView,
                                                        @"tryoutsIcon"        : tryoutsIconView,
                                                        @"usernameField"      : usernameField,
                                                        @"messageBackground"  : _messageBackgroundView,
                                                        @"submitButton"       : submitButton }];

    NSDictionary *defaultMetrics =
    @{ kDefaultHorizontalOffsetKey               : @(kDefaultHorizontalOffsetValue),
       kDefaultVerticalOffsetKey                 : @(kDefaultVerticalOffsetValue),
       kPanelViewWidthKey                        : @(kPanelViewWidthValue),
       kPanelViewHeightKey                       : @(kPanelViewHeightValue),
       kCloseButtonWidthKey                      : @(kCloseButtonWidthValue),
       kCloseButtonHeightKey                     : @(kCloseButtonHeightValue),
       kCloseButtonRightOffsetKey                : @(kCloseButtonRightOffsetValue),
       kCloseButtonTopOffsetKey                  : @(kCloseButtonTopOffsetValue),
       kTryoutsIconTopOffsetKey                  : @(kTryoutsIconTopOffsetValue),
       kUsernameBackgroundHorizontalOffsetKey    : @(kUsernameBackgroundHorizontalOffsetValue),
       kTryoutsIconWidthKey                      : @(kTryoutsIconWidthValue),
       kTryoutsIconHeightKey                     : @(kTryoutsIconHeightValue),
       kUsernameFieldHorizontalOffsetKey         : @(kUsernameFieldHorizontalOffsetValue),
       kUsernameFieldVerticalOffsetKey           : @(kUsernameFieldVerticalOffsetValue),
       kMessageViewBackgroundHorizontalOffsetKey : @(kMessageViewBackgroundHorizontalOffsetValue),
       kMessageViewBackgroundTopOffsetKey        : @(kMessageViewBackgroundTopOffsetValue),
       kSubmitButtonHorizontalOffsetKey          : @(kSubmitButtonHorizontalOffsetValue),
       kSubmitButtonTopOffsetKey                 : @(kSubmitButtonTopOffsetValue) };

//    static NSString const *kSubmitButtonHorizontalOffsetKey = @"SUBMIT_BUTTON_HORIZONTAL";
//    static NSString const *kSubmitButtonTopOffsetKey = @"SUBMIT_BUTTON_TOP";
//    static CGFloat  const kSubmitButtonHorizontalOffsetValue = 35.0;
//    static CGFloat  const kSubmitButtonTopOffsetValue = 30.0;



    // Auto layout constraints - Shield view
    NSArray *shieldViewHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-DEFAULT_HORIZONTAL-[shieldView]-DEFAULT_HORIZONTAL-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    NSArray *shieldViewVerticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-DEFAULT_VERTICAL-[shieldView]-DEFAULT_VERTICAL-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    // Auto layout constraints - Panel view
    NSArray *panelViewHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[panelView(PANEL_VIEW_WIDTH)]"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    NSArray *panelViewVerticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:[panelView(PANEL_VIEW_HEIGHT)]"
                              options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    NSLayoutConstraint *panelViewCenterHorizontallyConstraint =
    [self centerHorizontallyConstraintForView:_panelView];

    NSLayoutConstraint *panelViewCenterVerticallyConstraint =
    [self centerVerticallyConstraintForView:_panelView];

    // Auto layout constraints - Close button
    NSArray *closeButtonHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[closeButton(CLOSE_BUTTON_WIDTH)]-CLOSE_BUTTON_RIGHT-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    NSArray *closeButtonVerticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CLOSE_BUTTON_TOP-[closeButton(CLOSE_BUTTON_HEIGHT)]"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];


    // Auto layout constraints - Username field background
    NSArray *usernameBackgroundHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-USERNAME_BACKG_HORIZONTAL-[usernameBackground]-USERNAME_BACKG_HORIZONTAL-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    // Auto layout constraints - Tryouts icon
    NSLayoutConstraint *tryoutsIconCenterHorizontallyConstraint =
    [self centerHorizontallyConstraintForView:tryoutsIconView];

    NSArray *tryoutsIconHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[tryoutsIcon(TRYOUTS_ICON_WIDTH)]"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];


    // Auto layout constraints - Username field
    NSArray *usernameFieldHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-USERNAME_FIELD_HORIZONTAL-[usernameField]-USERNAME_FIELD_HORIZONTAL-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    NSArray *usernameFieldVerticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-USERNAME_FIELD_VERTICAL-[usernameField]-USERNAME_FIELD_VERTICAL-|"
                              options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    // Auto layout constraints - Message view background
    NSArray *messageBackgroundHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-MESSAGE_VIEW_BACKG_HORIZONTAL-[messageBackground]-MESSAGE_VIEW_BACKG_HORIZONTAL-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    // Auto layout constraints - Message view

    // Auto layout constraints - Submit Button
    NSArray *submitButtonHorizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SUBMIT_BUTTON_HORIZONTAL-[submitButton]-SUBMIT_BUTTON_HORIZONTAL-|"
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:defaultMetrics
                                              views:views];

    // Auto layout constraints - Multiple views
    NSArray *allViewsVerticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-TRYOUTS_ICON_TOP-[tryoutsIcon(TRYOUTS_ICON_HEIGHT)]-DEFAULT_VERTICAL-[usernameBackground]-MESSAGE_VIEW_BACKG_TOP-[messageBackground]-SUBMIT_BUTTON_TOP-[submitButton]"
                                            options:NSLayoutFormatAlignAllCenterX
                                            metrics:defaultMetrics
                                              views:views];


    // Activating constraints
    [NSLayoutConstraint activateConstraints:panelViewHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:panelViewVerticalConstraints];
    [NSLayoutConstraint activateConstraints:shieldViewHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:shieldViewVerticalConstraints];
    [NSLayoutConstraint activateConstraints:closeButtonHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:closeButtonVerticalConstraints];
    [NSLayoutConstraint activateConstraints:tryoutsIconHorizontalConstraints];
    
    [NSLayoutConstraint activateConstraints:@[panelViewCenterHorizontallyConstraint,
                                              panelViewCenterVerticallyConstraint,
                                              tryoutsIconCenterHorizontallyConstraint]];

    [NSLayoutConstraint activateConstraints:usernameBackgroundHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:usernameFieldHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:usernameFieldVerticalConstraints];
    [NSLayoutConstraint activateConstraints:messageBackgroundHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:submitButtonHorizontalConstraints];
    [NSLayoutConstraint activateConstraints:allViewsVerticalConstraints];
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

    [_panelView setImage:[[self imageWithName:@"bg-feedback"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 15.0, 20.0, 15.0)
                          resizingMode:UIImageResizingModeStretch]];

    [_shieldView addSubview:_panelView];
}

- (UIButton *)configureCloseButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);

    [closeButton setImage:[self imageWithName:@"bt-close"]
                 forState:UIControlStateNormal];

    [closeButton addTarget:self
                    action:@selector(didTapCloseButton:)
          forControlEvents:UIControlEventTouchUpInside];

    [_panelView addSubview:closeButton];

    return closeButton;
}

- (UIImageView *)configureTryoutsIconView {
    UIImageView *iconView = [[UIImageView alloc]
                             initWithImage:[self imageWithName:@"im-tryouts-icon"]];

    iconView.translatesAutoresizingMaskIntoConstraints = NO;

    [_panelView addSubview:iconView];

    return iconView;
}

- (void)configureUsernameBackgroundView {
    _usernameBackgroundView = [[UIImageView alloc]
                               initWithImage:[[self imageWithName:@"bg-rounded-blue"]
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

- (void)configureMessageBackgroundView {
    _messageBackgroundView = [[UIImageView alloc]
                              initWithImage:[[self imageWithName:@"bg-rounded-orange"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
                                             resizingMode:UIImageResizingModeStretch]];

    _messageBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _messageBackgroundView.userInteractionEnabled = YES;

    [_panelView addSubview:_messageBackgroundView];
}

- (UIButton *)configureSubmitButton {
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];

    submitButton.translatesAutoresizingMaskIntoConstraints = NO;

    [submitButton setBackgroundImage:[[self imageWithName:@"bg-rounded-green"]
                                      resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0)
                                      resizingMode:UIImageResizingModeStretch]
                            forState:UIControlStateNormal];

    [submitButton setTitle:@"SUBMIT"
                  forState:UIControlStateNormal];

    [_panelView addSubview:submitButton];
    
    return submitButton;
}

#pragma mark - Actions

- (void)didTapCloseButton:(id)sender {
    [self endEditing:YES];
    
    [_delegate feedbackOverlayViewDidTapCloseButton:self];
}

- (void)didTriggerShieldTapRecognizer:(UITapGestureRecognizer *)tapRecognizer {

}

#pragma mark - Helper Methods

- (NSLayoutConstraint *)centerHorizontallyConstraintForView:(UIView *)view {
    NSLayoutConstraint *centerHorizontallyConstraint = [NSLayoutConstraint
                                                        constraintWithItem:view
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                        toItem:view.superview
                                                        attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                        constant:0.0];
    return centerHorizontallyConstraint;
}
- (NSLayoutConstraint *)centerVerticallyConstraintForView:(UIView *)view {
    NSLayoutConstraint *panelViewCenterVerticallyConstraint = [NSLayoutConstraint
                                                               constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                               toItem:view.superview
                                                               attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                               constant:20.0];
    return panelViewCenterVerticallyConstraint;
}

- (UIImage *)imageWithName:(NSString *)imageName {
    NSBundle *topBundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [topBundle URLForResource:@"Tryouts" withExtension:@"bundle"];
    NSBundle *bundle;

    if (url != nil) {
        bundle = [NSBundle bundleWithURL:url];
    } else {
        bundle = topBundle;
    }

    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];

    return image;
}

@end
