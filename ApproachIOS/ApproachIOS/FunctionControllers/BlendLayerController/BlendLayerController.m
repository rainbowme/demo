//
//  BlendLayerController.m
//  ApproachIOS
//
//  Created by Jerry on 16/9/4.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "BlendLayerController.h"

@interface BlendLayerController ()

@end

@implementation BlendLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame = CGRectMake(50, 50, 80, 80);
    layer1.path = [UIBezierPath bezierPathWithRoundedRect:layer1.bounds cornerRadius:80].CGPath;
    [layer1 setFillColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1.0].CGColor];
    layer1.opaque = YES;
    
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.frame = CGRectMake(90, 90, 80, 80);
    layer2.path = [UIBezierPath bezierPathWithRoundedRect:layer2.bounds cornerRadius:80].CGPath;
    [layer2 setFillColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.5].CGColor];
    layer2.opaque = NO;
    layer2.mask = layer1;
    layer2.masksToBounds = YES;
    
    CAShapeLayer *layer3 = [CAShapeLayer layer];
    layer3.frame = CGRectMake(60, 90, 80, 80);
    layer3.path = [UIBezierPath bezierPathWithRoundedRect:layer3.bounds cornerRadius:80].CGPath;
    [layer3 setFillColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5].CGColor];
    layer3.opaque = NO;
    
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
    
    //self.view.layer.shouldRasterize = YES;
    //self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
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

@end
