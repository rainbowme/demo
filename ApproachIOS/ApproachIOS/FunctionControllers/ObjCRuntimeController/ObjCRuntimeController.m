//
//  ObjCRuntimeController.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/18.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ObjCRuntimeController.h"
#include <objc/runtime.h>

@interface NewClass : UIViewController
- (void)hello;
@end

@implementation NewClass

- (void)hello
{
    NSLog(@"%s", __func__);
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    
}

@end



@implementation ObjCRuntimeController

- (void)transform
{
    object_setClass(self, [NewClass class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self transform];
    [self performSelector:@selector(hello)];
    
    
    void (*setter)(id, SEL);
    setter = (void(*)(id, SEL))[self methodForSelector:@selector(helloxx)];
    setter(self, @selector(helloxx));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)helloxx
{
    NSLog(@"helloxx %s", __func__);
}
@end
