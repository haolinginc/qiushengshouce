//
//  PostNewsViewController.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-30.
//
//

#import "PostNewsViewController.h"
#import "AppDelegate.h"
#import "UserController.h"
#import "ConfigController.h"

@interface PostNewsViewController ()

@end

@implementation PostNewsViewController
@synthesize textView;
@synthesize shareImageView;
@synthesize sendButtonItem;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"食品安全问题反馈";
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
    self.navigationItem.rightBarButtonItem = self.sendButtonItem;
}

- (void)goSend:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [button setEnabled:NO];
    NSData *picData = UIImageJPEGRepresentation(self.shareImageView.image, 0.8);
    
    NSString *BOUNDARY = @"life.0569.com_ios_saveme_2012_07_10";
    NSString *HEADER = [NSString stringWithFormat:@"--%@\r\n",BOUNDARY];
    NSString *END = [NSString stringWithFormat:@"\r\n--%@--\r\n",BOUNDARY];
    NSString *MULTIPART = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",BOUNDARY];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *shareContent = self.textView.text;
    NSString *post_status = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)shareContent, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content\"\r\n\r\n%@\r\n",post_status] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"img\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:picData];
    
    [body appendData:[END dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *postRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/m/exposure",[ConfigController serverPrefix]]]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:MULTIPART forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPBody:body];
    [NSURLConnection sendAsynchronousRequest:postRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
        if ([data length]>0 && error==nil)
        {
            NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            //NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
            //NSLog(@"%@",result);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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

- (void)setShareImage:(UIImage *)image
{
    //NSLog(@"%@",image);
    //self.shareImage = [image copy];
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
@end
