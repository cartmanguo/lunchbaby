//
//  CustomPresentation.m
//  LunchBaby
//
//  Created by randy on 15/4/28.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "CustomPresentation.h"
@interface CustomPresentation()
@property (strong, nonatomic) id<UIViewControllerTransitionCoordinator>coordinator;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIVisualEffectView *bluredView;
@end
@implementation CustomPresentation
- (void)presentationTransitionWillBegin
{
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bluredView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.bluredView.frame = self.containerView.frame;
    [self.bgView addSubview:_bluredView];
    [self.containerView addSubview:self.presentingViewController.view];
    [self.containerView addSubview:_bgView];
    [self.containerView addSubview:self.presentedView];
    
    self.bgView.alpha = 0;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> ctx)
    {
        self.bgView.alpha = 0.7;
        self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, 0.9, 0.9);
    }completion:nil];
}

- (BOOL)shouldRemovePresentersView
{
    return NO;
}

- (void)dismissalTransitionWillBegin
{
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> ctx)
     {
         self.bgView.alpha = 0;
         self.presentingViewController.view.transform = CGAffineTransformIdentity;
     }completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed)
    {
        [_bgView removeFromSuperview];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.presentingViewController.view];
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerFrame = self.containerView.frame;
    CGRect presentedFrame = CGRectMake(containerFrame.origin.x, containerFrame.origin.y+180, containerFrame.size.width, containerFrame.size.height - 180);
    return presentedFrame;
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed)
    {
        [_bgView removeFromSuperview];
    }
}

- (UIView *)presentedView
{
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 8;
    return presentedView;
}
@end
