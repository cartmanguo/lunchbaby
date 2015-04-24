//
//  ShopDataManager.m
//  LunchBaby
//
//  Created by randy on 15/4/22.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "ShopDataManager.h"
#import "APIGen.h"
@implementation ShopDataManager
- (void)searchForRestaurant:(NSDictionary *)parameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[APIGen getSearchApiRequestStringWithParamters:parameters] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSArray *infos = responseObject[@"businesses"];
        //NSDictionary *d = [infos firstObject];
        NSLog(@"JSON: %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
