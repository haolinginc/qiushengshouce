//
//  NavCell.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-18.
//
//

#import <UIKit/UIKit.h>

@interface NavCell : UITableViewCell
@property (strong, nonatomic) UIView *cellContentView;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSString *iconNamePre;
-(void) setData:(NSDictionary *)dataDict isSelected:(BOOL)selected;
-(void) setCellStyle:(NSInteger)style;
@end
