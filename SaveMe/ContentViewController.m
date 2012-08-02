//
//  ContentViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"
#import "ConfigController.h"
#import "SBJson/SBJson.h"
#import "WeiboViewController.h"
#import "TencentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize ID;
@synthesize sinaButton;
@synthesize qqButton;
@synthesize emailButton;
@synthesize messageButton;
@synthesize scrollView;

@synthesize titleLabel;
@synthesize dateLabel;
@synthesize levelImageView;
@synthesize provinceLabel;
@synthesize typeLabel;
@synthesize brandLabel;
@synthesize eventImageView;
@synthesize hotLabel;
@synthesize sourceLabel;

@synthesize eventDesLabel;
@synthesize eventLabel;
@synthesize detrimentDesLabel;
@synthesize detrimentLabel;
@synthesize wayDesLabel;
@synthesize wayLabel;
@synthesize termsDesLabel;
@synthesize termsLabel;
@synthesize referDesLabel;

@synthesize hintView;
@synthesize hintLabel;

@synthesize linkArray;

@synthesize dataDict;
@synthesize waitView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"share_weibo.png"] forState:UIControlStateNormal];
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"share_weibo_on.png"] forState:UIControlStateHighlighted];
    
    [qqButton setBackgroundImage:[UIImage imageNamed:@"share_tencent.png"] forState:UIControlStateNormal];
    [qqButton setBackgroundImage:[UIImage imageNamed:@"share_tencent_on.png"] forState:UIControlStateHighlighted];
    
    [emailButton setBackgroundImage:[UIImage imageNamed:@"share_mail.png"] forState:UIControlStateNormal];
    [emailButton setBackgroundImage:[UIImage imageNamed:@"share_mail_on.png"] forState:UIControlStateHighlighted];
    
    [messageButton setBackgroundImage:[UIImage imageNamed:@"share_msg.png"] forState:UIControlStateNormal];
    [messageButton setBackgroundImage:[UIImage imageNamed:@"share_msg_on.png"] forState:UIControlStateHighlighted];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    self.linkArray = [[NSMutableArray alloc] init];
    
    self.hintView.alpha = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadNews:(NSString *)newsID
{
    //newsID = @"1";
    [self.view addSubview:self.waitView];
    
    self.ID = newsID;
    CGSize constrainedToSize = CGSizeMake(300, 600);
    NSString *contentUrl = [NSString stringWithFormat:@"%@/m/news/id/%@",[ConfigController serverPrefix],newsID];
    
    NSMutableURLRequest *rowRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:contentUrl]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:rowRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if ([data length]>0 && error==nil) {
            
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationCurveLinear animations:^{
                self.waitView.alpha = 0;
            } completion:^(BOOL finished){
                [self.waitView setHidden:YES];
            }];
            NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
            NSLog(@"%@",result);
            self.dataDict = result;
            self.titleLabel.text = [result objectForKey:@"f_title"];
            self.dateLabel.text = [result objectForKey:@"f_date"];
            switch ([[result objectForKey:@"f_level"] intValue]) {
                case 1:
                    self.levelImageView.image = [UIImage imageNamed:@"fuck_01.png"];
                    break;
                case 2:
                    self.levelImageView.image = [UIImage imageNamed:@"fuck_02.png"];
                    break;
                case 3:
                    self.levelImageView.image = [UIImage imageNamed:@"fuck_03.png"];
                    break;
                case 4:
                    self.levelImageView.image = [UIImage imageNamed:@"fuck_04.png"];
                    break;
                case 5:
                    self.levelImageView.image = [UIImage imageNamed:@"fuck_05.png"];
                    break;
                default:
                    break;
            }
            self.provinceLabel.text = [result objectForKey:@"f_province"];
            self.typeLabel.text = [result objectForKey:@"f_type_name"];
            self.brandLabel.text = [result objectForKey:@"f_brand"];
            self.hotLabel.text = [result objectForKey:@"f_hot"];
            self.sourceLabel.text = [result objectForKey:@"f_source"];
            //NSLog(@"%@",[result objectForKey:@"f_pic"]);
            if([[result objectForKey:@"f_pic"] count] > 0)
            {
                NSString *picUrl = [[result objectForKey:@"f_pic"] objectForKey:@"f_url"];
                CGSize picSize = CGSizeMake([[[result objectForKey:@"f_pic"] objectForKey:@"f_width"] floatValue] / 2, [[[result objectForKey:@"f_pic"] objectForKey:@"f_height"] floatValue] / 2);
                int frameX = abs(self.view.frame.size.width - picSize.width) / 2;
                int frameY = 130;
                self.eventImageView.frame = CGRectMake(frameX, frameY, picSize.width, picSize.height);
                NSMutableURLRequest *picRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:picUrl]];
                [NSURLConnection sendAsynchronousRequest:picRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
                    eventImageView.image = [UIImage imageWithData:data];
                }];
            }
            else
            {
                eventImageView.frame = CGRectMake(eventImageView.frame.origin.x, 120, 1, 1);
            }
            
            self.eventDesLabel.frame = CGRectMake(self.eventDesLabel.frame.origin.x, self.eventImageView.frame.origin.y + self.eventImageView.frame.size.height + 8, self.eventDesLabel.frame.size.width, self.eventDesLabel.frame.size.height);
            self.eventLabel.text = [result objectForKey:@"f_event"];
            CGSize eventLabelSize = [self.eventLabel.text sizeWithFont:self.eventLabel.font constrainedToSize:constrainedToSize lineBreakMode:self.eventLabel.lineBreakMode];
            self.eventLabel.frame = CGRectMake(self.eventLabel.frame.origin.x, self.eventDesLabel.frame.origin.y + self.eventDesLabel.frame.size.height + 10, eventLabelSize.width, eventLabelSize.height);
            
            self.detrimentDesLabel.frame = CGRectMake(self.detrimentDesLabel.frame.origin.x, self.eventLabel.frame.origin.y + self.eventLabel.frame.size.height + 20, self.detrimentDesLabel.frame.size.width, self.detrimentDesLabel.frame.size.height);
            self.detrimentLabel.text = [result objectForKey:@"f_detriment"];
            CGSize detrimentLabelSize = [self.detrimentLabel.text sizeWithFont:self.detrimentLabel.font constrainedToSize:constrainedToSize lineBreakMode:self.detrimentLabel.lineBreakMode];
            self.detrimentLabel.frame = CGRectMake(self.detrimentLabel.frame.origin.x, self.detrimentDesLabel.frame.origin.y + self.detrimentDesLabel.frame.size.height + 10, detrimentLabelSize.width, detrimentLabelSize.height);
            
            self.wayDesLabel.frame = CGRectMake(self.wayDesLabel.frame.origin.x, self.detrimentLabel.frame.origin.y + self.detrimentLabel.frame.size.height + 20, self.wayDesLabel.frame.size.width, self.wayDesLabel.frame.size.height);
            self.wayLabel.text = [result objectForKey:@"f_way"];
            CGSize wayLabelSize = [self.wayLabel.text sizeWithFont:self.wayLabel.font constrainedToSize:constrainedToSize lineBreakMode:self.wayLabel.lineBreakMode];
            self.wayLabel.frame = CGRectMake(self.wayLabel.frame.origin.x, self.wayDesLabel.frame.origin.y + self.wayDesLabel.frame.size.height + 10, wayLabelSize.width, wayLabelSize.height);
            
            self.termsDesLabel.frame = CGRectMake(self.termsDesLabel.frame.origin.x, self.wayLabel.frame.origin.y + self.wayLabel.frame.size.height + 20, self.termsDesLabel.frame.size.width, self.termsDesLabel.frame.size.height);
            self.termsLabel.text = [result objectForKey:@"f_terms"];
            if([self.termsLabel.text isEqualToString:@""])
            {
                self.termsLabel.text = @"无名词解释";
            }
            CGSize termsLabelSize = [self.termsLabel.text sizeWithFont:self.termsLabel.font constrainedToSize:constrainedToSize lineBreakMode:self.termsLabel.lineBreakMode];
            self.termsLabel.frame = CGRectMake(self.termsLabel.frame.origin.x, self.termsDesLabel.frame.origin.y + self.termsDesLabel.frame.size.height + 10, termsLabelSize.width, termsLabelSize.height);
            
            self.referDesLabel.frame = CGRectMake(self.referDesLabel.frame.origin.x, self.termsLabel.frame.origin.y + self.termsLabel.frame.size.height + 20, self.referDesLabel.frame.size.width, self.referDesLabel.frame.size.height);
            
            int linkCount = [[result objectForKey:@"refer"] count];
            //NSLog(@"%d",linkCount);
            if(linkCount > 0)
            {
                for(int i = 0; i < linkCount; i++)
                {
                    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    linkButton.frame = CGRectMake(10, self.referDesLabel.frame.origin.y + self.referDesLabel.frame.size.height + 5 + ((i) * 25), 300, 20);
                    linkButton.titleLabel.font = [UIFont systemFontOfSize:15];
                    linkButton.titleLabel.textAlignment = UITextAlignmentLeft;
                    linkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [linkButton setTitle:[[[result objectForKey:@"refer"] objectAtIndex:i] objectForKey:@"f_title"] forState:UIControlStateNormal];
                    linkButton.titleLabel.textColor = [UIColor darkGrayColor];
                    linkButton.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
                    [linkButton setBackgroundImage:nil forState:UIControlStateNormal];
                    [linkButton setBackgroundImage:nil forState:UIControlStateHighlighted];
                    [linkButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                    [linkButton setTitleColor:[UIColor colorWithRed:83.0/255.0 green:140.0/255.0 blue:33.0/255.0 alpha:1] forState:UIControlStateHighlighted];
                    [linkButton setTag:i];
                    [self.scrollView addSubview:linkButton];
                    [self.linkArray addObject:[[[result objectForKey:@"refer"] objectAtIndex:i] objectForKey:@"f_url"]];
                    [linkButton addTarget:self action:@selector(linkTo:) forControlEvents:UIControlEventTouchUpInside];
                    
                    self.scrollView.contentSize = CGSizeMake(320, linkButton.frame.origin.y + linkButton.frame.size.height + 20);
                }
            }
            else
            {
                [self.referDesLabel setHidden:YES];
                self.scrollView.contentSize = CGSizeMake(320, self.termsLabel.frame.origin.y + self.termsLabel.frame.size.height + 10);
            }
        }
    }];
}
- (void)showHint:(NSString *)hint
{
    self.hintLabel.text = hint;
    self.hintView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationCurveEaseOut animations:^{
        self.hintView.alpha = 0.8;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 delay:1.5 options:UIViewAnimationCurveEaseOut animations:^{
            self.hintView.alpha = 0;
        }completion:^(BOOL finished){
            
        }];
    }];
}
- (void)linkTo:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //NSLog(@"%d   %@",button.tag,[self.linkArray objectAtIndex:button.tag]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.linkArray objectAtIndex:button.tag]]];
}

- (IBAction)shareWeibo:(id)sender
{
    WeiboViewController *weiboViewController = [[WeiboViewController alloc] initWithNibName:@"WeiboViewController" bundle:nil];
    weiboViewController.parentController = self;
    weiboViewController.title = @"分享到新浪微博";
    [self.navigationController pushViewController:weiboViewController animated:YES];
    [weiboViewController setShareImage:self.eventImageView.image];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"YYYYMMDDHHmmssSSSS"];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *curDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *contentString = [NSString stringWithFormat:@"%@，@百姓求生手册 曝光%@。面对食品安全没人可以独善其身，驱猛兽而百姓宁，亮出你的态度！#百姓求生手册#",curDate,[self.dataDict objectForKey:@"f_title"]];
    [weiboViewController setShareText:contentString];
}
- (IBAction)shareTencent:(id)sender
{
    TencentViewController *tencentViewController = [[TencentViewController alloc] initWithNibName:@"TencentViewController" bundle:nil];
    tencentViewController.parentController = self;
    tencentViewController.title = @"分享到腾讯微博";
    [self.navigationController pushViewController:tencentViewController animated:YES];
    [tencentViewController setShareImage:self.eventImageView.image];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"YYYYMMDDHHmmssSSSS"];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *curDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *contentString = [NSString stringWithFormat:@"%@，@qiushengshouce 曝光%@。面对食品安全没人可以独善其身，驱猛兽而百姓宁，亮出你的态度！#求生手册#",curDate,[self.dataDict objectForKey:@"f_title"]];
    [tencentViewController setShareText:contentString];
}
- (IBAction)shareEmail:(id)sender
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    //[[picker navigationBar] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //picker.delegate = self;
    picker.mailComposeDelegate = self;
    //NSLog(@"%@",self.dataDict);
    [picker setSubject:[self.dataDict objectForKey:@"f_title"]];
    NSString *contentString = [NSString stringWithFormat:@"事件:\n%@\n\n危害:\n%@\n\n求生方法:\n%@\n\n",[self.dataDict objectForKey:@"f_event"],[self.dataDict objectForKey:@"f_detriment"],[self.dataDict objectForKey:@"f_way"]];
    [picker setMessageBody:contentString isHTML:NO];
    [self presentModalViewController:picker animated:YES];
}
- (IBAction)shareMsg:(id)sender
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil)
    {
        if([messageClass canSendText])
        {
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            //[dateFormatter setDateFormat:@"YYYYMMDDHHmmssSSSS"];
            [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
            NSString *curDate = [dateFormatter stringFromDate:[NSDate date]];
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            NSString *contentString = [NSString stringWithFormat:@"%@，@求生手册 曝光%@。面对食品安全没人可以独善其身，驱猛兽而百姓宁，亮出你的态度！#求生手册#",curDate,[self.dataDict objectForKey:@"f_title"]];
            [picker setBody:contentString];
            [self presentModalViewController:picker animated:YES];
        }
        else
        {
            //NSLog(@"no msg support");
            [self showHint:@"您的设备不支持短信"];
        }
    }
    else
    {
        //NSLog(@"no msg support");
        [self showHint:@"您的设备不支持短信"];
    }
}

//MFMailComposeViewController delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if(result == MFMailComposeResultSent)
    {
        [self showHint:@"邮件分享成功"];
    }
    if(result == MFMailComposeResultFailed)
    {
        [self showHint:@"邮件分享失败"];
    }
    [controller dismissModalViewControllerAnimated:YES];
}
//MFMessageComposeViewController delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if(result == MessageComposeResultSent)
    {
        [self showHint:@"短信分享成功"];
    }
    if(result == MessageComposeResultFailed)
    {
        [self showHint:@"短信分享失败"];
    }
    [controller dismissModalViewControllerAnimated:YES];
}
@end
