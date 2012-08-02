//
//  SettingViewController.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) NSMutableDictionary *tableData;
@property (strong, nonatomic) NSArray *tableGroup;
@end
