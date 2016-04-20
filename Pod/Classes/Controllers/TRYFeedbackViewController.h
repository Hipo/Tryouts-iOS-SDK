//
//  TRYFeedbackViewController.h
//  Pods
//
//  Created by Eray on 25/02/16.
//
//

#import <UIKit/UIKit.h>

@class TRYFeedback;
@protocol TRYFeedbackViewControllerDelegate;


@interface TRYFeedbackViewController : UIViewController

@property (nonatomic, weak) id<TRYFeedbackViewControllerDelegate> delegate;

@end


@protocol TRYFeedbackViewControllerDelegate <NSObject>
@required
- (void)feedbackViewControllerDidFinishWithFeedback:(TRYFeedback *)feedback;

@end
