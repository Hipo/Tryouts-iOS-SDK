//
//  TRYFeedbackOverlayView.h
//  Pods
//
//  Created by Eray on 24/03/16.
//
//

#import <UIKit/UIKit.h>

@protocol TRYFeedbackOverlayViewDelegate;


@interface TRYFeedbackOverlayView : UIView

@property (nonatomic, weak) id<TRYFeedbackOverlayViewDelegate> delegate;

@end


@protocol TRYFeedbackOverlayViewDelegate <NSObject>
@required
- (void)feedbackOverlayViewDidTapCloseButton:(TRYFeedbackOverlayView *)feedbackOverlayView;
- (void)feedbackOverlayViewDidTapSubmitButton:(TRYFeedbackOverlayView *)feedbackOverlayView;

@end
