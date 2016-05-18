//
//  TRYFeedbackOverlayView.m
//  Pods
//
//  Created by Eray on 24/03/16.
//
//

#import "TRYFeedbackOverlayView.h"
#import "TRYMessageView.h"

// NSUserDefaults
static NSString const *kNSUserDefaulsUsernameKey = @"com.hipo.tryouts.kNSUserDefaultsUsername";

/* METRICS */

// DEFAULT
static NSString const *kZeroVerticalOffsetKey = @"ZERO_VERTICAL";
static NSString const *kZeroHorizontalOffsetKey = @"ZERO_HORIZONTAL";

static CGFloat  const kZeroVerticalOffsetValue = 0.0;
static CGFloat  const kZeroHorizontalOffsetValue = 0.0;

// PANEL VIEW
static NSString const *kPanelViewWidthKey = @"PANEL_VIEW_WIDTH";
static NSString const *kPanelViewHeightKey = @"PANEL_VIEW_HEIGHT";

static CGFloat  const kPanelViewWidthValue = 290.0;
static CGFloat  const kPanelViewHeightValue = 313.0;
static CGFloat  const kPanelViewTopOffset = 50.0;

// CLOSE BUTTON
static NSString const *kCloseButtonWidthKey = @"CLOSE_BUTTON_WIDTH";
static NSString const *kCloseButtonHeightKey = @"CLOSE_BUTTON_HEIGHT";
static NSString const *kCloseButtonTopOffsetKey = @"CLOSE_BUTTON_TOP";
static NSString const *kCloseButtonRightOffsetKey = @"CLOSE_BUTTON_RIGHT";

static CGFloat  const kCloseButtonWidthValue = 30.0;
static CGFloat  const kCloseButtonHeightValue = 30.0;
static CGFloat  const kCloseButtonTopOffsetValue = 10.0;
static CGFloat  const kCloseButtonRightOffsetValue = 15.0;

// TRYOUTS ICON
static NSString const *kTryoutsIconTopOffsetKey = @"TRYOUTS_ICON_TOP";
static NSString const *kTryoutsIconWidthKey = @"TRYOUTS_ICON_WIDTH";
static NSString const *kTryoutsIconHeightKey = @"TRYOUTS_ICON_HEIGHT";

static CGFloat  const kTryoutsIconTopOffsetValue = -33.0;
static CGFloat  const kTryoutsIconWidthValue = 90.0;
static CGFloat  const kTryoutsIconHeightValue = 85.0;

// USERNAME BACKGROUND
static NSString const *kUsernameBackgroundHorizontalOffsetKey = @"USERNAME_BACKG_HORIZONTAL";
static CGFloat  const kUsernameBackgroundHorizontalOffsetValue = 35.0;

static NSString const *kUsernameBackgroundHeightKey = @"USERNAME_BACKG_HEIGHT";
static CGFloat  const kUsernameBackgroundHeightValue = 36.0;

// USERNAME FIELD
static NSString const *kUsernameFieldHorizontalDefaultOffsetKey = @"USERNAME_FIELD_HORIZONTAL_DEFAULT";
static NSString const *kUsernameFieldVerticalOffsetKey = @"USERNAME_FIELD_VERTICAL";

static CGFloat  const kUsernameFieldHorizontalDefaultOffsetValue = 30.0;
static CGFloat  const kUsernameFieldVerticalOffsetValue = 5.0;

// MESSAGE VIEW BACKGROUND
static NSString const *kMessageViewBackgroundHorizontalOffsetKey = @"MESSAGE_VIEW_BACKG_HORIZONTAL";
static NSString const *kMessageViewBackgroundTopOffsetKey = @"MESSAGE_VIEW_BACKG_TOP";

static CGFloat  const kMessageViewBackgroundHorizontalOffsetValue = 35.0;
static CGFloat  const kMessageViewBackgroundTopOffsetValue = 20.0;

// MESSAGE VIEW
static NSString const *kMessageViewHorizontalOffsetKey = @"MESSAGE_VIEW_HORIZONTAL";
static NSString const *kMessageViewVerticalOffsetKey = @"MESSAGE_VIEW_VERTICAL";

static CGFloat  const kMessageViewHorizontalOffsetValue = 5.0;
static CGFloat  const kMessageViewVerticalOffsetValue = 5.0;

// SUBMIT BUTTON
static NSString const *kSubmitButtonHorizontalOffsetKey = @"SUBMIT_BUTTON_HORIZONTAL";
static NSString const *kSubmitButtonTopOffsetKey = @"SUBMIT_BUTTON_TOP";
static NSString const *kSubmitButtonBottomOffsetKey = @"SUBMIT_BUTTON_BOTTOM";
static NSString const *kSubmitButtonHeightKey = @"SUBMIT_BUTTON_HEIGHT";

static CGFloat  const kSubmitButtonHorizontalOffsetValue = 35.0;
static CGFloat  const kSubmitButtonTopOffsetValue = 20.0;
static CGFloat  const kSubmitButtonBottomOffsetValue = 30.0;
static CGFloat  const kSubmitButtonHeightValue = 40.0;


@interface TRYFeedbackOverlayView() < UITextFieldDelegate, UITextViewDelegate,
                                      UIScrollViewDelegate >

@property (nonatomic, strong) UIScrollView *shieldView;
@property (nonatomic, strong) UIView *shieldContentView;
@property (nonatomic, strong) UIImageView *panelView;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIImageView *usernameBackgroundView;
@property (nonatomic, strong) UIImageView *messageBackgroundView;
@property (nonatomic, strong) NSLayoutConstraint *panelViewTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *panelViewVerticalCenterConstraint;


- (void)configureLayout;
- (void)configureShieldView;
- (void)configurePanelView;
- (UIButton *)configureCloseButton;
- (UIImageView *)configureTryoutsIconView;
- (void)configureUsernameBackgroundView;
- (void)configureUsernameField;
- (void)configureClearButton;
- (void)configureMessageBackgroundView;
- (void)configureMessageView;
- (UIButton *)configureSubmitButton;

- (void)didTapCloseButton:(id)sender;
- (void)didTapSubmitButton:(id)sender;
- (void)didTriggerShieldTapRecognizer:(UITapGestureRecognizer *)tapRecognizer;

- (void)registerForKeyboardAndOrientaionNotifications;
- (void)didReceiveKeyboardWillShowNotification:(NSNotification *)notification;
- (void)didReceiveKeyboardWillHideNotification:(NSNotification *)notification;

- (NSLayoutConstraint *)centerHorizontallyConstraintForView:(UIView *)view;
- (NSLayoutConstraint *)centerVerticallyConstraintForView:(UIView *)view
                                             withConstant:(CGFloat)constant;
- (void)showShakeAnimationForUsernameField;
- (void)focusOnUsernameField;

@end

@implementation TRYFeedbackOverlayView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self configureLayout];

        [self registerForKeyboardAndOrientaionNotifications];
    }

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Layout

- (void)configureLayout {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight)];

    // Shield view
    [self configureShieldView];

    // Shield content view
    [self configureShieldContentView];

    // Panel view
    [self configurePanelView];

    // Close button
    UIButton *closeButton = [self configureCloseButton];

    // Tryouts icon
    UIImageView *tryoutsIconView = [self configureTryoutsIconView];

    // Username field background
    [self configureUsernameBackgroundView];

    // Username field
    [self configureUsernameField];

    // Clear button
    [self configureClearButton];

    // Message view background
    [self configureMessageBackgroundView];

    // Message view
    [self configureMessageView];

    // Submit button
    UIButton *submitButton = [self configureSubmitButton];

    // Auto layout constraints
    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"shieldView"         : _shieldView,
                                                        @"shieldContentView"  : _shieldContentView,
                                                        @"panelView"          : _panelView,
                                                        @"closeButton"        : closeButton,
                                                        @"usernameBackground" : _usernameBackgroundView,
                                                        @"tryoutsIcon"        : tryoutsIconView,
                                                        @"usernameField"      : _usernameField,
                                                        @"clearButton"        : _clearButton,
                                                        @"messageBackground"  : _messageBackgroundView,
                                                        @"submitButton"       : submitButton,
                                                        @"messageView"        : _messageView }];
    
    NSDictionary *defaultMetrics =
    @{ kZeroHorizontalOffsetKey                  : @(kZeroHorizontalOffsetValue),
       kZeroVerticalOffsetKey                    : @(kZeroVerticalOffsetValue),
       kPanelViewWidthKey                        : @(kPanelViewWidthValue),
       kPanelViewHeightKey                       : @(kPanelViewHeightValue),
       kCloseButtonWidthKey                      : @(kCloseButtonWidthValue),
       kCloseButtonHeightKey                     : @(kCloseButtonHeightValue),
       kCloseButtonRightOffsetKey                : @(kCloseButtonRightOffsetValue),
       kCloseButtonTopOffsetKey                  : @(kCloseButtonTopOffsetValue),
       kTryoutsIconTopOffsetKey                  : @(kTryoutsIconTopOffsetValue),
       kUsernameBackgroundHorizontalOffsetKey    : @(kUsernameBackgroundHorizontalOffsetValue),
       kUsernameBackgroundHeightKey              : @(kUsernameBackgroundHeightValue),
       kTryoutsIconWidthKey                      : @(kTryoutsIconWidthValue),
       kTryoutsIconHeightKey                     : @(kTryoutsIconHeightValue),
       kUsernameFieldHorizontalDefaultOffsetKey  : @(kUsernameFieldHorizontalDefaultOffsetValue),
       kUsernameFieldVerticalOffsetKey           : @(kUsernameFieldVerticalOffsetValue),
       kMessageViewBackgroundHorizontalOffsetKey : @(kMessageViewBackgroundHorizontalOffsetValue),
       kMessageViewBackgroundTopOffsetKey        : @(kMessageViewBackgroundTopOffsetValue),
       kMessageViewHorizontalOffsetKey           : @(kMessageViewHorizontalOffsetValue),
       kMessageViewVerticalOffsetKey             : @(kMessageViewVerticalOffsetValue),
       kSubmitButtonHorizontalOffsetKey          : @(kSubmitButtonHorizontalOffsetValue),
       kSubmitButtonTopOffsetKey                 : @(kSubmitButtonTopOffsetValue),
       kSubmitButtonBottomOffsetKey              : @(kSubmitButtonBottomOffsetValue),
       kSubmitButtonHeightKey                    : @(kSubmitButtonHeightValue) };


    // Auto layout constraints - Shield view - Horizontal
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-ZERO_HORIZONTAL-[shieldView]-ZERO_HORIZONTAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Shield view - Vertical Top
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-ZERO_VERTICAL-[shieldView]-ZERO_VERTICAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Shield Content view - Vertical
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-ZERO_VERTICAL-[shieldContentView]-ZERO_VERTICAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Shield Content view - Height
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_shieldContentView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:_shieldContentView.superview
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                   constant:0.0]];

    // Auto layout constraints - Shield Content view - Width
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_shieldContentView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:_shieldContentView.superview
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1.0
                                   constant:0.0]];

    // Auto layout constraints - Panel view - Set width
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:[panelView(PANEL_VIEW_WIDTH)]"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Panel view - Set height
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:[panelView(PANEL_VIEW_HEIGHT)]"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Panel view - Center Horizontal
    [self addConstraint:[self centerHorizontallyConstraintForView:_panelView]];

    // Auto layout constraints - Panel view - Center Vertical
    _panelViewVerticalCenterConstraint = [self centerVerticallyConstraintForView:_panelView
                                                                    withConstant:60.0];
    [self addConstraint:_panelViewVerticalCenterConstraint];

    // Auto layout constraints - Panel view - Pin top
    _panelViewTopConstraint = [NSLayoutConstraint constraintWithItem:_panelView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_panelView.superview
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:kPanelViewTopOffset];

    [self addConstraint:_panelViewTopConstraint];

    [NSLayoutConstraint deactivateConstraints:@[_panelViewTopConstraint]];

    // Auto layout constraints - Close button - Horizontal
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:[closeButton(CLOSE_BUTTON_WIDTH)]-CLOSE_BUTTON_RIGHT-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Close button - Vertical
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-CLOSE_BUTTON_TOP-[closeButton(CLOSE_BUTTON_HEIGHT)]"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Username field background - Horizontal
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-USERNAME_BACKG_HORIZONTAL-[usernameBackground]-USERNAME_BACKG_HORIZONTAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Tryouts icon - Center Horizontal
    [self addConstraint:[self centerHorizontallyConstraintForView:tryoutsIconView]];

    // Auto layout constraints - Tryouts icon - Set width
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:[tryoutsIcon(TRYOUTS_ICON_WIDTH)]"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Username field - Horizontal - Right constraint
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-USERNAME_FIELD_HORIZONTAL_DEFAULT-[usernameField]-ZERO_HORIZONTAL-[clearButton]-|"
                          options:0
                          metrics:defaultMetrics
                          views:views]];

    // Auto layout constraints - Username field - Vertical
    [self addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:
                         @"V:|-USERNAME_FIELD_VERTICAL-[usernameField]-USERNAME_FIELD_VERTICAL-|"
                                             options:0
                                             metrics:defaultMetrics
                                               views:views]];

    // Auto layout constraints - Clear Button - Equalize width to its height
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_clearButton
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_clearButton
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0.0]];

    // Auto layout constraints - Clear Button - Vertical
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-USERNAME_FIELD_VERTICAL-[clearButton]-USERNAME_FIELD_VERTICAL-|"
                          options:0
                          metrics:defaultMetrics
                          views:views]];

    // Auto layout constraints - Message view background - Horizontal
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-MESSAGE_VIEW_BACKG_HORIZONTAL-[messageBackground]-MESSAGE_VIEW_BACKG_HORIZONTAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Message view - Horizontal
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-MESSAGE_VIEW_HORIZONTAL-[messageView]-MESSAGE_VIEW_HORIZONTAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Message view - Vertical
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|-MESSAGE_VIEW_VERTICAL-[messageView]-MESSAGE_VIEW_VERTICAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Submit Button - Horizontal
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|-SUBMIT_BUTTON_HORIZONTAL-[submitButton]-SUBMIT_BUTTON_HORIZONTAL-|"
                                              options:0
                                              metrics:defaultMetrics
                                                views:views]];

    // Auto layout constraints - Multiple views - Vertical
    [self addConstraints:
    [NSLayoutConstraint constraintsWithVisualFormat:
     @"V:|-TRYOUTS_ICON_TOP-[tryoutsIcon(TRYOUTS_ICON_HEIGHT)]-ZERO_VERTICAL-[usernameBackground(USERNAME_BACKG_HEIGHT)]-MESSAGE_VIEW_BACKG_TOP-[messageBackground]-SUBMIT_BUTTON_TOP-[submitButton(SUBMIT_BUTTON_HEIGHT)]-SUBMIT_BUTTON_BOTTOM-|"
                                            options:0
                                            metrics:defaultMetrics
                                              views:views]];
}

- (void)configureShieldView {
    _shieldView = [UIScrollView new];

    _shieldView.translatesAutoresizingMaskIntoConstraints = NO;
    _shieldView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _shieldView.alwaysBounceVertical = YES;
    _shieldView.showsVerticalScrollIndicator = NO;

    _shieldView.delegate = self;

    [_shieldView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTriggerShieldTapRecognizer:)]];
    [self addSubview:_shieldView];
}

- (void)configureShieldContentView {
    _shieldContentView = [UIView new];

    _shieldContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _shieldContentView.backgroundColor = [UIColor clearColor];

    [_shieldView addSubview:_shieldContentView];
}

- (void)configurePanelView {
    _panelView = [UIImageView new];

    _panelView.translatesAutoresizingMaskIntoConstraints = NO;
    _panelView.userInteractionEnabled = YES;

    [_panelView setImage:[[self imageWithName:@"bg-feedback"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 20.0, 25.0, 20.0)
                          resizingMode:UIImageResizingModeStretch]];

    [_shieldContentView addSubview:_panelView];
}

- (UIButton *)configureCloseButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    closeButton.translatesAutoresizingMaskIntoConstraints = NO;

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
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(18.0, 18.0, 18.0, 18.0)
                                              resizingMode:UIImageResizingModeStretch]];

    _usernameBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _usernameBackgroundView.userInteractionEnabled = YES;

    [_panelView addSubview:_usernameBackgroundView];
}

- (void)configureUsernameField {
    _usernameField = [UITextField new];

    _usernameField.translatesAutoresizingMaskIntoConstraints = NO;
    _usernameField.returnKeyType = UIReturnKeyNext;

    NSDictionary *placeholderAttributes = @{ NSForegroundColorAttributeName:[[UIColor grayColor]
                                                                             colorWithAlphaComponent:0.6],
                                             NSFontAttributeName:[UIFont
                                                                  systemFontOfSize:12.0
                                                                  weight:UIFontWeightRegular] };

    _usernameField.attributedPlaceholder = [[NSAttributedString alloc]
                                            initWithString:NSLocalizedString(@"Your name", nil)
                                            attributes:placeholderAttributes];

    _usernameField.textAlignment = NSTextAlignmentCenter;
    _usernameField.font = [UIFont systemFontOfSize:12.0
                                            weight:UIFontWeightRegular];

    _usernameField.text = [[NSUserDefaults standardUserDefaults]
                           stringForKey:kNSUserDefaulsUsernameKey];

    _usernameField.delegate = self;

    [_usernameBackgroundView addSubview:_usernameField];
}

- (void)configureClearButton {
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];

    _clearButton.translatesAutoresizingMaskIntoConstraints = NO;

    [_clearButton setImage:[self imageWithName:@"bt-clear"]
                  forState:UIControlStateNormal];

    [_clearButton addTarget:self
                     action:@selector(didTapClearButton:)
           forControlEvents:UIControlEventTouchUpInside];

    [_usernameBackgroundView addSubview:_clearButton];
}

- (void)configureMessageBackgroundView {
    _messageBackgroundView = [[UIImageView alloc]
                              initWithImage:[[self imageWithName:@"bg-rounded-orange"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
                                             resizingMode:UIImageResizingModeStretch]];

    _messageBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _messageBackgroundView.userInteractionEnabled = YES;

    [_messageBackgroundView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                            forAxis:UILayoutConstraintAxisVertical];

    [_panelView addSubview:_messageBackgroundView];
}

- (void)configureMessageView {
    _messageView = [TRYMessageView new];

    _messageView.delegate = self;

    [_messageBackgroundView addSubview:_messageView];
}

- (UIButton *)configureSubmitButton {
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];

    submitButton.translatesAutoresizingMaskIntoConstraints = NO;

    [submitButton setBackgroundImage:[[self imageWithName:@"bg-rounded-green"]
                                      resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
                                      resizingMode:UIImageResizingModeStretch]
                            forState:UIControlStateNormal];

    [submitButton setTitle:NSLocalizedString(@"SUBMIT", nil)
                  forState:UIControlStateNormal];
    
    [submitButton addTarget:self
                     action:@selector(didTapSubmitButton:)
           forControlEvents:UIControlEventTouchUpInside];

    [submitButton setContentHuggingPriority:UILayoutPriorityRequired
                                    forAxis:UILayoutConstraintAxisVertical];

    [_panelView addSubview:submitButton];
    
    return submitButton;
}

#pragma mark - Presenting

- (void)showAnimated:(BOOL)animated {
    _panelViewVerticalCenterConstraint.constant = 20.0;

    if (!animated) {
        [self layoutIfNeeded];

        return;
    }

    [self animateChanges];
}

- (void)hideAnimated:(BOOL)animated {
    _panelViewVerticalCenterConstraint.constant = -20.0;

    if (!animated) {
        [self layoutIfNeeded];

        return;
    }

    [self animateChanges];
}

- (void)animateChanges {
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:nil];
}

#pragma mark - Actions

- (void)didTapCloseButton:(id)sender {
    [self endEditing:YES];

    [self hideAnimated:YES];
    
    [_delegate feedbackOverlayViewDidTapCloseButton:self];
}

- (void)didTapClearButton:(id)sender {
    _usernameField.text = nil;
    _clearButton.hidden = YES;
}

- (void)didTapSubmitButton:(id)sender {
    if (_usernameField.text.length < 1) {
        [self showShakeAnimationForUsernameField];

        return;
    }

    [self endEditing:YES];

    [[NSUserDefaults standardUserDefaults] setObject:_usernameField.text
                                              forKey:kNSUserDefaulsUsernameKey];

    [_delegate feedbackOverlayViewDidTapSubmitButton:self];
}

- (void)didTriggerShieldTapRecognizer:(UITapGestureRecognizer *)tapRecognizer {
    if (_usernameField.isFirstResponder) {
        _usernameField.resignFirstResponder;
    } else if (_messageView.isFirstResponder) {
        _messageView.resignFirstResponder;
    }
}

#pragma mark - Text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _clearButton.hidden = (textField.text.length == 0);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _clearButton.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_messageView becomeFirstResponder];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    _clearButton.hidden = (resultString.length == 0);

    return YES;
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView {
    if ([_messageView.text isEqualToString:@"\n"]) {
        _messageView.text = nil;
    }

    [_messageView showPlaceholder:!(textView.text.length)];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [_messageView showPlaceholder:!(textView.text.length)];
}

#pragma mark - Notifications

- (void)registerForKeyboardAndOrientaionNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self
           selector:@selector(didReceiveKeyboardWillHideNotification:)
               name:UIKeyboardWillHideNotification
             object:nil];

    [nc addObserver:self
           selector:@selector(didReceiveKeyboardWillShowNotification:)
               name:UIKeyboardWillShowNotification
             object:nil];

    [nc addObserver:self
           selector:@selector(didReceiveDeviceOrientationDidChangeNotification:)
               name:UIDeviceOrientationDidChangeNotification
             object:nil];
}

#pragma mark - Orientiation

- (void)didReceiveDeviceOrientationDidChangeNotification:(NSNotification *)notification {
    _shieldView.contentSize = CGSizeMake(kPanelViewWidthValue, kPanelViewHeightValue + kPanelViewTopOffset);
}

#pragma mark - Keyboard

- (void)didReceiveKeyboardWillShowNotification:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIEdgeInsets insets = _shieldView.contentInset;

    insets.bottom = keyboardFrame.size.height + 12.0;
    _shieldView.contentInset = insets;

    [NSLayoutConstraint deactivateConstraints:@[_panelViewVerticalCenterConstraint]];
    [NSLayoutConstraint activateConstraints:@[_panelViewTopConstraint]];

    [self layoutIfNeeded];
}

- (void)didReceiveKeyboardWillHideNotification:(NSNotification *)notification {
    UIEdgeInsets insets = _shieldView.contentInset;

    insets.bottom = 0.0;
    _shieldView.contentInset = insets;

    [NSLayoutConstraint deactivateConstraints:@[_panelViewTopConstraint]];
    [NSLayoutConstraint activateConstraints:@[_panelViewVerticalCenterConstraint]];

    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _shieldView.contentSize = CGSizeMake(kPanelViewWidthValue, kPanelViewHeightValue + kPanelViewTopOffset);
}

#pragma mark - Helper Methods

- (NSLayoutConstraint *)centerHorizontallyConstraintForView:(UIView *)view {
    
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view.superview
                                        attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                         constant:0.0];
}
- (NSLayoutConstraint *)centerVerticallyConstraintForView:(UIView *)view
                                             withConstant:(CGFloat)constant {

    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view.superview
                                        attribute:NSLayoutAttributeCenterY
                                       multiplier:1.0
                                         constant:constant];
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

- (void)showShakeAnimationForUsernameField {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];

    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.8;
    animation.values = @[ @(-20), @(20), @(-20), @(20), @(-10), @(10), @(-5), @(5), @(0) ];

    [_usernameField.layer addAnimation:animation forKey:@"shake"];
}

- (void)focusOnUsernameField {
    [_usernameField becomeFirstResponder];
}

@end
