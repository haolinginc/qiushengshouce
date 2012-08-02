//
//  TencentViewController.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewController;
@interface TencentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIBarButtonItem *bindButtonItem;
@property (strong, nonatomic) UIBarButtonItem *sendButtonItem;
@property (strong, nonatomic) IBOutlet UIImageView *shareImageView;
@property (strong, nonatomic) ContentViewController *parentController;
- (void)setShareImage:(UIImage *)image;
- (void)setShareText:(NSString *)txt;
- (void)setStatutToLogin;
@end
