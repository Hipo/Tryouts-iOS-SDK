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

    UIImageView *tryoutsIconView = [self configureTryoutsIconView];

    // Username field
    [self configureUsernameBackgroundView];

    UITextField *usernameField = [self configureUsernameField];


    // Auto layout constraints
    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"shieldView"         : _shieldView,
                                                        @"panelView"          : _panelView,
                                                        @"closeButton"        : closeButton,
                                                        @"usernameBackground" : _usernameBackgroundView,
                                                        @"tryoutsIcon"        : tryoutsIconView,
                                                        @"usernameField"      : usernameField }];

    // Auto layout constraints - Shield view
    NSArray *shieldViewHorizontalConstraints = [self constraintsWithFormatString:@"H:|-0-[shieldView]-0-|"
                                                                         options:NSLayoutFormatAlignAllTop
                                                                        andViews:views];

    NSArray *shieldViewVerticalConstraints = [self constraintsWithFormatString:@"V:|-0-[shieldView]-0-|"
                                                                       options:NSLayoutFormatAlignAllTop
                                                                      andViews:views];

    // Auto layout constraints - Panel view
    NSArray *panelViewHorizontalConstraints = [self constraintsWithFormatString:@"H:[panelView(300)]"
                                                                        options:NSLayoutFormatAlignAllTop
                                                                       andViews:views];

    NSArray *panelViewVerticalConstraints = [self constraintsWithFormatString:@"V:[panelView(350)]"
                                                                      options:NSLayoutFormatAlignAllTop
                                                                     andViews:views];

    NSLayoutConstraint *panelViewCenterHorizontallyConstraint = [self centerHorizontallyConstraintForView:
                                                                 _panelView];

    NSLayoutConstraint *panelViewCenterVerticallyConstraint = [self centerVerticallyConstraintForView:
                                                               _panelView];

    // Auto layout constraints - Close button
    NSArray *closeButtonHorizontalConstraints = [self constraintsWithFormatString:@"H:[closeButton(20)]-15-|"
                                                                          options:NSLayoutFormatAlignAllTop
                                                                         andViews:views];

    NSArray *closeButtonVerticalConstraints = [self constraintsWithFormatString:@"V:|-10-[closeButton(20)]"
                                                                        options:NSLayoutFormatAlignAllTop
                                                                       andViews:views];


    // Auto layout constraints - Username field
    NSArray *usernameBackgroundHorizontalConstraints = [self constraintsWithFormatString:@"H:|-35-[usernameBackground]-35-|"
                                                                                 options:NSLayoutFormatAlignAllTop
                                                                                andViews:views];

    NSArray *tryoutsIconUsernameBackgroundVerticalConstraints = [self constraintsWithFormatString:@"V:|-(-33)-[tryoutsIcon(66)]-0-[usernameBackground]"
                                                                               options:NSLayoutFormatAlignAllCenterX
                                                                              andViews:views];

    // Auto layout constraints - Tryouts icon
    NSLayoutConstraint *tryoutsIconCenterHorizontallyConstraint = [self centerHorizontallyConstraintForView:
                                                                   tryoutsIconView];

    NSArray *tryoutsIconHorizontalConstraints = [self constraintsWithFormatString:@"H:[tryoutsIcon(79)]"
                                                                          options:NSLayoutFormatAlignAllTop
                                                                       andViews:views];


    // Auto layout constraints - Username field
    NSArray *usernameFieldHorizontalConstraints = [self constraintsWithFormatString:@"H:|-5-[usernameField]-5-|"
                                                                            options:NSLayoutFormatAlignAllTop
                                                                           andViews:views];

    NSArray *usernameFieldVerticalConstraints = [self constraintsWithFormatString:@"V:|-5-[usernameField]-5-|"
                                                                          options:NSLayoutFormatAlignAllTop
                                                                         andViews:views];

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
    [NSLayoutConstraint activateConstraints:tryoutsIconUsernameBackgroundVerticalConstraints];
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

#pragma mark - Actions

- (void)didTapCloseButton:(id)sender {
    [self endEditing:YES];
    
    [_delegate feedbackOverlayViewDidTapCloseButton:self];
}

- (void)didTriggerShieldTapRecognizer:(UITapGestureRecognizer *)tapRecognizer {

}

#pragma mark - Helper Methods

- (NSArray *)constraintsWithFormatString:(NSString *)formatString
                                 options:(NSLayoutFormatOptions *)options
                                andViews:(NSArray *)views {

    return [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                   options:options
                                                   metrics:nil
                                                     views:views];
}

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
