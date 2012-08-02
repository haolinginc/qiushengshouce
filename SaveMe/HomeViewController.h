//
//  HomeViewController.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReloadViewDelegate.h"
@class ReloadView;
@class HomeSearchResult;
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ReloadViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) NSMutableArray *homeData;
@property (strong, nonatomic) UISearchDisplayController *searchDisplay;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIView* headerView;
@property (strong, nonatomic) ReloadView *reloadView;
@property (assign, nonatomic) NSInteger curPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (assign, nonatomic) NSInteger totalRow;
@property (assign, nonatomic) BOOL isLoading;

@property (assign, nonatomic) BOOL isRefresh;

@property (assign, nonatomic) BOOL isSub;

@property (assign, nonatomic) NSInteger loadTypeId;

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *wifiErrorView;
@property (strong, nonatomic) IBOutlet UILabel *wifiErrorLabel;
@property (assign, nonatomic) BOOL isHot;
@property (strong, nonatomic) HomeSearchResult *homeSearchResult;

@property (strong, nonatomic) NSString *loadCity;
@property (strong, nonatomic) NSString *loadBrand;
@property (strong, nonatomic) UIActionSheet *photoSheet;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil typeId:(NSInteger)type;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil city:(NSString *)cityName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil brand:(NSString *)brandName;
- (void)loadData;
- (void)refreshData;
@end
