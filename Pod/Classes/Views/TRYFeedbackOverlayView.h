//
//  TRYFeedbackOverlayView.h
//  Pods
//
//  Created by Eray on 24/03/16.
//
//

#import <UIKit/UIKit.h>

@class TRYMessageView;
@protocol TRYFeedbackOverlayViewDelegate;


@interface TRYFeedbackOverlayView : UIView

@property (nonatomic, weak) id<TRYFeedbackOverlayViewDelegate> delegate;

@property (nonatomic, strong, readonly) UITextField *usernameField;
@property (nonatomic, strong, readonly) TRYMessageView *messageView;

- (void)focusOnUsernameField;
- (void)showAnimated:(BOOL)animated;

@end


@protocol TRYFeedbackOverlayViewDelegate <NSObject>
@required
- (void)feedbackOverlayViewDidTapCloseButton:(TRYFeedbackOverlayView *)feedbackOverlayView;
- (void)feedbackOverlayViewDidTapSubmitButton:(TRYFeedbackOverlayView *)feedbackOverlayView;

@end
