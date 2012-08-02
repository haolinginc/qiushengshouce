//
//  ReloadViewDelegate.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReloadViewDelegate <NSObject>
- (void)refreshViewDidCallBack:(UIView *)view;
@end
