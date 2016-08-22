//
//  ApproachThreadController+GCD.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController+GCD.h"

@implementation ApproachThreadController (GCD)

#pragma mark - GCD

- (void)gcdDemo
{
    static dispatch_queue_t serialQueue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serialQueue = dispatch_queue_create("345678", DISPATCH_QUEUE_CONCURRENT); // DISPATCH_QUEUE_SERIAL
    });
    
    for(NSInteger i=0; i<20; i++) {
        dispatch_async(serialQueue, ^{
            sleep(1);
            NSLog(@"%p", [NSThread currentThread]);
        });
    }
}
@end
