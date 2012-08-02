//
//  NavCell.m
//  SaveMe
//
//  Created by 魏 杰 on 12-7-18.
//
//

#import "NavCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation NavCell
@synthesize backImageView;
@synthesize iconImageView;
@synthesize titleLabel;
@synthesize iconNamePre;
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
        
        self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_cell_bg.png"]];
        self.backImageView.frame = CGRectMake(0, 0, self.backImageView.frame.size.width, self.backImageView.frame.size.height);
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.cellContentView addSubview:self.backImageView];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 44)];
        self.iconImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.cellContentView addSubview:self.iconImageView];
        //self.iconImageView.image = [UIImage imageNamed:@"tools_icon_new.png"];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 25)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        /*
        self.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.titleLabel.layer.shadowOpacity = 0.8;
        self.titleLabel.layer.shadowOffset = CGSizeMake(0, 1);
        self.titleLabel.layer.shadowRadius = 1;
         */
        [self.cellContentView addSubview:self.titleLabel];
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
    //NSLog(@"%@",[dataDict objectForKey:@"ident"]);
    //self.backImageView.image = [UIImage imageNamed:@"cell_bg.png"];
    //[self.typeImageView setHidden:NO];
    self.titleLabel.text = [dataDict objectForKey:@"name"];
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"news"])
    {
        self.iconNamePre = @"tools_icon_new";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"hotnews"])
    {
        self.iconNamePre = @"tools_icon_hot";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"typelist"])
    {
        self.iconNamePre = @"tools_icon_type";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"districtlist"])
    {
        self.iconNamePre = @"tools_icon_city";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"billboard"])
    {
        self.iconNamePre = @"tools_icon_top";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"supportus"])
    {
        self.iconNamePre = @"tools_icon_support";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"report"])
    {
        self.iconNamePre = @"tools_icon_suggest";
    }
    if([[dataDict objectForKey:@"ident"] isEqualToString:@"setting"])
    {
        self.iconNamePre = @"tools_icon_set";
    }
    NSString *iconName;
    if(selected)
    {
        //self.backImageView.image = [UIImage imageNamed:@"cell_bg_on.png"];
        //[self.typeImageView setHidden:YES];
        iconName = [NSString stringWithFormat:@"%@_on.png",self.iconNamePre];
    }
    else
    {
        //self.backImageView.image = [UIImage imageNamed:@"cell_bg.png"];
        //[self.typeImageView setHidden:NO];
        iconName = [NSString stringWithFormat:@"%@.png",self.iconNamePre];
    }
    self.iconImageView.image = [UIImage imageNamed:iconName];
}
-(void) setCellStyle:(NSInteger)style
{
    NSString *iconName;
    if(style == 0)
    {
        //self.backImageView.image = [UIImage imageNamed:@"cell_bg.png"];
        //[self.typeImageView setHidden:NO];
        iconName = [NSString stringWithFormat:@"%@.png",self.iconNamePre];
    }
    else
    {
        //self.backImageView.image = [UIImage imageNamed:@"cell_bg_on.png"];
        //[self.typeImageView setHidden:YES];
        iconName = [NSString stringWithFormat:@"%@_on.png",self.iconNamePre];
    }
    self.iconImageView.image = [UIImage imageNamed:iconName];
}
@end
