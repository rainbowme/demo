//
//  AnimationController.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/24.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()
{
    IBOutlet __weak UIButton *btn;
    IBOutlet __weak UIScrollView *scview;
}
@end

@implementation AnimationController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AnimationController" bundle:nil];
    AnimationController *vc = [sb instantiateViewControllerWithIdentifier:@"IDAnimationController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [btn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
#if 0
    CGSize size = scview.frame.size;
    scview.contentSize = CGSizeMake((size.width-40)*2, size.height);
    scview.pagingEnabled = YES;
    scview.backgroundColor = [UIColor lightGrayColor];
    
    // 1
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 15, size.width-40, size.height-30)];
    view.backgroundColor = [UIColor greenColor];
    [scview addSubview:view];
    
    // 2
    view = [[UIView alloc] initWithFrame:CGRectMake(size.width-40, 15, size.width-40, size.height-30)];
    view.backgroundColor = [UIColor redColor];
    [scview addSubview:view];
#else
    CGSize size = scview.frame.size;
    scview.contentSize = CGSizeMake((size.width-40)*2, size.height);
    scview.pagingEnabled = YES;
    
    scview.backgroundColor = [UIColor lightGrayColor];
    
    // 1
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 15, size.width-40, size.height-30)];
    view.backgroundColor = [UIColor greenColor];
    [scview addSubview:view];
    
    // 2
    CGFloat mid = (size.width*3-(size.width-80))/2;
    view = [[UIView alloc] initWithFrame:CGRectMake(size.width-40, 15, size.width-40, size.height-30)];
    view.backgroundColor = [UIColor redColor];
    [scview addSubview:view];
    
    // 3
    view = [[UIView alloc] initWithFrame:CGRectMake(size.width*2-40, 15, size.width-20, size.height-30)];
    view.backgroundColor = [UIColor blueColor];
//    [scview addSubview:view];
#endif
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

- (void)onClicked:(UIButton *)sender
{
    
}

+ (NSMutableArray *)animationValues:(id)fromValue
                            toValue:(id)toValue
             usingSpringWithDamping:(CGFloat)damping
              initialSpringVelocity:(CGFloat)velocity
                           duration:(CGFloat)duration
{
    // 60个关键帧
    NSInteger numOfPoints  = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfPoints];
    for (NSInteger i=0; i<numOfPoints; i++) {
        [values addObject:@(0.0)];
    }
    // 差值
    CGFloat d_value = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger point=0; point<numOfPoints; point++) {
        CGFloat x = (CGFloat)point/(CGFloat)numOfPoints;
        // y = 1-e^{-5x}*cos(30x)
        CGFloat value = [toValue floatValue]-d_value*(pow(M_E, -damping*x)*cos(velocity*x));
        values[point] = @(value);
    }
    return values;
}

+ (CAKeyframeAnimation *)createSpring:(NSString *)keypath
                            duration:(CFTimeInterval)duration
              usingSpringWithDamping:(CGFloat)damping
               initialSpringVelocity:(CGFloat)velocity
                           fromValue:(id)fromValue
                             toValue:(id)toValue
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    NSMutableArray *values = [self animationValues:fromValue
                                           toValue:toValue
                            usingSpringWithDamping:damping //* dampingFactor
                             initialSpringVelocity:velocity //* velocityFactor
                                          duration:duration];
    anim.values = values;
    anim.duration = duration;
    return anim;
}
@end
