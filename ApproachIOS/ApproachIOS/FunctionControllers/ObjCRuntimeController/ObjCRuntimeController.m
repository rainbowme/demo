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




// 1.动态方法解析(Dynamic Method Resolution或Lazy method resolution)
// 向当前类(Class)发送resolveInstanceMethod:(对于类方法则为resolveClassMethod:)消息，
// 如果返回YES,则系统认为请求的方法已经加入到了，则会重新发送消息。
#if 0
+ (BOOL)resolveClassMethod:(SEL)sel
{
    BOOL bRet = [super resolveClassMethod:sel];
    return bRet;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    BOOL bRet = [super resolveInstanceMethod:sel];
    // 动态添加处理方法
    return bRet;
}
#endif




// 2.快速转发路径(Fast forwarding path)
// 若果当前target实现了forwardingTargetForSelector:方法,则调用此方法。
// 如果此方法返回除nil和self的其他对象，则向返回对象重新发送消息。
#if 0
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    id obj = [super forwardingTargetForSelector:aSelector];
    // 添加转发对象
    return obj;
}
#endif




// 3.慢速转发路径(Normal forwarding path)
// 首先runtime发送methodSignatureForSelector:消息查看Selector对应的方法签名，即参数与返回值的类型信息。
// 如果有方法签名返回，runtime则根据方法签名创建描述该消息的NSInvocation，向当前对象发送forwardInvocation:消息，
// 以创建的NSInvocation对象作为参数；若methodSignatureForSelector:无方法签名返回，
// 则向当前对象发送doesNotRecognizeSelector:消息,程序抛出异常退出。
#if 1
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:selector];
    if(!sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    
}
#endif
@end



@implementation ObjCRuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    object_setClass(self, [NewClass class]);
    //[self performSelector:@selector(hello)];
    
    [self helloxx];
    
    
//    void (*setter)(id, SEL);
//    setter = (void(*)(id, SEL))[self methodForSelector:@selector(helloxx)];
//    setter(self, @selector(helloxx));
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
