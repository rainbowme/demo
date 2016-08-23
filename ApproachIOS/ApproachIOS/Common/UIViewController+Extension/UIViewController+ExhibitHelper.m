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

@end
