//
//  UIViewController+ExhibitHelper.h
//  ApproachIOS
//
//  Created by Aurora on 16/8/23.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ExhibitHelper)

- (void)navigationBarMsg:(NSString *)msg;

- (void)showAlertWithMsg:(NSString *)msg;

- (void)showFloatText:(NSString *)msg;
@end
