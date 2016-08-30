//
//  ReactiveCocoaController.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/25.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ReactiveCocoaController.h"
#import "ReactiveCocoa.h"

#include <objc/runtime.h>
#include <objc/message.h>

@interface UIView (TouchedView)

@end

@implementation UIView (TouchedView)

static UIView *activeView(id self, SEL _cmd, id value1)
{
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    //void (*objc_msgSendSuperCasted)(void *, SEL, id, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    id obj = objc_msgSendSuper(&superclazz, _cmd, value1);
    
    void(^block)(UIView * view) = objc_getAssociatedObject(self, _cmd);
    if(block && self!=obj) {
        block(obj);
    }
    
    return obj;
}

- (void)touchedView:(void(^)(UIView * view))block
{
    Class aSuperClass = object_getClass(self);
    Class newClass = objc_allocateClassPair(aSuperClass, "__TMP_UIView", 0);
    
    SEL aSel = @selector(hitTest:withEvent:);
    Method md = class_getInstanceMethod(aSuperClass, aSel);
    const char *types = method_getTypeEncoding(md);
    class_addMethod(newClass, aSel, (IMP)activeView, types);
    
    objc_registerClassPair(newClass);
    
    //
    object_setClass(self, newClass);
    
    objc_setAssociatedObject(self, aSel, block, OBJC_ASSOCIATION_COPY);
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return [super pointInside:point withEvent:event];
//}
//
//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    return [super hitTest:point withEvent:event];
//}

@end

@interface ReactiveCocoaController ()
{
    RACSignal *siganl;
}
#pragma mark Test1
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

#pragma mark Test2
@property (weak, nonatomic) IBOutlet UIButton *test2Btn;
@property (weak, nonatomic) IBOutlet UITextField *text2_0Field;
@property (weak, nonatomic) IBOutlet UITextField *text2_1Field;
@end

@implementation ReactiveCocoaController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ReactiveCocoaController" bundle:nil];
    ReactiveCocoaController *vc = [sb instantiateViewControllerWithIdentifier:@"IDReactiveCocoaController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureAction:)];
    [self.view addGestureRecognizer:gesture];
    
    //
    [self activeTest1];
    
    [self activeTest2];
    
    
    [self.view touchedView:^(UIView *view) {
        view.layer.shadowColor = [UIColor redColor].CGColor;//shadowColor阴影颜色
        //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        view.layer.shadowOffset = CGSizeMake(4, 4);
        view.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        view.layer.shadowRadius = 4;//阴影半径，默认3
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onGestureAction:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)activeTest1
{
    // 1.
    siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 1.block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@1];
        
        // 3.如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    
    // 2.
    [[self rac_signalForSelector:@selector(onSiganlClick:)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮");
    }];
    
    // 3.
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮被点击了");
    }];
    
    // 4.把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification
                                                           object:nil] subscribeNext:^(id x)
    {
        NSLog(@"键盘弹出");
    }];
    
    // 5.监听文本框的文字改变
    [[self.textField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"文字改变了%@",x);
    }];
}

- (IBAction)onSiganlClick:(id)sender
{
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}

#pragma mark

- (void)activeTest2
{
    RAC(self.test2Btn, enabled) = [RACSignal combineLatest:@[self.text2_0Field.rac_textSignal, self.text2_1Field.rac_textSignal]
                                                    reduce:^(NSString *username, NSString *password) {
                                                          return @(username.length > 2 && password.length > 2);
                                                    }];
}

- (IBAction)onClick2:(id)sender
{
    
}

@end
