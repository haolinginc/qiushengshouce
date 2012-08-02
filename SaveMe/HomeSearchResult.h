//
//  HomeSearchResult.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-19.
//
//

#import <Foundation/Foundation.h>
@class HomeViewController;
@class NewsCell;
@interface HomeSearchResult : NSObject<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *homeData;
@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) UISearchDisplayController *searchDisplay;
@property (strong, nonatomic) NewsCell *curNewsCell;
@end
