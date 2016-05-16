//
//  TRYMessageView.m
//  Pods
//
//  Created by Eray on 12/04/16.
//
//

#import "TRYMessageView.h"

// PLACEHOLDER
static NSString const *kPlaceholderLeftOffsetKey = @"PLACEHOLDER_LEFT";
static NSString const *kPlaceholderTopOffsetKey = @"PLACEHOLDER_TOP";

static CGFloat  const kPlaceholderLeftOffsetValue = 5.0;
static CGFloat  const kPlaceholderTopOffsetValue = 8.0;


@interface TRYMessageView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation TRYMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.font = [UIFont systemFontOfSize:12.0
                                      weight:UIFontWeightRegular];

        [self configurePlaceholder];
    }

    return self;
}

#pragma mark - Layout

- (void)configurePlaceholder {
    _placeholderLabel = [UILabel new];

    _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _placeholderLabel.text = NSLocalizedString(@"Your Feedback...", nil);
    _placeholderLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    _placeholderLabel.font = [UIFont systemFontOfSize:12.0
                                               weight:UIFontWeightRegular];
    [self addSubview:_placeholderLabel];

    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"placeholder" : _placeholderLabel }];

    NSDictionary *defaultMetrics = @{ kPlaceholderLeftOffsetKey : @(kPlaceholderLeftOffsetValue),
                                      kPlaceholderTopOffsetKey  : @(kPlaceholderTopOffsetValue) };

    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-PLACEHOLDER_LEFT-[placeholder]"
                                              options:NSLayoutFormatAlignAllTop
                                              metrics:defaultMetrics
                                                views:views]];

    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-PLACEHOLDER_TOP-[placeholder]"
                                              options:NSLayoutFormatAlignAllTop
                                              metrics:defaultMetrics
                                                views:views]];
}

- (void)showPlaceholder:(BOOL)show {
    _placeholderLabel.hidden = !show;
}

@end
