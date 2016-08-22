//
//  ObjCRuntimeController+ISA.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/18.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ObjCRuntimeController+ISA.h"
#include <objc/runtime.h>

@interface NewClass : UIViewController
- (void)hello;
@end

@implementation NewClass

- (void)hello
{
    NSLog(@"%s", __func__);
}

@end

@implementation ObjCRuntimeController (ISA)

- (void)transform
{
    object_setClass(self, [NewClass class]);
}
@end
