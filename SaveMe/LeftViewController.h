//
//  LeftViewController.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-17.
//
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) NSMutableDictionary *tableData;
@property (strong, nonatomic) NSArray *groupData;
@end
