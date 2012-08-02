//
//  PostNewsViewController.h
//  SaveMe
//
//  Created by 魏 杰 on 12-7-30.
//
//

#import <UIKit/UIKit.h>

@interface PostNewsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *shareImageView;
@property (strong, nonatomic) UIBarButtonItem *sendButtonItem;
- (void)setShareImage:(UIImage *)image;
@end
