//
//  TypeViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TypeViewController.h"
#import "HomeViewController.h"
#import "SBJson/SBJson.h"
#import "ConfigController.h"
#import "AppDelegate.h"

@interface TypeViewController ()

@end

@implementation TypeViewController
@synthesize typeButton01;
@synthesize typeButton02;
@synthesize typeButton03;
@synthesize typeButton04;
@synthesize typeButton05;
@synthesize typeButton06;
@synthesize typeButton07;
@synthesize typeButton08;
@synthesize typeButton09;
@synthesize typeButton10;
@synthesize typeButton11;
@synthesize typeButton12;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"求生大全";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:2.0/255.0 green:66.0/255.0 blue:77.0/255.0 alpha:1.0];
	// Do any additional setup after loading the view.
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    UIBarButtonItem *typeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemDone target:self action:@selector(goLeft:)];
    typeButtonItem.image = [UIImage imageNamed:@"more_icon.png"];
    self.navigationItem.leftBarButtonItem = typeButtonItem;
    
    NSString *typeUrl = [NSString stringWithFormat:@"%@/m/type",[ConfigController serverPrefix]];
    NSMutableURLRequest *rowRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:typeUrl]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:rowRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if ([data length]>0 && error==nil) {
            NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
            for (NSDictionary *object in [result objectForKey:@"rows"])
            {
                //NSLog(@"%@",object);
                UIButton *typeButton;
                NSString *typeButtonNum = [NSString stringWithFormat:@"%@+",[object objectForKey:@"f_num"]];;
                switch ([[object objectForKey:@"f_id"] intValue]) {
                    case 1:
                        typeButton = self.typeButton01;
                        break;
                    case 2:
                        typeButton = self.typeButton02;
                        break;
                    case 3:
                        typeButton = self.typeButton03;
                        break;
                    case 4:
                        typeButton = self.typeButton04;
                        break;
                    case 5:
                        typeButton = self.typeButton05;
                        break;
                    case 6:
                        typeButton = self.typeButton06;
                        break;
                    case 7:
                        typeButton = self.typeButton07;
                        break;
                    case 8:
                        typeButton = self.typeButton08;
                        break;
                    case 9:
                        typeButton = self.typeButton09;
                        break;
                    case 10:
                        typeButton = self.typeButton10;
                        break;
                    case 11:
                        typeButton = self.typeButton11;
                        break;
                    case 12:
                        typeButton = self.typeButton12;
                        break;
                    default:
                        break;
                }
                UILabel *typeButtonLabel = [[UILabel alloc] init];
                typeButtonLabel.text = typeButtonNum;
                typeButtonLabel.font = [UIFont systemFontOfSize:13];
                typeButtonLabel.textColor = [UIColor whiteColor];
                typeButtonLabel.backgroundColor = [UIColor clearColor];
                CGSize fontSize = [typeButtonLabel.text sizeWithFont:typeButtonLabel.font];
                typeButtonLabel.frame = CGRectMake(typeButton.bounds.size.width - fontSize.width - 5, typeButton.bounds.size.height - fontSize.height - 5, fontSize.width, fontSize.height);
                [typeButton addSubview:typeButtonLabel];
            }
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

-(IBAction)showTypeNews:(id)sender
{
    UIButton *button = (UIButton *)sender;
    HomeViewController *hv = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil typeId:button.tag];
    [self.navigationController pushViewController:hv animated:YES];
}

- (void)goLeft:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate goLeftNav];
}
@end
