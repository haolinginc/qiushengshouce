//
//  AppDelegate.h
//  SaveMe
//
//  Created by 杰 魏 tonyvicky on 12-7-3.
//  Copyright (c) 2012年 HaoLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@class UserController;
@class HomeViewController;
@class LeftViewController;
@class TypeViewController;
@class DistrictViewController;
@class BrandViewController;
@class SettingViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) UIViewController *myRootViewController;
@property (strong, nonatomic) UserController *userController;
@property (strong, nonatomic) UINavigationController *homeNavigationController;
@property (assign, nonatomic) CGPoint homeNavigationViewCenter;
@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) LeftViewController *leftViewController;
@property (strong, nonatomic) UINavigationController *typeNavigationController;
@property (assign, nonatomic) CGPoint typeNavigationViewCenter;
@property (strong, nonatomic) TypeViewController *typeViewController;
@property (strong, nonatomic) UIControl *maskButton;
@property (assign, nonatomic) CGPoint pointBegan;

@property (strong, nonatomic) UINavigationController *districtNavigationController;
@property (assign, nonatomic) CGPoint districtNavigationViewCenter;
@property (strong, nonatomic) DistrictViewController *districtViewController;

@property (strong, nonatomic) UINavigationController *brandNavigationController;
@property (assign, nonatomic) CGPoint brandNavigationViewCenter;
@property (strong, nonatomic) BrandViewController *brandViewController;

@property (strong, nonatomic) UINavigationController *settingNavigationController;
@property (assign, nonatomic) CGPoint settingNavigationViewCenter;
@property (strong, nonatomic) SettingViewController *settingViewController;

@property (assign, nonatomic) BOOL isReport;

- (void)goLeftNav;
- (void)goHome;
@end
