//
//  ReloadView.h
//  SaveMe
//
//  Created by 杰 魏 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReloadViewDelegate.h"

@interface ReloadView : UIView
{
    UIImageView *iconView;
    UILabel *noticeLabel;
    UILabel *updateLabel;
    UIActivityIndicatorView *loadView;
    id<ReloadViewDelegate>delegate;
}
@property (assign, nonatomic) BOOL imageOverturn;
@property (strong, nonatomic) id<ReloadViewDelegate>delegate;

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)dataLoaded:(UIScrollView *)scrollView;

@end
