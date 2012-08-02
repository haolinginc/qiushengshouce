//
//  LeftViewController.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-17.
//
//

#import "LeftViewController.h"
#import "NavCell.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "TypeViewController.h"
#import "DistrictViewController.h"
#import "BrandViewController.h"
#import "SettingViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
@synthesize bgView;
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
    NSMutableArray *navArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *newsNavItem = [[NSMutableDictionary alloc] init];
    [newsNavItem setObject:@"最新提醒" forKey:@"name"];
    [newsNavItem setObject:@"news" forKey:@"ident"];
    [navArray addObject:newsNavItem];
    
    NSMutableDictionary *hotNavItem = [[NSMutableDictionary alloc] init];
    [hotNavItem setObject:@"热门提醒" forKey:@"name"];
    [hotNavItem setObject:@"hotnews" forKey:@"ident"];
    [navArray addObject:hotNavItem];
    
    NSMutableDictionary *typeNavItem = [[NSMutableDictionary alloc] init];
    [typeNavItem setObject:@"求生大全" forKey:@"name"];
    [typeNavItem setObject:@"typelist" forKey:@"ident"];
    [navArray addObject:typeNavItem];
    
    NSMutableDictionary *districtNavItem = [[NSMutableDictionary alloc] init];
    [districtNavItem setObject:@"受害地区" forKey:@"name"];
    [districtNavItem setObject:@"districtlist" forKey:@"ident"];
    [navArray addObject:districtNavItem];
    
    NSMutableDictionary *billboardNavItem = [[NSMutableDictionary alloc] init];
    [billboardNavItem setObject:@"榜上有名" forKey:@"name"];
    [billboardNavItem setObject:@"billboard" forKey:@"ident"];
    [navArray addObject:billboardNavItem];
    
    NSMutableDictionary *supportusNavItem = [[NSMutableDictionary alloc] init];
    [supportusNavItem setObject:@"支持我们" forKey:@"name"];
    [supportusNavItem setObject:@"supportus" forKey:@"ident"];
    [navArray addObject:supportusNavItem];
    
    NSMutableDictionary *reportNavItem = [[NSMutableDictionary alloc] init];
    [reportNavItem setObject:@"意见建议" forKey:@"name"];
    [reportNavItem setObject:@"report" forKey:@"ident"];
    [navArray addObject:reportNavItem];
    
    NSMutableDictionary *settingNavItem = [[NSMutableDictionary alloc] init];
    [settingNavItem setObject:@"系统设置" forKey:@"name"];
    [settingNavItem setObject:@"setting" forKey:@"ident"];
    [navArray addObject:settingNavItem];
    
    self.tableData = [[NSMutableDictionary alloc] init];
    [self.tableData setObject:navArray forKey:@"求生手册"];
    
    self.groupData = [[NSArray alloc] init];
    self.groupData = [self.tableData allKeys];
    
    UITableView *tableView = (UITableView *)self.view;
    tableView.backgroundView = self.bgView;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.groupData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.groupData objectAtIndex:section];
    NSArray *rows = [self.tableData objectForKey:key];
    return [rows count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [self.groupData objectAtIndex:section];
    NSArray *rows = [self.tableData objectForKey:key];
    
    static NSString *CellIdentifier = @"LeftViewTableCell";
	NavCell *cell = (NavCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NavCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.textLabel.text = [[rows objectAtIndex:row] objectForKey:@"name"];
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
    
    if([rows objectAtIndex:[indexPath row]])
    {
        [cell setData:[rows objectAtIndex:row] isSelected:isSelected];
    }
    
	return cell;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.groupData objectAtIndex:section];
    return key;
}
 */
//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 44;
    }
    else
    {
        return 30;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_bar.png"]];
        [view addSubview:bgImageView];
        NSString *key = [self.groupData objectAtIndex:section];
        UILabel *headerLabel = [[UILabel alloc] init];
        headerLabel.text = key;
        headerLabel.textColor = [UIColor whiteColor];
        //headerLabel.font = [UIFont systemFontOfSize:17.0];
        headerLabel.font = [UIFont boldSystemFontOfSize:17.0];
        headerLabel.alpha = 0.6;
        headerLabel.backgroundColor = [UIColor clearColor];
        CGSize headerLabelSize = [headerLabel.text sizeWithFont:headerLabel.font];
        headerLabel.frame = CGRectMake(20, 12, headerLabelSize.width, headerLabelSize.height);
        headerLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        [view addSubview:headerLabel];
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.text = @"v1.1";
        versionLabel.textColor = [UIColor whiteColor];
        versionLabel.font = [UIFont systemFontOfSize:13.0];
        versionLabel.alpha = 0.6;
        versionLabel.backgroundColor = [UIColor clearColor];
        CGSize versionLabelSize = [versionLabel.text sizeWithFont:versionLabel.font];
        versionLabel.frame = CGRectMake(headerLabel.frame.origin.x + headerLabel.frame.size.width + 5, 17, versionLabelSize.width, versionLabelSize.height);
        versionLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        [view addSubview:versionLabel];
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [view setBackgroundColor:[UIColor blueColor]];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    NavCell *cell = (NavCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:1];
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [self.groupData objectAtIndex:section];
    NSArray *rows = [self.tableData objectForKey:key];
    //NSLog(@"%@",[rows objectAtIndex:row]);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"news"])
    {
        [appDelegate.homeNavigationController.view setHidden:NO];
        [appDelegate.typeNavigationController.view setHidden:YES];
        [appDelegate.districtNavigationController.view setHidden:YES];
        [appDelegate.brandNavigationController.view setHidden:YES];
        [appDelegate.settingNavigationController.view setHidden:YES];
        
        appDelegate.homeViewController.isHot = NO;
        [appDelegate.homeViewController.navigationController popToRootViewControllerAnimated:NO];
        [appDelegate.homeViewController refreshData];
        
        [appDelegate goHome];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"hotnews"])
    {
        [appDelegate.homeNavigationController.view setHidden:NO];
        [appDelegate.typeNavigationController.view setHidden:YES];
        [appDelegate.districtNavigationController.view setHidden:YES];
        [appDelegate.brandNavigationController.view setHidden:YES];
        [appDelegate.settingNavigationController.view setHidden:YES];
        
        appDelegate.homeViewController.isHot = YES;
        [appDelegate.homeViewController.navigationController popToRootViewControllerAnimated:NO];
        [appDelegate.homeViewController refreshData];
        
        [appDelegate goHome];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"typelist"])
    {
        [appDelegate.homeNavigationController.view setHidden:YES];
        [appDelegate.typeNavigationController.view setHidden:NO];
        [appDelegate.districtNavigationController.view setHidden:YES];
        [appDelegate.brandNavigationController.view setHidden:YES];
        [appDelegate.settingNavigationController.view setHidden:YES];
        
        [appDelegate.typeViewController.navigationController popToRootViewControllerAnimated:NO];
        
        [appDelegate goHome];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"districtlist"])
    {
        // 受害地区排名
        [appDelegate.homeNavigationController.view setHidden:YES];
        [appDelegate.typeNavigationController.view setHidden:YES];
        [appDelegate.districtNavigationController.view setHidden:NO];
        [appDelegate.brandNavigationController.view setHidden:YES];
        [appDelegate.settingNavigationController.view setHidden:YES];
        
        [appDelegate.districtViewController.navigationController popToRootViewControllerAnimated:NO];
        [appDelegate.districtViewController loadData];
        
        [appDelegate goHome];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"billboard"])
    {
        // 榜上有名
        [appDelegate.homeNavigationController.view setHidden:YES];
        [appDelegate.typeNavigationController.view setHidden:YES];
        [appDelegate.districtNavigationController.view setHidden:YES];
        [appDelegate.brandNavigationController.view setHidden:NO];
        [appDelegate.settingNavigationController.view setHidden:YES];
        
        [appDelegate.brandViewController.navigationController popToRootViewControllerAnimated:NO];
        [appDelegate.brandViewController loadData];
        
        [appDelegate goHome];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"setting"])
    {
        // 系统设置
        [appDelegate.homeNavigationController.view setHidden:YES];
        [appDelegate.typeNavigationController.view setHidden:YES];
        [appDelegate.districtNavigationController.view setHidden:YES];
        [appDelegate.brandNavigationController.view setHidden:YES];
        [appDelegate.settingNavigationController.view setHidden:NO];
        
        //[appDelegate.brandViewController.navigationController popToRootViewControllerAnimated:NO];
        //[appDelegate.brandViewController loadData];
        
        [appDelegate goHome];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"supportus"])
    {
        // 支持我们
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/qiu-sheng-shou-ce/id543817602?ls=1&mt=8"]];
    }
    if([[[rows objectAtIndex:row] objectForKey:@"ident"] isEqualToString:@"report"])
    {
        // 意见建议
        //[appDelegate goHome];
        [appDelegate.homeNavigationController.view setHidden:NO];
        [appDelegate.typeNavigationController.view setHidden:YES];
        [appDelegate.districtNavigationController.view setHidden:YES];
        [appDelegate.brandNavigationController.view setHidden:YES];
        [appDelegate.settingNavigationController.view setHidden:YES];
        
        appDelegate.homeViewController.isHot = NO;
        [appDelegate.homeViewController.navigationController popToRootViewControllerAnimated:NO];
        [appDelegate.homeViewController refreshData];
        
        appDelegate.isReport = YES;
        [appDelegate goHome];
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    NavCell *cell = (NavCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:0];
}
@end
