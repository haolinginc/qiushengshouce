//
//  BrandViewController.h
//  SaveMe
//
//  Created by 杰 魏 tonyvicky on 12-7-3.
//  Copyright (c) 2012年 HaoLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *brandData;
- (void)loadData;
@end
