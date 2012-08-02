//
//  DistrictCell.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-27.
//
//

#import "DistrictCell.h"

@implementation DistrictCell
@synthesize cellContentView;
@synthesize backImageView;
@synthesize statusBackImageView;
@synthesize statusImageView;
@synthesize districtLabel;
@synthesize numLabel;
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
        
        self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city_cell.png"]];
        self.backImageView.frame = CGRectMake(0, 0, self.backImageView.frame.size.width, self.backImageView.frame.size.height);
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.cellContentView addSubview:self.backImageView];
        
        self.districtLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 19, 70, 22)];
        self.districtLabel.text = @"";
        self.districtLabel.textAlignment = UITextAlignmentRight;
        [self.cellContentView addSubview:self.districtLabel];
        self.districtLabel.textColor = [UIColor grayColor];
        self.districtLabel.backgroundColor = [UIColor clearColor];
        
        self.statusBackImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"city_slip_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)]];
        self.statusBackImageView.frame = CGRectMake(90, 22, 204, 18);
        [self.cellContentView addSubview:self.statusBackImageView];
        
        self.statusImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"city_slip_green.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)]];
        self.statusImageView.frame = CGRectMake(92, 23.5, 4, 14);
        [self.cellContentView addSubview:self.statusImageView];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 21, 60, 20)];
        self.numLabel.text = @"0 例";
        self.numLabel.textColor = [UIColor grayColor];
        self.numLabel.textAlignment = UITextAlignmentRight;
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.font = [UIFont systemFontOfSize:12];
        [self.cellContentView addSubview:self.numLabel];
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
    //NSLog(@"data %@",dataDict);
    if(selected)
    {
        self.backImageView.image = [UIImage imageNamed:@"city_cell_on.png"];
    }
    else
    {
        self.backImageView.image = [UIImage imageNamed:@"city_cell.png"];
    }
    self.districtLabel.text = [dataDict objectForKey:@"name"];
    self.numLabel.text = [NSString stringWithFormat:@"%d 例",[[dataDict objectForKey:@"num"] intValue]];
    
    float per = [[dataDict objectForKey:@"per"] floatValue] / 100;
    float width = per * 200.0;
    if(width < 4.0)
    {
        width = 4.0;
    }
    if(per > 0.15)
    {
        self.statusImageView.image = [[UIImage imageNamed:@"city_slip_red.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    }
    else if(per > 0.07)
    {
        self.statusImageView.image = [[UIImage imageNamed:@"city_slip_yellow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    }
    else if(per <= 0.07)
    {
        self.statusImageView.image = [[UIImage imageNamed:@"city_slip_green.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    }
    self.statusImageView.frame = CGRectMake(self.statusImageView.frame.origin.x, self.statusImageView.frame.origin.y, width, self.statusImageView.frame.size.height);
}
-(void) setCellStyle:(NSInteger)style
{
    if(style == 0)
    {
        self.backImageView.image = [UIImage imageNamed:@"city_cell.png"];
    }
    else
    {
        self.backImageView.image = [UIImage imageNamed:@"city_cell_on.png"];
    }
}
@end
