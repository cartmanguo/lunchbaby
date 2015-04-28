//
//  SavedList.m
//  LunchBaby
//
//  Created by randy on 15/4/28.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "SavedList.h"

@implementation SavedList
- (NSMutableArray *)list
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"list_key"])
    {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"list_key"];
    }
    else
    {
        return [NSMutableArray array];
    }
}

- (void)addNewPlace:(NSString *)placeName
{
    [self.list addObject:placeName];
}
@end
