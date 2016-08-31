//
//  ApproachThreadController+OperationQueue.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController+OperationQueue.h"

static BOOL gFlag = YES;
#define NSLog(...) showLog(gFlag, __VA_ARGS__);

@implementation ApproachThreadController (OperationQueue)

- (void)registerOpQueueMethodsWithLog:(BOOL)bFlag
{
    @synchronized (self) {
        gFlag = bFlag;
    }
    
    [self blockOperation];
    
    [self operationQueue];
}

#pragma mark - NSBlockOperation
- (void)blockOperation
{
    NSLog(@"NSOperationQueue: block operation start");
#if 0
    NSBlockOperation *bop2 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"NSOperationQueue: block operation %@",[NSThread currentThread]);
    }];
#else
    NSBlockOperation *bop2 = [[NSBlockOperation alloc] init];
    [bop2 addExecutionBlock:^{
        //sleep(2);
        NSLog(@"NSOperationQueue: block operation %@",[NSThread currentThread]);
    }];
#endif
    [bop2 setCompletionBlock:^{
        NSLog(@"NSOperationQueue: block operation OK !!");
    }];
    [bop2 start];
}

#pragma mark - NSOperationQueue
- (void)operationQueue
{
    static NSOperationQueue *operationQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationQueue = [[NSOperationQueue alloc] init];
    });
    
    [operationQueue setMaxConcurrentOperationCount:20];
    for(NSInteger i=0; i<20; i++) {
        [operationQueue addOperationWithBlock:^{
            sleep(3);
            NSLog(@"NSOperationQueue: %p", [NSThread currentThread]);
        }];
    }
}

@end
