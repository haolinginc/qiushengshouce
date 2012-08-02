//
//  SettingViewController.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize bgView;
@synthesize tableData;
@synthesize tableGroup;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"关于求生手册";
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
    
    UIBarButtonItem *typeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemDone target:self action:@selector(goLeft:)];
    typeButtonItem.image = [UIImage imageNamed:@"more_icon.png"];
    self.navigationItem.leftBarButtonItem = typeButtonItem;
    
    UITableView *tableView = (UITableView *)self.view;
    tableView.backgroundView = bgView;
    
    NSArray *settingsArray = [NSArray arrayWithObjects:@"推送通知",nil];
    NSArray *miscArray = [NSArray arrayWithObjects: @"求生手册版本", nil];
    self.tableData = [[NSMutableDictionary alloc] init];
    [self.tableData setObject:settingsArray forKey:@"settings"];
    [self.tableData setObject:miscArray forKey:@"misc"];
    self.tableGroup = [[NSArray alloc] initWithArray:[self.tableData allKeys]];
    
    //[[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    //NSLog(@"%d",[[UIApplication sharedApplication] enabledRemoteNotificationTypes]);
}

- (void)goLeft:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate goLeftNav];
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

- (void)goSwitch:(id)sender
{
    //NSLog(@"touch");
    UISwitch *switcher = (UISwitch *)sender;
    if(switcher.on)
    {
        //NSLog(@"on");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeNewsstandContentAvailability)];
    }
    else
    {
        //NSLog(@"off");
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
}
// delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    if(section == 1 && row == 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        //[[picker navigationBar] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        //picker.delegate = self;
        picker.mailComposeDelegate = self;
        //NSLog(@"%@",self.dataDict);
        [picker setSubject:@"食品安全问题"];
        [picker setToRecipients:[NSArray arrayWithObject:@"life@0569.com"]];
        [self presentModalViewController:picker animated:YES];
    }*/
}
// data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableGroup count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.tableGroup objectAtIndex:section];
    NSArray *data = [self.tableData objectForKey:key];
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [self.tableGroup objectAtIndex:section];
    NSArray *data = [self.tableData objectForKey:key];
    static NSString *CellIdentifier = @"settingCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.accessoryView = [[UISwitch alloc] init];
        if(section == 0 && row == 0)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch *switcher = [[UISwitch alloc] init];
            cell.accessoryView = switcher;
            if([[UIApplication sharedApplication] enabledRemoteNotificationTypes])
            {
                [switcher setOn:YES];
            }
            else
            {
                [switcher setOn:NO];
            }
            [switcher addTarget:self action:@selector(goSwitch:) forControlEvents:UIControlEventTouchUpInside];
        }
        if(section == 1 && row == 0)
        {
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(section == 1 && row == 0)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 22)];
            versionLabel.text = @"1.1";
            versionLabel.font = [UIFont systemFontOfSize:15];
            versionLabel.backgroundColor = [UIColor clearColor];
            CGSize labelSize = [versionLabel.text sizeWithFont:versionLabel.font];
            versionLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
            cell.accessoryView = versionLabel;
        }
	}
    
    cell.textLabel.text = [data objectAtIndex:row];
	return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //NSString *key = [self.tableGroup objectAtIndex:section];
    //return key;
    return nil;
}
// mail delegate
/*
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}
*/
@end
