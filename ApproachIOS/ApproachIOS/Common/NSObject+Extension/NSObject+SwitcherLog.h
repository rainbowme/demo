//
//  NSObject+SwitcherLog.h
//  ApproachIOS
//
//  Created by Aurora on 16/8/31.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SwitcherLog)

- (void)showLog:(BOOL)bFlag params:(NSString *)format, ... NS_FORMAT_FUNCTION(2, 3);
@end

#define showLog(flag, ...) [self showLog:flag params:__VA_ARGS__];