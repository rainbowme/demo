//
//  ViewController.m
//  LADemo
//
//  Created by Ben on 14/11/17.
//  Copyright (c) 2014年 XTeam. All rights reserved.
//

#import "TNActivityIndicatorController.h"
#import "TNActivityIndicator.h"

static const CFTimeInterval duration = 5.0;

@interface TNActivityIndicatorController ()

@property (strong, nonatomic) TNActivityIndicator *loadingIndicator;
@property (strong, nonatomic) UIImageView *grayHead;
@property (strong, nonatomic) UIImageView *greenHead;
@property (strong, nonatomic) CAShapeLayer *maskLayerUp;
@property (strong, nonatomic) CAShapeLayer *maskLayerDown;

@end

@implementation TNActivityIndicatorController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1
    _grayHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 30, 30)];
    _grayHead.image = [UIImage imageNamed:@"bull_head_gray"];
    [self.view addSubview:_grayHead];
    
    _greenHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 30, 30)];
    _greenHead.image = [UIImage imageNamed:@"bull_head_green"];
    [self.view addSubview:_greenHead];
    
    self.greenHead.layer.mask = [self greenHeadMaskLayer];
    // [self.greenHead.layer addSublayer:[self greenHeadMaskLayer]];
    
    
    // 2
    _loadingIndicator = [[TNActivityIndicator alloc] initWithFrame:CGRectMake(10, 150, 100, 100)];
    [self.view addSubview:_loadingIndicator];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.loadingIndicator startAnimating];
    
    
    [self startGreenHeadAnimation];
}

- (void)startGreenHeadAnimation
{
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    downAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(10.0f, 10.0f)];
    downAnimation.duration = duration;
    [self.maskLayerUp addAnimation:downAnimation forKey:@"downAnimation"];
    
    CABasicAnimation *upAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    upAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(35.0f, 35.0f)];
    upAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(20.0f, 20.0f)];
    upAnimation.duration = duration;
    [self.maskLayerDown addAnimation:upAnimation forKey:@"upAnimation"];
}

- (CALayer *)greenHeadMaskLayer
{
    CALayer *mask = [CALayer layer];
    mask.frame = self.greenHead.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor; // Any color but clear will be OK
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                           radius:15.0f
                                                       startAngle:0
                                                         endAngle:2*M_PI
                                                        clockwise:YES].CGPath;
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor; // Any color but clear will be OK
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                             radius:15.0f
                                                         startAngle:0
                                                           endAngle:2*M_PI
                                                          clockwise:YES].CGPath;
    self.maskLayerDown.position = CGPointMake(35.0f, 35.0f);
    [mask addSublayer:self.maskLayerDown];

    return mask;
}

@end
