//
//  BrandCell.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-30.
//
//

#import "BrandCell.h"

@implementation BrandCell
@synthesize cellContentView;
@synthesize backImageView;
@synthesize topImageView;
@synthesize brandLabel;
@synthesize numLabel;
@synthesize numDesLabel;

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
        
        self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_cell.png"]];
        self.backImageView.frame = CGRectMake(0, 0, self.backImageView.frame.size.width, self.backImageView.frame.size.height);
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.cellContentView addSubview:self.backImageView];
        
        self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_level_3.png"]];
        [self.cellContentView addSubview:self.topImageView];
        
        self.brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 115, 25)];
        self.brandLabel.text = @"蒙牛集团";
        self.brandLabel.backgroundColor = [UIColor clearColor];
        [self.cellContentView addSubview:self.brandLabel];
        
        self.numDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 17, 75, 22)];
        self.numDesLabel.text = @"相关事件:";
        self.numDesLabel.font = [UIFont systemFontOfSize:14];
        self.numDesLabel.textColor = [UIColor darkGrayColor];
        self.numDesLabel.backgroundColor = [UIColor clearColor];
        [self.cellContentView addSubview:self.numDesLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 17, 50, 22)];
        self.numLabel.text = @"5";
        self.numLabel.font = [UIFont systemFontOfSize:14];
        self.numLabel.textColor = [UIColor darkGrayColor];
        self.numLabel.backgroundColor = [UIColor clearColor];
        [self.cellContentView addSubview:self.numLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setData:(NSDictionary *)dataDict isSelected:(BOOL)selected forRow:(NSInteger)row
{
    //NSLog(@"data %@",dataDict);
    switch (row) {
        case 0:
            [self.topImageView setImage:[UIImage imageNamed:@"brand_level_1.png"]];
            break;
        
        case 1:
            [self.topImageView setImage:[UIImage imageNamed:@"brand_level_2.png"]];
            break;
        
        default:
            [self.topImageView setImage:[UIImage imageNamed:@"brand_level_3.png"]];
            break;
    }
    if(selected)
    {
        self.backImageView.image = [UIImage imageNamed:@"brand_cell_on.png"];
    }
    else
    {
        self.backImageView.image = [UIImage imageNamed:@"brand_cell.png"];
    }
    
    self.numLabel.text = [dataDict objectForKey:@"num"];
    self.brandLabel.text = [dataDict objectForKey:@"name"];
}
-(void) setCellStyle:(NSInteger)style
{
    if(style == 0)
    {
        self.backImageView.image = [UIImage imageNamed:@"brand_cell.png"];
    }
    else
    {
        self.backImageView.image = [UIImage imageNamed:@"brand_cell_on.png"];
    }
}
@end
