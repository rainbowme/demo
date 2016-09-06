//
//  CubeViewController.m
//  ApproachIOS
//
//  Created by Jerry on 16/9/5.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "CubeViewController.h"

@interface CubeViewController ()
{
    NSTimer *timer;
}
@end

@implementation CubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    // Do any additional setup after loading the view.
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimerTicked:) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTimerTicked:(NSTimer *)timer
{
    static CGFloat value = 0.0f;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeRotation(value, 1, 0, 0);
    transform = CATransform3DRotate(transform, value, 0, 1, 0);
    //transform.m34 = -1.0/500.0;
    self.view.layer.sublayerTransform = transform;
    
    value += 0.008;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CATransform3D transformc = CATransform3DIdentity;
    //transformc.m34 = -1.0/500.0;
    self.view.layer.sublayerTransform = transformc;
    
    // 0
    CATransform3D transform = CATransform3DIdentity;
    [self addFace:0 transform:transform];
    
    // 1
    transform = CATransform3DTranslate(transform, 0, 0, 100);
    [self addFace:1 transform:transform];
    
    // 2
    transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    transform = CATransform3DTranslate(transform, -50, 0, 50);
    [self addFace:2 transform:transform];

    // 3
    transform = CATransform3DMakeTranslation(-50, 0, 50);
    transform =  CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:3 transform:transform];
    
    // 4
    transform = CATransform3DMakeTranslation(0, 50, 50);
    transform =  CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:4 transform:transform];
    
    
    // 5
    transform = CATransform3DMakeTranslation(0, -50, 50);
    transform =  CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:5 transform:transform];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addFace:(NSInteger)index transform:(CATransform3D)transform
{
    CATextLayer *layer = [CATextLayer layer];
    layer.frame = CGRectMake((self.view.bounds.size.width-100)/2, (self.view.bounds.size.height-300)/2, 100, 100);
    //layer.position = CGPointMake((self.view.bounds.size.width-100)/2, (self.view.bounds.size.height-100)/2);
    
    layer.string = [@(index) stringValue];
    layer.alignmentMode = @"center";
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[UIColor redColor]];
    [array addObject:[UIColor greenColor]];
    [array addObject:[UIColor blueColor]];
    [array addObject:[UIColor yellowColor]];
    [array addObject:[UIColor purpleColor]];
    [array addObject:[UIColor darkGrayColor]];

    layer.backgroundColor = ((UIColor *)array[index]).CGColor;
    
    layer.transform = transform;
    
    [self.view.layer addSublayer:layer];
}
@end
