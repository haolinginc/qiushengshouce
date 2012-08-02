//
//  HomeViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

#import "TypeViewController.h"
#import "ContentViewController.h"
#import "NewsCell.h"
#import "ReloadView.h"
#import "ConfigController.h"
#import "SBJson/SBJson.h"
#import "ConnectTest.h"
#import "AppDelegate.h"
#import "HomeSearchResult.h"
#import "PostNewsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize homeData;
@synthesize searchDisplay;
@synthesize searchBar;
@synthesize headerView;
@synthesize reloadView;
@synthesize curPage;
@synthesize totalPage;
@synthesize totalRow;
@synthesize isLoading;
@synthesize isRefresh;
@synthesize isSub;
@synthesize loadTypeId;
@synthesize bgView;
@synthesize wifiErrorView;
@synthesize wifiErrorLabel;
@synthesize isHot;
@synthesize homeSearchResult;
@synthesize loadCity;
@synthesize loadBrand;
@synthesize photoSheet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeData = [[NSMutableArray alloc] init];
        self.isSub = NO;
        self.title = @"最新求生提醒";
        self.loadTypeId = 0;
        self.isHot = NO;
        self.homeSearchResult = [[HomeSearchResult alloc] init];
        self.homeSearchResult.homeViewController = self;
        
        self.loadCity = @"";
        self.loadBrand = @"";
        self.photoSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"发表文字",nil];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil brand:(NSString *)brandName;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeData = [[NSMutableArray alloc] init];
        self.isSub = YES;
        self.title = [NSString stringWithFormat:@"%@ 相关提醒",brandName];
        self.loadTypeId = 0;
        self.isHot = NO;
        self.homeSearchResult = [[HomeSearchResult alloc] init];
        self.homeSearchResult.homeViewController = self;
        
        self.loadCity = @"";
        self.loadBrand = brandName;
        self.photoSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"发表文字",nil];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil city:(NSString *)cityName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeData = [[NSMutableArray alloc] init];
        self.isSub = YES;
        self.title = [NSString stringWithFormat:@"%@求生提醒",cityName];
        self.loadTypeId = 0;
        self.isHot = NO;
        self.homeSearchResult = [[HomeSearchResult alloc] init];
        self.homeSearchResult.homeViewController = self;
        
        self.loadCity = cityName;
        self.loadBrand = @"";
        self.photoSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"发表文字",nil];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil typeId:(NSInteger)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeData = [[NSMutableArray alloc] init];
        self.isSub = YES;
        self.loadTypeId = type;
        switch (self.loadTypeId) {
            case 1:
                self.title = @"零食";
                break;
            case 2:
                self.title = @"饮品";
                break;
            case 3:
                self.title = @"调料";
                break;
            case 4:
                self.title = @"蔬菜";
                break;
            case 5:
                self.title = @"肉类";
                break;
            case 6:
                self.title = @"主食";
                break;
            case 7:
                self.title = @"保健品";
                break;
            case 8:
                self.title = @"水果";
                break;
            case 9:
                self.title = @"海鲜";
                break;
            case 10:
                self.title = @"豆制品";
                break;
            case 11:
                self.title = @"禽蛋";
                break;
            case 12:
                self.title = @"奶制品";
                break;
            default:
                break;
        }
        self.isHot = NO;
        self.homeSearchResult = [[HomeSearchResult alloc] init];
        self.homeSearchResult.homeViewController = self;
        
        self.loadCity = @"";
        self.loadBrand = @"";
        self.photoSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"发表文字",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.wifiErrorLabel setHidden:YES];
    [self.wifiErrorView setHidden:YES];
    if(!self.isSub)
    {
        UIBarButtonItem *settingButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemDone target:self action:@selector(goPhoto:)];
        settingButtonItem.image = [UIImage imageNamed:@"set_icon.png"];
        self.navigationItem.rightBarButtonItem = settingButtonItem;
        
        UIBarButtonItem *typeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemDone target:self action:@selector(goLeft:)];
        typeButtonItem.image = [UIImage imageNamed:@"more_icon.png"];
        self.navigationItem.leftBarButtonItem = typeButtonItem;
    }
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    UITableView *tableView = (UITableView *)self.view;
    tableView.backgroundView = bgView;
    self.reloadView = [[ReloadView alloc] initWithFrame:CGRectMake(0, -60, self.view.frame.size.width, 60)];
    self.reloadView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.reloadView.delegate = self;
    [tableView addSubview:self.reloadView];
    
    self.curPage = 0;
    self.totalPage = 0;
    self.totalRow = 0;
    self.isLoading = NO;
    self.isRefresh = NO;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    searchDisplay.searchBar.placeholder = @"输入品牌或食品安全事件";
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.headerView addSubview:self.searchBar];
    [self.searchDisplay.searchBar sizeToFit];
    tableView.tableHeaderView = self.headerView;
    [self.searchDisplay setSearchResultsDataSource:self.homeSearchResult];
    [self.searchDisplay setSearchResultsDelegate:self.homeSearchResult];
    self.searchDisplay.delegate = self.homeSearchResult;
    self.searchBar.delegate = self.homeSearchResult;
    [self loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)goPhoto:(id)sender
{
    //self.navigationItem.leftBarButtonItem.title = @"...";
    //SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    //settingViewController.title = @"关于求生手册";
    //[self.navigationController pushViewController:settingViewController animated:YES];
    [self.photoSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [self.photoSheet showInView:self.view];
}

- (void)goType:(id)sender
{
    //self.navigationItem.leftBarButtonItem.title = @"...";
    TypeViewController *typeViewController = [[TypeViewController alloc] initWithNibName:@"TypeViewController" bundle:nil];
    typeViewController.title = @"求生大全";
    [self.navigationController pushViewController:typeViewController animated:YES];
}

- (void)goLeft:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate goLeftNav];
}

- (void)loadData
{
    self.isLoading = YES;
    self.curPage = self.curPage + 1;
    if(self.totalPage == 0 || self.curPage <= self.totalPage)
    {
        ConnectTest *connectTest = [[ConnectTest alloc] init];
        if(![connectTest connectedToNetwork])
        {
            //NSLog(@"no ok");
            if(self.curPage == 1)
            {
                // 显示没有网络的提示
                [self.wifiErrorLabel setHidden:NO];
                [self.wifiErrorView setHidden:NO];
                [self.homeData removeAllObjects];
                self.curPage = 0;
                self.isLoading = NO;
                UITableView *tableView = (UITableView *)self.view;
                [tableView reloadData];
            }
        }
        else
        {
            //NSLog(@"ok");
            [self.wifiErrorLabel setHidden:YES];
            [self.wifiErrorView setHidden:YES];
        }
        NSString *homeUrl;
        if([self.loadBrand isEqualToString:@""])
        {
            if([self.loadCity isEqualToString:@""])
            {
                if(self.isHot == NO)
                {
                    if(self.loadTypeId == 0)
                    {
                        homeUrl = [NSString stringWithFormat:@"%@/m/index/page/%d/total/%d",[ConfigController serverPrefix],self.curPage,self.totalRow];
                    }
                    else
                    {
                        homeUrl = [NSString stringWithFormat:@"%@/m/index/page/%d/total/%d/type/%d",[ConfigController serverPrefix],self.curPage,self.totalRow,self.loadTypeId];
                    }
                }
                else
                {
                    // 热门提醒
                    //http://life.0569.com/tb/gethot
                    homeUrl = [NSString stringWithFormat:@"%@/m/hot/page/%d/total/%d",[ConfigController serverPrefix],self.curPage,self.totalRow];
                }
            }
            else
            {
                homeUrl = [NSString stringWithFormat:@"%@/m/searchp/p/%@/page/%d/total/%d",[ConfigController serverPrefix],[self.loadCity stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.curPage,self.totalRow];
            }
        }
        else
        {
            homeUrl = [NSString stringWithFormat:@"%@/m/searchp/b/%@/page/%d/total/%d",[ConfigController serverPrefix],[self.loadBrand stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.curPage,self.totalRow];
        }
        
        //NSLog(@"%@",homeUrl);
        NSMutableURLRequest *rowRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:homeUrl]];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [NSURLConnection sendAsynchronousRequest:rowRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            //NSLog(@"%@",error);
            if ([data length]>0 && error==nil) {
                NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
                //NSLog(@"%@",result);
                //NSLog(@"%@",jsonString);
                self.totalPage = [[[result objectForKey:@"page"] objectForKey:@"total_pages"] intValue];
                self.totalRow = [[[result objectForKey:@"page"] objectForKey:@"total_rows"] intValue];
                UITableView *tableView = (UITableView *)self.view;
                if(self.isRefresh)
                {
                    [self.homeData removeAllObjects];
                    [tableView reloadData];
                    self.isRefresh = NO;
                }
                for (NSDictionary *object in [result objectForKey:@"rows"])
                {
                    [self.homeData addObject:object];
                }
                
                [tableView reloadData];
                [self.reloadView dataLoaded:tableView];
                self.isLoading = NO;
            }
        }];
    }
    else
    {
        self.isLoading = NO;
        self.curPage = self.curPage - 1;
    }
    //NSLog(@"curP:%d",self.curPage);
}
- (void)refreshData
{
    self.isLoading = YES;
    self.curPage = 0;
    //[self.homeData removeAllObjects];
    //UITableView *tableView = (UITableView *)self.view;
    //[tableView reloadData];
    self.isLoading = NO;
    self.isRefresh = YES;
    [self loadData];
}

//table data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identifier = @"NewsCell";
    NewsCell *cell = (NewsCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //NSInteger row = [indexPath row];
    //cell.textLabel.text = [[self.homeData objectAtIndex:row] objectForKey:@"title"];
    //cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectInset(cell.bounds, 0, 0)];
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //[tableView indexPathForSelectedRow];
    BOOL isSelected = NO;
    //NSLog(@"%@ ___ %@",[tableView indexPathForSelectedRow],indexPath);
    if([tableView indexPathForSelectedRow])
    {
        if([[tableView indexPathForSelectedRow] row] == [indexPath row])
        {
            isSelected = YES;
        }
        else
        {
            isSelected = NO;
        }
    }
    else
    {
        isSelected = NO;
    }
    
    if([self.homeData objectAtIndex:[indexPath row]])
    {
        [cell setData:[self.homeData objectAtIndex:[indexPath row]] isSelected:isSelected];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.homeData count];
}

//tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    NewsCell *cell = (NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:1];
    //NSLog(@"%@",[[self.homeData objectAtIndex:[indexPath row]] objectForKey:@"f_id"]);
    //UIViewController *vc = [[UIViewController alloc] init];
    //vc.title = @"test";
    //[self.navigationController pushViewController:vc animated:YES];
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    contentViewController.title = @"求生提醒";
    [contentViewController loadNews:[[self.homeData objectAtIndex:[indexPath row]] objectForKey:@"f_id"]];
    [self.navigationController pushViewController:contentViewController animated:YES];
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    NewsCell *cell = (NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:0];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //NSLog(@"drag end");
    [reloadView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [reloadView scrollViewDidScroll:scrollView];
    CGRect visibleRect;
    visibleRect.origin = scrollView.contentOffset;
    visibleRect.size = scrollView.bounds.size;
    //NSLog(@"%f...%f",scrollView.contentSize.height,scrollView.contentOffset.y + scrollView.bounds.size.height);
    if(scrollView.contentOffset.y + scrollView.bounds.size.height > scrollView.contentSize.height - 100 && self.isLoading == NO)
    {
        //NSLog(@"load more");
        [self loadData];
    }
}

//reloadview delegate
- (void)refreshViewDidCallBack:(UIView *)view
{
    if([view isKindOfClass:[ReloadView class]])
    {
        // 刷新
        //NSLog(@"rrrrrr");
        //[self.homeData removeAllObjects];
        if(self.isLoading == NO)
        {
            [self refreshData];
        }
    }
}

//actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%d",buttonIndex);
    if(buttonIndex == 0)
    {
        // 拍照
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if(![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
    if(buttonIndex == 1)
    {
        // 相册
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
    if(buttonIndex == 2)
    {
        // 发表文字
        PostNewsViewController *postNewsViewController = [[PostNewsViewController alloc] initWithNibName:@"PostNewsViewController" bundle:nil];
        //[self presentModalViewController:postNewsViewController animated:YES];
        [self.navigationController pushViewController:postNewsViewController animated:YES];
        [postNewsViewController setShareImage:nil];
    }
}

//imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //NSLog(@"%@",mediaType);
    //NSLog(@"%@",info);
    if([mediaType isEqualToString:@"public.image"])
    {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //UIImageView *tView = [[UIImageView alloc] initWithImage:image];
        //[self.view addSubview:tView];
        NSLog(@"%@",image);
        
        //[picker dismissModalViewControllerAnimated:YES];
        [picker dismissViewControllerAnimated:YES completion:^{
            PostNewsViewController *postNewsViewController = [[PostNewsViewController alloc] initWithNibName:@"PostNewsViewController" bundle:nil];
            //[self presentModalViewController:postNewsViewController animated:YES];
            [self.navigationController pushViewController:postNewsViewController animated:YES];
            [postNewsViewController setShareImage:image];
        }];
    }
}

@end
