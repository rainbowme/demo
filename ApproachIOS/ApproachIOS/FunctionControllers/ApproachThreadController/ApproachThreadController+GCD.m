//
//  ApproachThreadController+GCD.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController+GCD.h"

static BOOL gFlag = YES;
#define NSLog(...) showLog(gFlag, __VA_ARGS__);
@implementation ApproachThreadController (GCD)

- (void)registerGCDMethodsWithLog:(BOOL)bFlag
{
    @synchronized (self) {
        gFlag = bFlag;
    }
    
    [self gcdDemo];
}

#pragma mark - GCD

// 串行或并行队列，dispatch_sync为了优化，将都在当前线程中运行。
// 队列和线程是两件事
- (void)gcdDemo
{
    static dispatch_queue_t serialQueue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serialQueue = dispatch_queue_create("345678", DISPATCH_QUEUE_CONCURRENT);
        //serialQueue = dispatch_queue_create("345678", DISPATCH_QUEUE_SERIAL);
    });
    
    for(NSInteger i=0; i<20; i++) {
        dispatch_sync(serialQueue, ^{
            NSLog(@"GCD: %@", [NSThread currentThread]);
        });
    }
}

@end
