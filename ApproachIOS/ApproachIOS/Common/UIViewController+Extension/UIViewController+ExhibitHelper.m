//
//  UIViewController+ExhibitHelper.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/23.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "UIViewController+ExhibitHelper.h"

@implementation UIViewController (ExhibitHelper)

- (void)navigationBarMsg:(NSString *)msg
{
    if(self.navigationItem) {
        self.navigationItem.title = msg;
    }
}

- (void)showAlertWithMsg:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
 }

- (void)showFloatText:(NSString *)msg
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, (size.height-120)/2, size.width, 120)];
    textView.text = msg;
    textView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
    textView.font = [UIFont systemFontOfSize:72.0f];
    textView.textColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
    textView.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.3f];
    [window addSubview:view];
    
    [view addSubview:textView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3f animations:^{
            textView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    });
}
@end
