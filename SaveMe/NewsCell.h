//
//  NewsCell.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property (strong, nonatomic) UIView *cellContentView;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *typeImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *typeDesLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *brandDesLabel;
@property (strong, nonatomic) UILabel *brandLabel;
@property (strong, nonatomic) UILabel *districtDesLabel;
@property (strong, nonatomic) UILabel *districtLabel;
@property (strong, nonatomic) UILabel *levelDesLabel;
@property (strong, nonatomic) UIImageView *levelImageView;
@property (strong, nonatomic) UILabel *dateLabel;

-(void) setData:(NSDictionary *)dataDict isSelected:(BOOL)selected;
-(void) setCellStyle:(NSInteger)style;
@end
