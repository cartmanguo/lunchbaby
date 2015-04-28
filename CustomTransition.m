//
//  CustomTransition.m
//  LunchBaby
//
//  Created by randy on 15/4/28.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "CustomTransition.h"
#import "AddUsualPlacesController.h"
@implementation CustomTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting == NO)
    {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGRect finalFrame = [transitionContext finalFrameForViewController:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]];
        CGRect initialFrame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
        AddUsualPlacesController *toVC = (AddUsualPlacesController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.frame = initialFrame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{
            //secondviewcontroller 滑上来
            toView.frame = finalFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
        }];
    }
}
@end
