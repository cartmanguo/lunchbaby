//
//  APIGen.m
//  LunchBaby
//
//  Created by randy on 15/4/22.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "APIGen.h"
#import <CommonCrypto/CommonDigest.h>
@implementation APIGen
+ (NSString *)sha1WithSourceString:(NSString *)sourceString
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *digestString = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH];

    if (CC_SHA1([data bytes], (unsigned int)[data length], digest))
    {
        for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        {
            unsigned char c = digest[i];
            [digestString appendFormat:@"%02X",c];
        }
    }
    NSString *result = [digestString uppercaseString];
    return result;
}

+ (NSString *)getSearchApiRequestStringWithParamters:(NSDictionary *)parameters
{
    NSString *signature = APP_KEY;
    NSArray *keys = [parameters allKeys];
    NSString *parametersString = [NSString stringWithFormat:@"appkey=%@",APP_KEY];

    NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"sorted:%@",sortedKeys);
    for (NSString *key in sortedKeys)
    {
        signature = [signature stringByAppendingFormat:@"%@%@",key,parameters[key]];
        parametersString = [parametersString stringByAppendingFormat:@"&%@=%@",key,parameters[key]];
    }
    NSLog(@"before:%@",signature);
    signature = [signature stringByAppendingString:APP_SECRET];
    NSLog(@"after:%@",signature);
    NSString *sha1Sign = [self sha1WithSourceString:signature];
    NSString *searchApi = [NSString stringWithFormat:@"%@%@?sign=%@&%@",BASIC,SEARCH,sha1Sign,[parametersString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"full:%@",searchApi);
    return searchApi;
}
@end
