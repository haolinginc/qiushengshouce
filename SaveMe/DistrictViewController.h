//
//  DistrictViewController.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-26.
//
//

#import <UIKit/UIKit.h>

@interface DistrictViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *districtData;
- (void)loadData;
@end
