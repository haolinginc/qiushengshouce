//
//  UserController.m
//  SaveMe
//
//  Created by 杰 魏 tonyvicky on 12-7-3.
//  Copyright (c) 2012年 HaoLing. All rights reserved.
//

#import "UserController.h"

@implementation UserController
@synthesize weiboToken;
@synthesize weiboTimeout;
@synthesize tencentToken;
@synthesize tencentOpenid;
@synthesize tencentTimeout;
-(id) init
{
    self = [super init];
    if(self)
    {
        self.weiboTimeout = 0;
        self.tencentTimeout = 0;
    }
    return self;
}
@end
