//
//  ApproachThreadController+NSThread.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/31.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController+NSThread.h"
static BOOL gFlag = YES;
#define NSLog(...) showLog(gFlag, __VA_ARGS__);

@implementation ApproachThreadController (NSThread)

- (void)registerThreadMethodsWithLog:(BOOL)bFlag
{
    @synchronized (self) {
        gFlag = bFlag;
    }
}

@end
