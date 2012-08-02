//
//  ContentViewController.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ContentViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) IBOutlet UIButton *sinaButton;
@property (strong, nonatomic) IBOutlet UIButton *qqButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *levelImageView;
@property (strong, nonatomic) IBOutlet UILabel *provinceLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;
@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;
@property (strong, nonatomic) IBOutlet UILabel *hotLabel;
@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

@property (strong, nonatomic) IBOutlet UILabel *eventDesLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UILabel *detrimentDesLabel;
@property (strong, nonatomic) IBOutlet UILabel *detrimentLabel;
@property (strong, nonatomic) IBOutlet UILabel *wayDesLabel;
@property (strong, nonatomic) IBOutlet UILabel *wayLabel;
@property (strong, nonatomic) IBOutlet UILabel *termsDesLabel;
@property (strong, nonatomic) IBOutlet UILabel *termsLabel;
@property (strong, nonatomic) IBOutlet UILabel *referDesLabel;

@property (strong, nonatomic) IBOutlet UIView *hintView;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;

@property (strong, nonatomic) NSMutableArray *linkArray;

@property (strong, nonatomic) NSMutableDictionary *dataDict;

@property (strong, nonatomic) IBOutlet UIView *waitView;
- (void)loadNews:(NSString *)newsID;
- (void)showHint:(NSString *)hint;

- (IBAction)shareWeibo:(id)sender;
- (IBAction)shareTencent:(id)sender;
- (IBAction)shareEmail:(id)sender;
- (IBAction)shareMsg:(id)sender;
@end
