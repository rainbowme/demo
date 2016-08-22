//
//  ApproachThreadController+OperationQueue.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController+OperationQueue.h"

@implementation ApproachThreadController (OperationQueue)

#pragma mark - NSBlockOperation
- (void)blockOperation
{
    NSLog(@"block operation start");
#if 0
    NSBlockOperation *bop2 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"block operation %@",[NSThread currentThread]);
    }];
#else
    NSBlockOperation *bop2 = [[NSBlockOperation alloc] init];
    [bop2 addExecutionBlock:^{
        sleep(2);
        NSLog(@"block operation %@",[NSThread currentThread]);
    }];
#endif
    [bop2 setCompletionBlock:^{
        NSLog(@"block operation OK !!");
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
            NSLog(@"%p", [NSThread currentThread]);
        }];
    }
}

@end
