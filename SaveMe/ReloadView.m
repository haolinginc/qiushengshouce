//
//  ReloadView.m
//  SaveMe
//
//  Created by 杰 魏 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReloadView.h"

@implementation ReloadView
@synthesize imageOverturn;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = 60;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueArrow.png"]];
        [iconView setFrame:CGRectMake(35, 5, 17, 42)];
        iconView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:iconView];
        noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 6, 180, 21)];
        [noticeLabel setText:@"下拉可以刷新..."];
        [noticeLabel setFont:[UIFont systemFontOfSize:13]];
        [noticeLabel setTextAlignment:UITextAlignmentCenter];
        [noticeLabel setTextColor:[UIColor darkGrayColor]];
        [noticeLabel setBackgroundColor:[UIColor clearColor]];
        noticeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:noticeLabel];
        
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
        [outFormat setDateFormat:@"YYYY-MM-dd HH:mm'"];
        NSString *timeStr = [outFormat stringFromDate:nowDate];
        
        updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 28, 180, 21)];
        [updateLabel setText:[NSString stringWithFormat:@"更新时间:%@",timeStr]];
        [updateLabel setFont:[UIFont systemFontOfSize:13]];
        [updateLabel setTextAlignment:UITextAlignmentCenter];
        [updateLabel setTextColor:[UIColor darkGrayColor]];
        [updateLabel setBackgroundColor:[UIColor clearColor]];
        updateLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:updateLabel];
        self.imageOverturn = NO;
        
        loadView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(35, 5, 20, 20)];
        loadView.center = iconView.center;
        loadView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        //[loadView startAnimating];
        [loadView stopAnimating];
        [loadView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:loadView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dataLoaded:(UIScrollView *)scrollView;
{
    if(scrollView.contentOffset.y < 0)
    {
        [UIView animateWithDuration:0.3 animations:^
         {
         }
                         completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.3 animations:^
              {
                  scrollView.contentOffset = CGPointMake(0, 0);
              }
                              completion:^(BOOL finished)
              {
                  scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
              }];
         }];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //NSLog(@"ReloadView dragging end");
    if(scrollView.contentOffset.y < -50)
    {
        
        [UIView animateWithDuration:0.3 animations:^
         {
             scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
             scrollView.contentOffset = CGPointMake(0, -60);
         }
                         completion:^(BOOL finished)
         {
             
         }];
        [delegate refreshViewDidCallBack:self];
        [loadView startAnimating];
        [iconView setHidden:YES];
        
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
        [outFormat setDateFormat:@"YYYY-MM-dd HH:mm'"];
        NSString *timeStr = [outFormat stringFromDate:nowDate];
        
        [updateLabel setText:[NSString stringWithFormat:@"更新时间:%@",timeStr]];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"offset_y:%f height:%f",scrollView.contentOffset.y,scrollView.contentSize.height - scrollView.bounds.size.height);
    if(scrollView.contentOffset.y >= 0)
    {
        [loadView stopAnimating];
        [iconView setHidden:NO];
    }
    if(scrollView.contentOffset.y < -50)
    {
        if(!self.imageOverturn)
        {
            self.imageOverturn = YES;
            [UIView animateWithDuration:0.2 animations:^
             {
                 iconView.transform = CGAffineTransformMakeRotation(180 * M_PI / 180.0);
             }
                             completion:^(BOOL finished)
             {
                 [noticeLabel setText:@"可以松开了"];
             }];
        }
    }
    else
    {
        if(self.imageOverturn)
        {
            self.imageOverturn = NO;
            [UIView animateWithDuration:0.2 animations:^
             {
                 iconView.transform = CGAffineTransformMakeRotation(0 * M_PI / 180.0);
             }
                             completion:^(BOOL finished)
             {
                 [noticeLabel setText:@"下拉可以刷新..."];
             }];
        }
    }
}

@end
