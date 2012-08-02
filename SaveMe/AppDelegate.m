//
//  AppDelegate.m
//  SaveMe
//
//  Created by 杰 魏 tonyvicky on 12-7-3.
//  Copyright (c) 2012年 HaoLing. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeViewController.h"
#import "SettingViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UserController.h"
#import "ConfigController.h"
#import "LeftViewController.h"
#import "TypeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DistrictViewController.h"
#import "BrandViewController.h"
#import "SettingViewController.h"

@implementation AppDelegate

@synthesize window = _window;
//@synthesize myRootViewController;
@synthesize userController;
@synthesize homeNavigationController;
@synthesize homeNavigationViewCenter;
@synthesize homeViewController;
@synthesize leftViewController;
@synthesize typeNavigationController;
@synthesize typeNavigationViewCenter;
@synthesize typeViewController;
@synthesize maskButton;
@synthesize pointBegan;
@synthesize districtNavigationController;
@synthesize districtNavigationViewCenter;
@synthesize districtViewController;
@synthesize brandNavigationController;
@synthesize brandNavigationViewCenter;
@synthesize brandViewController;
@synthesize isReport;

- (void)customizeAppearance
{
    NSLog(@"customizeAppearance");
    // 设置导航按钮样式
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"return.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"return_on.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 11)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [UIBarButtonItem appearanceWhenContainedIn: [UINavigationBar class], nil];
    // 设置导航条背景 和顶部文字样式
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"nav_bar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 0)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],UITextAttributeTextColor,
      [UIColor blackColor],UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,
      [UIFont systemFontOfSize:16],UITextAttributeFont,
      //[UIFont fontWithName:@"Papyrus-Condensed" size:16],UITextAttributeFont,
      nil]
     ];
    
    //NSLog(@"%@",[UIFont familyNames]);
    //NSLog(@"%@",[UIFont fontNamesForFamilyName:@"Papyrus"]);
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
    
    /*
    [[UIButton appearance] setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:[[UIImage imageNamed:@"button_bg_on.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 12, 9, 12)] forState:UIControlStateHighlighted];
    [[UIButton appearance] setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateDisabled];
     */
    [[UIButton appearanceWhenContainedIn: [UINavigationBar class],nil] setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn: [UINavigationBar class],nil] setBackgroundImage:[[UIImage imageNamed:@"button_bg_on.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 12, 9, 12)] forState:UIControlStateHighlighted];
    [[UIButton appearanceWhenContainedIn: [UINavigationBar class],nil] setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateDisabled];
    
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"]];
    
    [[UIButton appearanceWhenContainedIn: [UITextField class],[UISearchBar class],nil] setBackgroundImage:nil forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn: [UITextField class],[UISearchBar class],nil] setBackgroundImage:nil forState:UIControlStateHighlighted];
    [[UIButton appearanceWhenContainedIn: [UITextField class],[UISearchBar class],nil] setBackgroundImage:nil forState:UIControlStateDisabled];
    
    [[UIButton appearanceWhenContainedIn: [UISearchBar class],nil] setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn: [UISearchBar class],nil] setBackgroundImage:[[UIImage imageNamed:@"button_bg_on.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 12, 9, 12)] forState:UIControlStateHighlighted];
    [[UIButton appearanceWhenContainedIn: [UISearchBar class],nil] setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateDisabled];
     
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:1.0];
    
    [self customizeAppearance];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.userController = [[UserController alloc] init];
    
    self.leftViewController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    self.leftViewController.view.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.leftViewController.view.frame.size.width, self.leftViewController.view.frame.size.height);
    [self.window addSubview:self.leftViewController.view];
    
    self.homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    //self.window.rootViewController = self.homeNavigationController;
    //self.myRootViewController = [[UIViewController alloc] init];
    //self.window.rootViewController = self.myRootViewController;
    
    [self.window addSubview:self.homeNavigationController.view];
    [self.homeNavigationController.view setHidden:NO];
    // 拖动手势
    UIPanGestureRecognizer *homePanGestureRecognizer  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(homePanEvent:)];
    [self.homeNavigationController.view addGestureRecognizer:homePanGestureRecognizer];
    
    self.typeViewController = [[TypeViewController alloc] initWithNibName:@"TypeViewController" bundle:nil];
    self.typeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.typeViewController];
    [self.window addSubview:self.typeNavigationController.view];
    [self.typeNavigationController.view setHidden:YES];
    // 拖动手势
    UIPanGestureRecognizer *typePanGestureRecognizer  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(typePanEvent:)];
    [self.typeNavigationController.view addGestureRecognizer:typePanGestureRecognizer];
    
    self.districtViewController = [[DistrictViewController alloc] initWithNibName:@"DistrictViewController" bundle:nil];
    self.districtNavigationController = [[UINavigationController alloc] initWithRootViewController:self.districtViewController];
    [self.window addSubview:self.districtNavigationController.view];
    [self.districtNavigationController.view setHidden:YES];
    // 拖动手势
    UIPanGestureRecognizer *districtPanGestureRecognizer  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(districtPanEvent:)];
    [self.districtNavigationController.view addGestureRecognizer:districtPanGestureRecognizer];
    
    self.brandViewController = [[BrandViewController alloc] initWithNibName:@"BrandViewController" bundle:nil];
    self.brandNavigationController = [[UINavigationController alloc] initWithRootViewController:self.brandViewController];
    [self.window addSubview:self.brandNavigationController.view];
    [self.brandNavigationController.view setHidden:YES];
    // 拖动手势
    UIPanGestureRecognizer *brandPanGestureRecognizer  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(brandPanEvent:)];
    [self.brandNavigationController.view addGestureRecognizer:brandPanGestureRecognizer];
    
    self.settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    self.settingNavigationController = [[UINavigationController alloc] initWithRootViewController:self.settingViewController];
    [self.window addSubview:self.settingNavigationController.view];
    [self.settingNavigationController.view setHidden:YES];
    // 拖动手势
    UIPanGestureRecognizer *settingPanGestureRecognizer  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(settingPanEvent:)];
    [self.settingNavigationController.view addGestureRecognizer:settingPanGestureRecognizer];
    
    self.maskButton = [[UIControl alloc] initWithFrame:self.homeNavigationController.view.frame];
    self.maskButton.backgroundColor = [UIColor clearColor];
    [self.maskButton addTarget:self action:@selector(restoreViewLocation:) forControlEvents:UIControlEventTouchDown];
    
    [self.window addSubview:self.maskButton];
    [self.window bringSubviewToFront:self.maskButton];
    [self.maskButton setHidden:YES];
    
    [self.window makeKeyAndVisible];
    
    self.isReport = NO;
    
    // 注册push通知
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeNewsstandContentAvailability)];
    
    return YES;
}

-(void)settingPanEvent:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
        self.pointBegan = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.settingNavigationViewCenter = self.settingNavigationController.view.center;
        self.settingNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.settingNavigationController.view.layer.shadowOpacity = 0.5f;
        self.settingNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
        self.settingNavigationController.view.layer.shadowRadius = 3.0;
        self.settingNavigationController.view.layer.masksToBounds = NO;
	}
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint fingerPoint = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.settingNavigationViewCenter = CGPointMake((self.settingNavigationController.view.frame.size.width / 2) + fingerPoint.x - self.pointBegan.x, self.settingNavigationViewCenter.y);
        if(self.settingNavigationViewCenter.x >= (self.settingNavigationController.view.frame.size.width / 2))
        {
            self.settingNavigationController.view.center = self.settingNavigationViewCenter;
        }
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.settingNavigationViewCenter.x > 260)
        {
            [self goLeftNav];
        }
        else
        {
            [self goHome];
        }
    }
}
-(void)brandPanEvent:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
        self.pointBegan = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.brandNavigationViewCenter = self.brandNavigationController.view.center;
        self.brandNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.brandNavigationController.view.layer.shadowOpacity = 0.5f;
        self.brandNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
        self.brandNavigationController.view.layer.shadowRadius = 3.0;
        self.brandNavigationController.view.layer.masksToBounds = NO;
	}
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint fingerPoint = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.brandNavigationViewCenter = CGPointMake((self.brandNavigationController.view.frame.size.width / 2) + fingerPoint.x - self.pointBegan.x, self.brandNavigationViewCenter.y);
        if(self.brandNavigationViewCenter.x >= (self.brandNavigationController.view.frame.size.width / 2))
        {
            self.brandNavigationController.view.center = self.brandNavigationViewCenter;
        }
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.brandNavigationViewCenter.x > 260)
        {
            [self goLeftNav];
        }
        else
        {
            [self goHome];
        }
    }
}
-(void)homePanEvent:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
        self.pointBegan = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.homeNavigationViewCenter = self.homeNavigationController.view.center;
        self.homeNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.homeNavigationController.view.layer.shadowOpacity = 0.5f;
        self.homeNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
        self.homeNavigationController.view.layer.shadowRadius = 3.0;
        self.homeNavigationController.view.layer.masksToBounds = NO;
	}
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint fingerPoint = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.homeNavigationViewCenter = CGPointMake((self.homeNavigationController.view.frame.size.width / 2) + fingerPoint.x - self.pointBegan.x, self.homeNavigationViewCenter.y);
        if(self.homeNavigationViewCenter.x >= (self.homeNavigationController.view.frame.size.width / 2))
        {
            self.homeNavigationController.view.center = self.homeNavigationViewCenter;
        }
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.homeNavigationViewCenter.x > 260)
        {
            [self goLeftNav];
        }
        else
        {
            [self goHome];
        }
    }
}
-(void)typePanEvent:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
        self.pointBegan = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.typeNavigationViewCenter = self.typeNavigationController.view.center;
        self.typeNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.typeNavigationController.view.layer.shadowOpacity = 0.5f;
        self.typeNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
        self.typeNavigationController.view.layer.shadowRadius = 3.0;
        self.typeNavigationController.view.layer.masksToBounds = NO;
	}
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint fingerPoint = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.typeNavigationViewCenter = CGPointMake((self.typeNavigationController.view.frame.size.width / 2) + fingerPoint.x - self.pointBegan.x, self.typeNavigationViewCenter.y);
        if(self.typeNavigationViewCenter.x >= (self.typeNavigationController.view.frame.size.width / 2))
        {
            self.typeNavigationController.view.center = self.typeNavigationViewCenter;
        }
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.typeNavigationViewCenter.x > 260)
        {
            [self goLeftNav];
        }
        else
        {
            [self goHome];
        }
    }
}
-(void)districtPanEvent:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
        self.pointBegan = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.districtNavigationViewCenter = self.districtNavigationController.view.center;
        self.districtNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.districtNavigationController.view.layer.shadowOpacity = 0.5f;
        self.districtNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
        self.districtNavigationController.view.layer.shadowRadius = 3.0;
        self.districtNavigationController.view.layer.masksToBounds = NO;
	}
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint fingerPoint = [panGestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        self.districtNavigationViewCenter = CGPointMake((self.districtNavigationController.view.frame.size.width / 2) + fingerPoint.x - self.pointBegan.x, self.districtNavigationViewCenter.y);
        if(self.districtNavigationViewCenter.x >= (self.districtNavigationController.view.frame.size.width / 2))
        {
            self.districtNavigationController.view.center = self.districtNavigationViewCenter;
        }
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self.districtNavigationViewCenter.x > 260)
        {
            [self goLeftNav];
        }
        else
        {
            [self goHome];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //NSLog(@"fore");
    // 重新打开软件，刷新首页
    [self.homeNavigationController.view setHidden:NO];
    [self.typeNavigationController.view setHidden:YES];
    [self.districtNavigationController.view setHidden:YES];
    [self.brandNavigationController.view setHidden:YES];
    [self.settingNavigationController.view setHidden:YES];
    
    self.homeViewController.isHot = NO;
    [self.homeViewController.navigationController popToRootViewControllerAnimated:NO];
    [self.homeViewController refreshData];
    
    [self goHome];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //NSLog(@"iPhone token: %@", [deviceToken description]);
    if(deviceToken)
    {
        //[deviceToken description];
        //发送设备序列号到服务器
        //NSLog(@"%@",[deviceToken description]);
        NSString *tokenURL = [NSString stringWithFormat:@"%@/m/ssid/",[ConfigController serverPrefix]];
        NSMutableURLRequest *tokenRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tokenURL]];
        [tokenRequest setHTTPMethod:@"POST"];
        NSString *post_id = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)[deviceToken description], nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        NSString *postURLStr = [NSString stringWithFormat:@"id=%@",post_id];
        NSData *postData = [postURLStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        [tokenRequest setHTTPBody:postData];
        [NSURLConnection sendAsynchronousRequest:tokenRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
            //NSLog(@"___%@ %d",data,[data length]);
            if ([data length]>0 && error==nil)
            {
                //NSString *resultString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"------%@",resultString);
            }
            else
            {
                //NSLog(@"%@",error);
            }
        }];
        //NSLog(@"%@",tokenURL);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"remote notification!!!!");
    // 设置推送数量
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1];
    
    // 从通知中心清除条目
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    UIApplication* application1 = [UIApplication sharedApplication];
    NSArray* scheduledNotifications = [NSArray arrayWithArray:application1.scheduledLocalNotifications];
    application1.scheduledLocalNotifications = scheduledNotifications;
}

- (void)goLeftNav
{
    [self.maskButton setHidden:NO];
    
    self.homeNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.homeNavigationController.view.layer.shadowOpacity = 0.5f;
    self.homeNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
    self.homeNavigationController.view.layer.shadowRadius = 3.0;
    self.homeNavigationController.view.layer.masksToBounds = NO;
    
    self.typeNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.typeNavigationController.view.layer.shadowOpacity = 0.5f;
    self.typeNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
    self.typeNavigationController.view.layer.shadowRadius = 3.0;
    self.typeNavigationController.view.layer.masksToBounds = NO;
    
    self.districtNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.districtNavigationController.view.layer.shadowOpacity = 0.5f;
    self.districtNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
    self.districtNavigationController.view.layer.shadowRadius = 3.0;
    self.districtNavigationController.view.layer.masksToBounds = NO;
    
    self.brandNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.brandNavigationController.view.layer.shadowOpacity = 0.5f;
    self.brandNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
    self.brandNavigationController.view.layer.shadowRadius = 3.0;
    self.brandNavigationController.view.layer.masksToBounds = NO;
    
    self.settingNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.settingNavigationController.view.layer.shadowOpacity = 0.5f;
    self.settingNavigationController.view.layer.shadowOffset = CGSizeMake(-3.0, 0.0f);
    self.settingNavigationController.view.layer.shadowRadius = 3.0;
    self.settingNavigationController.view.layer.masksToBounds = NO;
    
    //self.homeNavigationController.view.frame = CGRectMake(0, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.homeNavigationController.view.frame = CGRectMake(260, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
        self.typeNavigationController.view.frame = CGRectMake(260, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
        self.districtNavigationController.view.frame = CGRectMake(260, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
        self.brandNavigationController.view.frame = CGRectMake(260, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
        self.settingNavigationController.view.frame = CGRectMake(260, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
    }completion:^(BOOL finished){
        if(!self.homeNavigationController.view.hidden)
        {
            self.maskButton.frame = self.homeNavigationController.view.frame;
        }
        if(!self.typeNavigationController.view.hidden)
        {
            self.maskButton.frame = self.typeNavigationController.view.frame;
        }
        if(!self.districtNavigationController.view.hidden)
        {
            self.maskButton.frame = self.districtNavigationController.view.frame;
        }
        if(!self.brandNavigationController.view.hidden)
        {
            self.maskButton.frame = self.brandNavigationController.view.frame;
        }
        if(!self.settingNavigationController.view.hidden)
        {
            self.maskButton.frame = self.settingNavigationController.view.frame;
        }
    }];
}

- (void)goHome
{
    [UIView animateWithDuration:0.3 animations:^{
        self.homeNavigationController.view.frame = CGRectMake(0, 0, self.homeNavigationController.view.frame.size.width, self.homeNavigationController.view.frame.size.height);
        self.typeNavigationController.view.frame = CGRectMake(0, 0, self.typeNavigationController.view.frame.size.width, self.typeNavigationController.view.frame.size.height);
        self.districtNavigationController.view.frame = CGRectMake(0, 0, self.districtNavigationController.view.frame.size.width, self.districtNavigationController.view.frame.size.height);
        self.brandNavigationController.view.frame = CGRectMake(0, 0, self.brandNavigationController.view.frame.size.width, self.brandNavigationController.view.frame.size.height);
        self.settingNavigationController.view.frame = CGRectMake(0, 0, self.settingNavigationController.view.frame.size.width, self.settingNavigationController.view.frame.size.height);
    }completion:^(BOOL finished){
        self.maskButton.frame = self.homeNavigationController.view.frame;
        [self.maskButton setHidden:YES];
        self.homeNavigationController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
        self.typeNavigationController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
        self.districtNavigationController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
        self.brandNavigationController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
        self.settingNavigationController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
        
        if(self.isReport)
        {
            self.isReport = NO;
            //self.homeViewController.view
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            //[[picker navigationBar] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            //picker.delegate = self;
            picker.mailComposeDelegate = self;
            //NSLog(@"%@",self.dataDict);
            [picker setSubject:@"意见建议"];
            [picker setToRecipients:[NSArray arrayWithObject:@"life@0569.com"]];
            [self.homeViewController presentModalViewController:picker animated:YES];
        }
    }];
}

- (void)restoreViewLocation:(id)sender
{
    [self goHome];
}
/*
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //NSLog(@"%@",[navigationController.viewControllers lastObject]);
    if([viewController isKindOfClass:[HomeViewController class]])
    {
        viewController.title = @"最新求生提醒";
    }
    if([viewController isKindOfClass:[SettingViewController class]])
    {
        viewController.title = @"返回";
    }
}
*/

//mail delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}
@end
