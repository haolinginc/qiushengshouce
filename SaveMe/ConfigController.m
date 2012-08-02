//
//  ConfigController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConfigController.h"

@implementation ConfigController
+ (NSString *)serverPrefix
{
    return @"http://www.qiusheng360.com";
}

+ (NSString *)weiboAppKey
{
    //qiusheng360.com 改成自己的appKey
    return @"1111111111";
}
+ (NSString *)weiboAppSecret
{
    return @"c727f0507f19fbd4b3f6b3e2f5f6ef6d";
}

+ (NSString *)tencentAppKey
{
    //qiusheng360.com 改成自己的appKey
    return @"1000000000";
}
+ (NSString *)tencentAppSecret
{
    return @"c9d94a3bd2625389c8eae1ebc36dd3ef";
}
@end
