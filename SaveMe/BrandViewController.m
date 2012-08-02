//
//  BrandViewController.m
//  SaveMe
//
//  Created by 杰 魏 tonyvicky on 12-7-3.
//  Copyright (c) 2012年 HaoLing. All rights reserved.
//

#import "BrandViewController.h"
#import "AppDelegate.h"
#import "BrandCell.h"
#import "SBJson/SBJson.h"
#import "ConfigController.h"
#import "HomeViewController.h"

@interface BrandViewController ()

@end

@implementation BrandViewController
@synthesize brandData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.brandData = [[NSMutableArray alloc] init];
        self.title = @"榜上有名";
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

- (void)loadData
{
    [self.brandData removeAllObjects];
    NSString *districtUrl = [NSString stringWithFormat:@"%@/m/brand",[ConfigController serverPrefix]];
    //NSLog(@"%@",districtUrl);
    NSMutableURLRequest *rowRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:districtUrl]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:rowRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if ([data length]>0 && error==nil) {
            NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:jsonString error:nil];
            //NSLog(@"%@",result);
            //NSLog(@"%@",jsonString);
            UITableView *tableView = (UITableView *)self.view;
            for (NSDictionary *object in result)
            {
                //NSLog(@"%@",object);
                //[self.homeData addObject:object];
                [self.brandData addObject:object];
            }
            
            [tableView reloadData];
        }
    }];
}

//datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.brandData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DistrictCell";
	BrandCell *cell = (BrandCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[BrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
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
    
    if([self.brandData objectAtIndex:[indexPath row]])
    {
        [cell setData:[self.brandData objectAtIndex:[indexPath row]] isSelected:isSelected forRow:[indexPath row]];
    }
	return cell;
}
//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    BrandCell *cell = (BrandCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:1];
    /*
     ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
     contentViewController.title = @"求生提醒";
     [contentViewController loadNews:[[self.districtData objectAtIndex:[indexPath row]] objectForKey:@"f_id"]];
     [self.navigationController pushViewController:contentViewController animated:YES];
     */
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil brand:[[self.brandData objectAtIndex:[indexPath row]] objectForKey:@"name"]];
    //[[self.districtData objectAtIndex:[indexPath row]] objectForKey:@"name"];
    [self.navigationController pushViewController:homeViewController animated:YES];
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    BrandCell *cell = (BrandCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:0];
}

@end
