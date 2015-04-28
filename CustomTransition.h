//
//  CustomTransition.h
//  LunchBaby
//
//  Created by randy on 15/4/28.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) BOOL isPresenting;
@end
