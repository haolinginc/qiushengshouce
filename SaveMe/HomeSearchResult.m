//
//  HomeSearchResult.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-19.
//
//

#import "HomeSearchResult.h"
#import "NewsCell.h"
#import "ConfigController.h"
#import "SBJson/SBJson.h"
#import "ContentViewController.h"
#import "HomeViewController.h"

@implementation HomeSearchResult
@synthesize homeData;
@synthesize homeViewController;
@synthesize searchDisplay;
@synthesize curNewsCell;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.homeData = [[NSMutableArray alloc] init];
    }
    return self;
}

// data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identifier = @"NewsCell";
    NewsCell *cell = (NewsCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    //NSLog(@"res");
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
    if(self.curNewsCell)
    {
        [self.curNewsCell setCellStyle:0];
    }
    NewsCell *cell = (NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:1];
    //NSLog(@"%@",[[self.homeData objectAtIndex:[indexPath row]] objectForKey:@"f_id"]);
    //UIViewController *vc = [[UIViewController alloc] init];
    //vc.title = @"test";
    //[self.navigationController pushViewController:vc animated:YES];
    NewsCell *tmpcell = (NewsCell*)[tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
    self.curNewsCell = tmpcell;
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    contentViewController.title = @"求生提醒";
    [contentViewController loadNews:[[self.homeData objectAtIndex:[indexPath row]] objectForKey:@"f_id"]];
    [self.homeViewController.navigationController pushViewController:contentViewController animated:YES];
}

/*
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[indexPath row]);
    NewsCell *cell = (NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellStyle:0];
    NSLog(@"dedede");
}
 */
/*
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[tableView indexPathForSelectedRow]);
    if([tableView indexPathForSelectedRow])
    {
        NSLog(@"%d",[[tableView indexPathForSelectedRow] row]);
        NewsCell *cell = (NewsCell*)[tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
        [cell setCellStyle:0];
    }
    return indexPath;
}
 */

//search display delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //NSLog(@"%@",searchString);
    if(!self.searchDisplay)
    {
        self.searchDisplay = controller;
        [self.searchDisplay.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //NSLog(@"fuzhi");
    }
    [self.homeData removeAllObjects];
    [self.searchDisplay.searchResultsTableView reloadData];
    return NO;
}
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [controller.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.homeData removeAllObjects];
}
//searchbar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchDisplay.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSString *searchURL = [NSString stringWithFormat:@"%@/m/search/key/%@",[ConfigController serverPrefix],[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *searchRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:searchURL]];
    [searchRequest setHTTPMethod:@"POST"];
    NSString *post_keyword = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(__bridge CFStringRef)@"test", nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    NSString *postURLStr = [NSString stringWithFormat:@"keyword=%@",post_keyword];
    NSData *postData = [postURLStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [searchRequest setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:searchRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *respone,NSData *data,NSError *error)
     {
         if ([data length]>0 && error==nil)
         {
             NSString *resultString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             //NSLog(@"------%@",resultString);
             NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithString:resultString error:nil];
             //NSLog(@"%d",[result count]);
             if([result count] > 0)
             {
                 for (NSDictionary *object in result)
                 {
                     [self.homeData addObject:object];
                 }
             }
             [self.searchDisplay.searchResultsTableView reloadData];
         }
         else
         {
             //NSLog(@"%@",error);
         }
     }];
}
@end
