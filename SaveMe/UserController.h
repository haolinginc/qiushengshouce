//
//  UserController.h
//  SaveMe
//
//  Created by 杰 魏 tonyvicky on 12-7-3.
//  Copyright (c) 2012年 HaoLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserController : NSObject
@property (strong, nonatomic) NSString *weiboToken;
@property (assign, nonatomic) int weiboTimeout;
@property (strong, nonatomic) NSString *tencentToken;
@property (strong, nonatomic) NSString *tencentOpenid;
@property (assign, nonatomic) int tencentTimeout;
@end
