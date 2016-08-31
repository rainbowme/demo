//
//  NSObject+SwitcherLog.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/31.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "NSObject+SwitcherLog.h"

@implementation NSObject (SwitcherLog)

- (void)showLog:(BOOL)bFlag params:(NSString *)format, ...
{
    if(bFlag) {
        va_list params;
        va_start(params, format);
        NSString *str = [[NSString alloc] initWithFormat:format arguments:params];
        
        NSLog(@"%@", str);
    };
}

@end
