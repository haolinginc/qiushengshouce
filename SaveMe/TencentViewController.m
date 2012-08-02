//
//  TencentViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TencentViewController.h"
#import "TencentLoginViewController.h"
#import "AppDelegate.h"
#import "UserController.h"
#import "SBJson/SBJson.h"
#import "ConfigController.h"
#import "ContentViewController.h"

@interface TencentViewController ()

@end

@implementation TencentViewController
@synthesize textView;
@synthesize bindButtonItem;
@synthesize sendButtonItem;
@synthesize shareImageView;
@synthesize parentController;

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
    
    [self.textView becomeFirstResponder];
    
    self.sendButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonSystemItemDone target:self action:@selector(goSend:)];
    self.bindButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonSystemItemDone target:self action:@selector(goLogin:)];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    int ntime = time(NULL);
    if(appDelegate.userController.tencentTimeout > ntime)
    {
        self.navigationItem.rightBarButtonItem = self.sendButtonItem;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = self.bindButtonItem;
    }
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

- (void)goSend:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [button setEnabled:NO];
    NSData *picData = UIImageJPEGRepresentation(self.shareImageView.image, 1.0);
    
    NSString *BOUNDARY = @"life.0569.com_ios_saveme_2012_07_10";
    NSString *HEADER = [NSString stringWithFormat:@"--%@\r\n",BOUNDARY];
    NSString *END = [NSString stringWithFormat:@"\r\n--%@--\r\n",BOUNDARY];
    NSString *MULTIPART = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",BOUNDARY];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"%@    %@",appDelegate.userController.tencentToken,appDelegate.userController.tencentOpenid);
    NSMutableData *body = [NSMutableData data];
    
    NSString *post_oauth_consumer_key = [ConfigController tencentAppKey];
    NSLog(@"%@",post_oauth_consumer_key);
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"oauth_consumer_key\"\r\n\r\n%@\r\n",post_oauth_consumer_key] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_access_token = appDelegate.userController.tencentToken;
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n%@\r\n",post_access_token] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_openid = appDelegate.userController.tencentOpenid;
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"openid\"\r\n\r\n%@\r\n",post_openid] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_clientip = @"222.65.121.14";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"clientip\"\r\n\r\n%@\r\n",post_clientip] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_oauth_version = @"2.a";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"oauth_version\"\r\n\r\n%@\r\n",post_oauth_version] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_scope = @"all";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"scope\"\r\n\r\n%@\r\n",post_scope] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_format = @"json";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"format\"\r\n\r\n%@\r\n",post_format] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_content = self.textView.text;
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content\"\r\n\r\n%@\r\n",post_content] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_jing = @"";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"jing\"\r\n\r\n%@\r\n",post_jing] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_wei = @"";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"wei\"\r\n\r\n%@\r\n",post_wei] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *post_syncflag = @"0";
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syncflag\"\r\n\r\n%@\r\n",post_syncflag] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"pic\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream;charset=UTF-8\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //NSData* imageData = UIImagePNGRepresentation((UIImage *)self.itemImageView.image);
    [body appendData:picData];
    
    [body appendData:[END dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *postRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://open.t.qq.com/api/t/add_pic"]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:MULTIPART forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPBody:body];
    NSLog(@"send");
    [NSURLConnection sendAsynchronousRequest:postRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
        if ([data length]>0 && error==nil)
        {
            //NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
            //NSLog(@"%@",result);
            [self.parentController showHint:@"分享成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)goLogin:(id)sender
{
    TencentLoginViewController *tencentLoginViewController = [[TencentLoginViewController alloc] initWithNibName:@"TencentLoginViewController" bundle:nil];
    tencentLoginViewController.title = @"登录腾讯微博";
    tencentLoginViewController.parentController = self;
    [self.navigationController pushViewController:tencentLoginViewController animated:YES];
}
- (void)setShareImage:(UIImage *)image
{
    if(image == nil)
    {
        self.shareImageView.image = [UIImage imageNamed:@"Icon.png"];
        self.shareImageView.frame = CGRectMake(self.shareImageView.frame.origin.x, self.shareImageView.frame.origin.y, 57, 57);
    }
    else
    {
        self.shareImageView.image = image;
    }
}
- (void)setShareText:(NSString *)txt
{
    self.textView.text = txt;
}
- (void)setStatutToLogin
{
    self.navigationItem.rightBarButtonItem = self.sendButtonItem;
}
@end
