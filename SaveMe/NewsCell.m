//
//  NewsCell.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize cellContentView;
@synthesize backImageView;
@synthesize typeImageView;
@synthesize titleLabel;
@synthesize typeDesLabel;
@synthesize typeLabel;
@synthesize brandDesLabel;
@synthesize brandLabel;
@synthesize districtDesLabel;
@synthesize districtLabel;
@synthesize levelDesLabel;
@synthesize levelImageView;
@synthesize dateLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.textLabel removeFromSuperview];
        
        self.cellContentView = [[UIView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0, 0.0)];
        self.cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.cellContentView.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview:self.cellContentView];
        //self.view.backgroundColor=[UIColor colorWithPatternImage:backgroudImage];
        //self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg.png"]];
        
        
        self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
        self.backImageView.frame = CGRectMake(0, 0, self.backImageView.frame.size.width, self.backImageView.frame.size.height);
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.cellContentView addSubview:self.backImageView];
        
        self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 85)];
        self.typeImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        self.typeImageView.image = [UIImage imageNamed:@"tag_10.png"];
        [self.cellContentView addSubview:self.typeImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 250, 25)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.titleLabel];
        //[self.titleLabel setBackgroundColor:[UIColor blackColor]];
        self.titleLabel.text = @"黑食品厂瞧瞧黑食品厂瞧瞧黑食";
        
        self.levelDesLabel = [[UILabel alloc] init];
        self.levelDesLabel.font = [UIFont systemFontOfSize:14];
        self.levelDesLabel.text = @"危害:";
        self.levelDesLabel.textColor = [UIColor grayColor];
        CGSize levelSize = [self.levelDesLabel.text sizeWithFont:self.levelDesLabel.font];
        self.levelDesLabel.frame = CGRectMake(18, 37, levelSize.width, levelSize.height);
        self.levelDesLabel.backgroundColor = [UIColor clearColor];
        self.levelDesLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.levelDesLabel];
        
        self.levelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 40, 75, 12)];
        self.levelImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.levelImageView];
        self.levelImageView.image = [UIImage imageNamed:@"fuck_05.png"];
        
        self.districtDesLabel = [[UILabel alloc] init];
        self.districtDesLabel.font = [UIFont systemFontOfSize:14];
        self.districtDesLabel.text = @"地区:";
        self.districtDesLabel.textColor = [UIColor grayColor];
        CGSize districtDesSize = [self.districtDesLabel.text sizeWithFont:self.districtDesLabel.font];
        self.districtDesLabel.frame = CGRectMake(18, 60, districtDesSize.width, districtDesSize.height);
        self.districtDesLabel.backgroundColor = [UIColor clearColor];
        self.districtDesLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.districtDesLabel];
        
        self.districtLabel =[[UILabel alloc] initWithFrame:CGRectMake(55, 60, 60, 18)];
        self.districtLabel.font = [UIFont systemFontOfSize:14];
        self.districtLabel.text = @"全国全国";
        self.districtLabel.textColor = [UIColor grayColor];
        self.districtLabel.backgroundColor = [UIColor clearColor];
        self.districtLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.districtLabel];
        
        self.typeDesLabel = [[UILabel alloc] init];
        self.typeDesLabel.font = [UIFont systemFontOfSize:14];
        self.typeDesLabel.text = @"类别:";
        self.typeDesLabel.textColor = [UIColor grayColor];
        CGSize typeDesSize = [self.typeDesLabel.text sizeWithFont:self.typeDesLabel.font];
        self.typeDesLabel.frame = CGRectMake(120, 60, typeDesSize.width, typeDesSize.height);
        self.typeDesLabel.backgroundColor = [UIColor clearColor];
        self.typeDesLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.typeDesLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 60, 45, 18)];
        self.typeLabel.font = [UIFont systemFontOfSize:14];
        self.typeLabel.text = @"饮料啊";
        self.typeLabel.textColor = [UIColor grayColor];
        self.typeLabel.backgroundColor = [UIColor clearColor];
        self.typeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.typeLabel];
        
        self.brandDesLabel = [[UILabel alloc] init];
        self.brandDesLabel.font = [UIFont systemFontOfSize:14];
        self.brandDesLabel.text = @"品牌:";
        self.brandDesLabel.textColor = [UIColor grayColor];
        CGSize brandDesSize = [self.brandDesLabel.text sizeWithFont:self.brandDesLabel.font];
        self.brandDesLabel.frame = CGRectMake(210, 60, brandDesSize.width, brandDesSize.height);
        self.brandDesLabel.backgroundColor = [UIColor clearColor];
        self.brandDesLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.brandDesLabel];
        
        self.brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 60, 70, 18)];
        self.brandLabel.font = [UIFont systemFontOfSize:14];
        self.brandLabel.text = @"我测试啊啊";
        self.brandLabel.textColor = [UIColor grayColor];
        self.brandLabel.backgroundColor = [UIColor clearColor];
        self.brandLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.cellContentView addSubview:self.brandLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 55, 18)];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        self.dateLabel.text = @"22-05-05";
        self.dateLabel.textColor = [UIColor grayColor];
        self.dateLabel.textAlignment = UITextAlignmentRight;
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self.cellContentView addSubview:self.dateLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) setData:(NSDictionary *)dataDict isSelected:(BOOL)selected
{
    //self.backImageView.image = [UIImage imageNamed:@"cell_bg.png"];
    //[self.typeImageView setHidden:NO];
    if(selected)
    {
        self.backImageView.image = [UIImage imageNamed:@"cell_bg_on.png"];
        //[self.typeImageView setHidden:YES];
    }
    else
    {
        self.backImageView.image = [UIImage imageNamed:@"cell_bg.png"];
        //[self.typeImageView setHidden:NO];
    }
    self.dateLabel.text = [dataDict objectForKey:@"f_date"];
    self.brandLabel.text = [dataDict objectForKey:@"f_brand"];
    self.districtLabel.text = [dataDict objectForKey:@"f_province"];
    self.titleLabel.text = [dataDict objectForKey:@"f_title"];
    self.typeLabel.text = [dataDict objectForKey:@"f_type_name"];
    switch ([[dataDict objectForKey:@"f_level"] intValue]) {
        case 1:
            self.levelImageView.image = [UIImage imageNamed:@"fuck_01.png"];
            break;
        case 2:
            self.levelImageView.image = [UIImage imageNamed:@"fuck_02.png"];
            break;
        case 3:
            self.levelImageView.image = [UIImage imageNamed:@"fuck_03.png"];
            break;
        case 4:
            self.levelImageView.image = [UIImage imageNamed:@"fuck_04.png"];
            break;
        case 5:
            self.levelImageView.image = [UIImage imageNamed:@"fuck_05.png"];
            break;
        default:
            break;
    }
    
    switch ([[dataDict objectForKey:@"f_type"] intValue]) {
        case 1:
            self.typeImageView.image = [UIImage imageNamed:@"tag_01.png"];
            break;
        case 2:
            self.typeImageView.image = [UIImage imageNamed:@"tag_02.png"];
            break;
        case 3:
            self.typeImageView.image = [UIImage imageNamed:@"tag_03.png"];
            break;
        case 4:
            self.typeImageView.image = [UIImage imageNamed:@"tag_04.png"];
            break;
        case 5:
            self.typeImageView.image = [UIImage imageNamed:@"tag_05.png"];
            break;
        case 6:
            self.typeImageView.image = [UIImage imageNamed:@"tag_06.png"];
            break;
        case 7:
            self.typeImageView.image = [UIImage imageNamed:@"tag_07.png"];
            break;
        case 8:
            self.typeImageView.image = [UIImage imageNamed:@"tag_08.png"];
            break;
        case 9:
            self.typeImageView.image = [UIImage imageNamed:@"tag_09.png"];
            break;
        case 10:
            self.typeImageView.image = [UIImage imageNamed:@"tag_10.png"];
            break;
        case 11:
            self.typeImageView.image = [UIImage imageNamed:@"tag_11.png"];
            break;
        case 12:
            self.typeImageView.image = [UIImage imageNamed:@"tag_12.png"];
            break;
        default:
            break;
    }
}

-(void) setCellStyle:(NSInteger)style
{
    if(style == 0)
    {
        self.backImageView.image = [UIImage imageNamed:@"cell_bg.png"];
        //[self.typeImageView setHidden:NO];
    }
    else
    {
        self.backImageView.image = [UIImage imageNamed:@"cell_bg_on.png"];
        //[self.typeImageView setHidden:YES];
    }
}
@end
