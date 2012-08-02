//
//  ConfigController.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigController : NSObject
+ (NSString *)serverPrefix;

+ (NSString *)weiboAppKey;
+ (NSString *)weiboAppSecret;

+ (NSString *)tencentAppKey;
+ (NSString *)tencentAppSecret;
@end
