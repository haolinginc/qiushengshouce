//
//  WeiboLoginViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WeiboLoginViewController.h"
#import "ConfigController.h"
#import "SBJson/SBJson.h"
#import "AppDelegate.h"
#import "UserController.h"
#import "WeiboViewController.h"

@interface WeiboLoginViewController ()

@end

@implementation WeiboLoginViewController
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
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?display=mobile&response_type=code&redirect_uri=http://life.0569.com&client_id=%@",[ConfigController weiboAppKey]];
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
    if([[absoluteString substringWithRange:NSMakeRange(0, 27)] isEqualToString:@"http://life.0569.com/?code="])
    {
        NSString *sina_code = [absoluteString substringWithRange:NSMakeRange(27, [absoluteString length] - 27)];
        //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        //appDelegate.userController.sina_code = sina_code;
        NSString *tokenURL = @"https://api.weibo.com/oauth2/access_token";
        NSMutableURLRequest *tokenRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tokenURL]];
        [tokenRequest setHTTPMethod:@"POST"];
        NSString *post_client_id = [ConfigController weiboAppKey];
        NSString *post_client_secret = [ConfigController weiboAppSecret];
        NSString *post_grant_type = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)@"authorization_code", nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        NSString *post_code = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)sina_code, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        NSString *post_redirect_uri = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)@"http://life.0569.com", nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        
        NSString *postURLStr = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=%@&code=%@&redirect_uri=%@",post_client_id,post_client_secret,post_grant_type,post_code,post_redirect_uri];
        NSData *postData = [postURLStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        [tokenRequest setHTTPBody:postData];
        
        [NSURLConnection sendAsynchronousRequest:tokenRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if ([data length]>0 && error==nil)
            {
                NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
                int ntime = time(NULL);
                ntime = ntime + [[result objectForKey:@"expires_in"] intValue];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegate.userController.weiboToken = [result objectForKey:@"access_token"];
                appDelegate.userController.weiboTimeout = ntime;
                [self.parentController setStatutToLogin];
            }
        }];
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
