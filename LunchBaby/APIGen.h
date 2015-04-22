//
//  APIGen.h
//  LunchBaby
//
//  Created by randy on 15/4/22.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#define BASIC @"http://api.dianping.com"
#define SEARCH @"/v1/business/find_businesses"
@interface APIGen : NSObject
+ (NSString *)getSearchApiRequestStringWithParamters:(NSDictionary *)parameters;
@end
