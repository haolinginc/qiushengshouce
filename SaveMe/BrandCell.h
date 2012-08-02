//
//  BrandCell.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-30.
//
//

#import <UIKit/UIKit.h>

@interface BrandCell : UITableViewCell
@property (strong, nonatomic) UIView *cellContentView;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) UILabel *brandLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *numDesLabel;
-(void) setData:(NSDictionary *)dataDict isSelected:(BOOL)selected forRow:(NSInteger)row;
-(void) setCellStyle:(NSInteger)style;
@end
