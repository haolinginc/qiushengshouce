//
//  DistrictCell.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-27.
//
//

#import <UIKit/UIKit.h>

@interface DistrictCell : UITableViewCell
@property (strong, nonatomic) UIView *cellContentView;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *statusBackImageView;
@property (strong, nonatomic) UIImageView *statusImageView;
@property (strong, nonatomic) UILabel *districtLabel;
@property (strong, nonatomic) UILabel *numLabel;
-(void) setData:(NSDictionary *)dataDict isSelected:(BOOL)selected;
-(void) setCellStyle:(NSInteger)style;
@end
