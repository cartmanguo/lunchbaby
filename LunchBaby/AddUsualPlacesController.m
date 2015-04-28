//
//  AddUsualPlacesController.m
//  LunchBaby
//
//  Created by randy on 15/4/28.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "AddUsualPlacesController.h"
#import "CustomPresentation.h"
#import "CustomTransition.h"
@implementation AddUsualPlacesController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)saveUsual:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CustomPresentation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[CustomTransition alloc] init];
}

@end
