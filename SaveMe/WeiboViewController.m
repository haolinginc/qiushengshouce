//
//  WeiboViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WeiboViewController.h"
#import "WeiboLoginViewController.h"
#import "AppDelegate.h"
#import "UserController.h"
#import "SBJson/SBJson.h"
#import "ContentViewController.h"

@interface WeiboViewController ()

@end

@implementation WeiboViewController
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
    if(appDelegate.userController.weiboTimeout > ntime)
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
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n%@\r\n",appDelegate.userController.weiboToken] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *shareContent = self.textView.text;
    NSString *post_status = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)shareContent, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"status\"\r\n\r\n%@\r\n",post_status] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"pic\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //NSData* imageData = UIImagePNGRepresentation((UIImage *)self.itemImageView.image);
    [body appendData:picData];
    
    [body appendData:[END dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *postRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://upload.api.weibo.com/2/statuses/upload.json"]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:MULTIPART forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPBody:body];
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
    WeiboLoginViewController *weiboLoginViewController = [[WeiboLoginViewController alloc] initWithNibName:@"WeiboLoginViewController" bundle:nil];
    weiboLoginViewController.title = @"登录新浪微博";
    weiboLoginViewController.parentController = self;
    [self.navigationController pushViewController:weiboLoginViewController animated:YES];
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
