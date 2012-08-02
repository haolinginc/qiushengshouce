//
//  TencentLoginViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TencentLoginViewController.h"
#import "ConfigController.h"
#import "SBJson/SBJson.h"
#import "AppDelegate.h"
#import "UserController.h"
#import "TencentViewController.h"
@interface TencentLoginViewController ()

@end

@implementation TencentLoginViewController
@synthesize webView;
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
    self.webView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=%@&response_type=token&redirect_uri=http://life.0569.com",[ConfigController tencentAppKey]];
    NSURL *loginURL = [[NSURL alloc] initWithString:url];
    NSURLRequest *loginRequest = [[NSURLRequest alloc] initWithURL:loginURL];
    [self.webView loadRequest:loginRequest];
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

// delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *absoluteString = [NSString stringWithString:[[request URL] absoluteString]];
    
    if([[absoluteString substringWithRange:NSMakeRange(0, 22)] isEqualToString:@"http://life.0569.com/#"])
    {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        NSString *txtString = [absoluteString substringWithRange:NSMakeRange(22, [absoluteString length] - 22)];
        NSArray *txtArr = [txtString componentsSeparatedByString:@"&"];
        for(NSString *tmpStr in txtArr)
        {
            NSArray *tmpArr = [tmpStr componentsSeparatedByString:@"="];
            [result setObject:[tmpArr objectAtIndex:1] forKey:[tmpArr objectAtIndex:0]];
        }
        int ntime = time(NULL);
        ntime = ntime + [[result objectForKey:@"expires_in"] intValue];
        //NSLog(@"%@",result);
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.userController.tencentToken = [result objectForKey:@"access_token"];
        appDelegate.userController.tencentOpenid = [result objectForKey:@"openid"];
        appDelegate.userController.tencentTimeout = ntime;
        [self.parentController setStatutToLogin];
        
        [self.navigationController popViewControllerAnimated:NO];
        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
}
@end
