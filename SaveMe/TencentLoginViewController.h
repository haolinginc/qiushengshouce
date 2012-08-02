//
//  TencentLoginViewController.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TencentViewController;
@interface TencentLoginViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) TencentViewController *parentController;
@end
