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
    NSTimer *timer;
}
@end

@implementation ApproachKVOController

- (void)dealloc
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [obj addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [obj removeObserver:self forKeyPath:@"index"];
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        obj = [[KVOOBJ alloc] init];
        obj.index = 10;
        
        timer = [NSTimer timerWithTimeInterval:1 target:self
                                      selector:@selector(onTimerTick:)
                                      userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer fire];
    }
    return self;
}

- (void)onTimerTick:(NSTimer *)timer
{
    obj.index++;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    NSInteger index = [[object valueForKey:@"index"] integerValue];
    [self navigationBarMsg:[@(index) stringValue]];
    [self showFloatText:[@(index) stringValue]];
    
}

@end
