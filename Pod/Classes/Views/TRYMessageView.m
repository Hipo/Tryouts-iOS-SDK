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


@interface TRYMessageView () < UITextViewDelegate >

@property (nonatomic, strong) UILabel *placehodlerLabel;

@end

@implementation TRYMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.font = [UIFont systemFontOfSize:10.0
                                      weight:UIFontWeightRegular];
        self.delegate = self;

        [self configurePlaceholder];
    }

    return self;
}

#pragma mark - Layout

- (void)configurePlaceholder {
    _placehodlerLabel = [UILabel new];

    _placehodlerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _placehodlerLabel.text = @"Feedback...";
    _placehodlerLabel.textColor = [UIColor lightGrayColor];
    _placehodlerLabel.font = [UIFont systemFontOfSize:10.0
                                               weight:UIFontWeightRegular];
    [self addSubview:_placehodlerLabel];

    NSMutableDictionary *views = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{ @"placeholder" : _placehodlerLabel }];

    NSDictionary *defaultMetrics = @{ kPlaceholderLeftOffsetKey : @(kPlaceholderLeftOffsetValue),
                                      kPlaceholderTopOffsetKey  : @(kPlaceholderTopOffsetValue) };

    NSArray
    *placeholderLeftConstraints = [NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:|-PLACEHOLDER_LEFT-[placeholder]"
                                                       options:NSLayoutFormatAlignAllTop
                                                       metrics:defaultMetrics
                                                         views:views];

    NSArray
    *placeholderTopConstraints = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|-PLACEHOLDER_TOP-[placeholder]"
                                                      options:NSLayoutFormatAlignAllTop
                                                      metrics:defaultMetrics
                                                        views:views];

    [NSLayoutConstraint activateConstraints:placeholderLeftConstraints];
    [NSLayoutConstraint activateConstraints:placeholderTopConstraints];
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView {
    _placehodlerLabel.hidden = (textView.text.length);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _placehodlerLabel.hidden = (textView.text.length);
}

@end
