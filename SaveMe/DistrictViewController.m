//
//  DistrictViewController.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-26.
//
//

#import "DistrictViewController.h"
#import "AppDelegate.h"
#import "DistrictCell.h"
#import "SBJson/SBJson.h"
#import "ConfigController.h"
#import "HomeViewController.h"

@interface DistrictViewController ()

@end

@implementation DistrictViewController
@synthesize districtData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.districtData = [[NSMutableArray alloc] init];
        self.title = @"受害地区排行";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goLeft:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate goLeftNav];
}

- (void)loadData
{
    [self.districtData removeAllObjects];
    NSString *districtUrl = [NSString stringWithFormat:@"%@/m/province",[ConfigController serverPrefix]];
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
                [self.districtData addObject:object];
            }
            
            [tableView reloadData];
        }
    }];
}

//datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.districtData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DistrictCell";
	DistrictCell *cell = (DistrictCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DistrictCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    
    if([self.districtData objectAtIndex:[indexPath row]])
    {
        [cell setData:[self.districtData objectAtIndex:[indexPath row]] isSelected:isSelected];
    }
	return cell;
}
//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    DistrictCell *cell = (DistrictCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:1];
    /*
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    contentViewController.title = @"求生提醒";
    [contentViewController loadNews:[[self.districtData objectAtIndex:[indexPath row]] objectForKey:@"f_id"]];
    [self.navigationController pushViewController:contentViewController animated:YES];
     */
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil city:[[self.districtData objectAtIndex:[indexPath row]] objectForKey:@"name"]];
    //[[self.districtData objectAtIndex:[indexPath row]] objectForKey:@"name"];
    [self.navigationController pushViewController:homeViewController animated:YES];
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    DistrictCell *cell = (DistrictCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:0];
}
@end
