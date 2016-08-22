//
//  ApproachThreadController+OperationQueue.h
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController.h"

@interface ApproachThreadController (OperationQueue)

#pragma mark - NSBlockOperation
- (void)blockOperation;

#pragma mark - NSOperationQueue
- (void)operationQueue;
@end
