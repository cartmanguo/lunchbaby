//
//  ShopDataManager.h
//  LunchBaby
//
//  Created by randy on 15/4/22.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ShopDataManager : NSObject
- (void)searchForRestaurant:(NSDictionary *)parameters;
@end
