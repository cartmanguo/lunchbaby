//
//  SavedList.h
//  LunchBaby
//
//  Created by randy on 15/4/28.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavedList : NSObject
@property (strong, nonatomic) NSMutableArray *list;
- (void)addNewPlace:(NSString *)placeName;
@end
