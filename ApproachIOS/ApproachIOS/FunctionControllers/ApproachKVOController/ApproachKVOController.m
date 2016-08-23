//
//  ApproachKVO.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/15.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachKVOController.h"


@interface KVOOBJ : NSObject
@property (assign, nonatomic) NSInteger index;
@end

@implementation KVOOBJ
@end

@interface ApproachKVOController ()
{
    KVOOBJ *obj;
}
@end

@implementation ApproachKVOController

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        obj = [KVOOBJ new];
        [obj addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:NULL];
        
        //
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            obj.index = 10;
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            obj.index = 11;
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            obj.index = 13;
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            obj.index = 16;
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            obj.index = 18;
        });
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == NULL) {
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    NSInteger index = [[object valueForKey:@"index"] integerValue];
    if(index==18) {
        [obj removeObserver:self forKeyPath:@"index"];
        [self navigationBarMsg:@"Removed_KVO"];
    } else {
        [self navigationBarMsg:[@(index) stringValue]];
    }
}

@end
