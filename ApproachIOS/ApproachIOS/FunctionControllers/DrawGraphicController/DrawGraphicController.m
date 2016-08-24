//
//  DrawGraphicController.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "DrawGraphicController.h"

@interface DataInfo : NSObject
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL enable;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) void(^block)(CGContextRef context);
@end
@implementation DataInfo
@end


@interface DrawGraphicController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@end

CLASS_EXPORTS(DrawGraphicController) ()
{
    NSMutableDictionary *dataDictionary;
    NSMutableDictionary *blockDictionary;
}
@end

typedef NS_ENUM(NSInteger, MethodIndex) {
    kMIDrawLine,
    kMIDrawText
};
@implementation DrawGraphicController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DrawGraphicController" bundle:nil];
    DrawGraphicController *vc = [sb instantiateViewControllerWithIdentifier:@"IDDrawGraphicController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.layer.borderWidth = 1.0f;
    self.imageView.layer.borderColor = [UIColor greenColor].CGColor;
    dataDictionary = [NSMutableDictionary dictionary];
    
#define DRAW_GRAPHIC_WITH_BLOCK(index, text) \
self registerId:kMIDrawLine name:@"画一条线" forDrawBlock:^(CGContextRef context)
    //UIGraphicsPushContext(context);
    //UIGraphicsPopContext();
    // NO.1画一条线
    [DRAW_GRAPHIC_WITH_BLOCK(kMIDrawLine, @"画一条线") {
        CGContextSaveGState(context);
        CGContextSetRGBStrokeColor(context, 1.0, 0.5, 0.5, 0.5);//线条颜色
        CGContextMoveToPoint(context, 20, 20);
        CGContextAddLineToPoint(context, 200,20);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }];
    // NO.2写文字
    [DRAW_GRAPHIC_WITH_BLOCK(kMIDrawText, @"写文字") {
        UIGraphicsPushContext(context);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetRGBFillColor (context, 0.5, 1.0, 0.5, 0.5);
        UIFont *font = [UIFont boldSystemFontOfSize:18.0];
        [@"公司：北京中软科技股份有限公司\n部门：ERP事业部\n姓名：McLiang" drawInRect:CGRectMake(20, 40, 280, 300) withFont:font];
        UIGraphicsPopContext();
    }];
    // NO.3画一个正方形图形 没有边框
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5);
        CGContextFillRect(context, CGRectMake(2, 2, 270, 270));
        CGContextStrokePath(context);
    }];
    // NO.4画正方形边框
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
        CGContextSetLineWidth(context, 2.0);
        CGContextAddRect(context, CGRectMake(2, 2, 270, 270));
        CGContextStrokePath(context);
    }];
    // NO.5画方形背景颜色
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context,320);
        CGContextSetRGBStrokeColor(context, 250.0/255, 250.0/255, 210.0/255, 0.7);
        CGContextStrokeRect(context, CGRectMake(0, 0, 320, 460));
        CGContextRestoreGState(context);
    }];
    // NO.6椭圆
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
        CGContextSetLineWidth(context, 3.0);
        CGRect aRect= CGRectMake(80, 80, 160, 100);
        CGContextAddEllipseInRect(context, aRect); //椭圆
        CGContextDrawPath(context, kCGPathStroke);
    }];
    
    // NO.7
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextBeginPath(context);
        CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddArcToPoint(context, 50, 100, 50, 150, 50);
        CGContextStrokePath(context);
    }];
    // NO.8渐变
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextClip(context);
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGFloat colors[] =
        {
            204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
            29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
            0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
        };
        CGGradientRef gradient = CGGradientCreateWithColorComponents
        (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
        CGColorSpaceRelease(rgb);
        CGContextDrawLinearGradient(context, gradient,CGPointMake(0.0, 0.0),
                                    CGPointMake(0.0, self.view.frame.size.height),
                                    kCGGradientDrawsBeforeStartLocation);
    }];
    // NO.9四条线画一个正方形
    //画线
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
        UIColor *aColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0];
        CGContextSetFillColorWithColor(context, aColor.CGColor);
        CGContextSetLineWidth(context, 4.0);
        CGPoint aPoints[5];
        aPoints[0] = CGPointMake(60, 60);
        aPoints[1] = CGPointMake(260, 60);
        aPoints[2] = CGPointMake(260, 300);
        aPoints[3] = CGPointMake(60, 300);
        aPoints[4] = CGPointMake(60, 60);
        CGContextAddLines(context, aPoints, 5);
        CGContextDrawPath(context, kCGPathStroke); // 开始画线
    }];
    // NO.10
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        UIColor *aColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0];
        CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
        CGContextSetFillColorWithColor(context, aColor.CGColor);
        //椭圆
        CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
        CGContextSetLineWidth(context, 3.0);
        CGContextSetFillColorWithColor(context, aColor.CGColor);
        
        CGRect aRect= CGRectMake(80, 80, 160, 100);
        CGContextAddRect(context, aRect); //矩形
        CGContextAddEllipseInRect(context, aRect); //椭圆
        CGContextDrawPath(context, kCGPathStroke);
    }];
    
    // NO.11 画一个实心的圆
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextFillEllipseInRect(context, CGRectMake(95, 95, 100.0, 100));
    }];
    
    // NO.12 画一个菱形
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 150, 150);
        CGContextAddLineToPoint(context, 100, 200);
        CGContextAddLineToPoint(context, 50, 150);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextStrokePath(context);
    }];
    // NO.13 画矩形
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect rectangle = CGRectMake(60,170,200,80);
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
    }];
    // 椭圆
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect rectangle = CGRectMake(60,170,200,80);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
    }];
    
    // 用红色填充了一段路径:
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 150, 150);
        CGContextAddLineToPoint(context, 100, 200);
        CGContextAddLineToPoint(context, 50, 150);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillPath(context);
    }];
    // 填充一个蓝色边的红色矩形
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect rectangle = CGRectMake(60,170,200,80);
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillRect(context, rectangle);
    }];
    
    // 画弧
    //弧线的是通过指定两个切点，还有角度，调用CGContextAddArcToPoint()绘制
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddArcToPoint(context, 100,200, 300,200, 100);
        CGContextStrokePath(context);
    }];
    // 绘制贝兹曲线
    // 贝兹曲线是通过移动一个起始点，然后通过两个控制点,还有一个中止点，调用CGContextAddCurveToPoint() 函数绘制
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 10, 10);
        CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
        CGContextStrokePath(context);
    }];
    // 绘制二次贝兹曲线
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 10, 200);
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
        CGContextStrokePath(context);
    }];
    // 绘制虚线
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        CGContextSetLineWidth(context, 5.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGFloat dashArray[] = {2,6,4,2};
        CGContextSetLineDash(context, 3, dashArray, 4);//跳过3个再画虚线，所以刚开始有6-（3-2）=5个虚点
        CGContextMoveToPoint(context, 10, 200);
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
        CGContextStrokePath(context);
    }];
    //绘制图片
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        NSString* imagePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage* myImageObj = [[UIImage alloc] initWithContentsOfFile:imagePath];
        //[myImageObj drawAtPoint:CGPointMake(0, 0)];
        [myImageObj drawInRect:CGRectMake(0, 0, 320, 480)];
        NSString *s = @"我的小狗";
        [s drawAtPoint:CGPointMake(100, 0) withFont:[UIFont systemFontOfSize:34.0]];
    }];
    
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        CGImageRef image = img.CGImage;
        CGContextSaveGState(context);
        CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
        CGContextDrawImage(context, touchRect, image);
        CGContextRestoreGState(context);
    }];
    
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        CGImageRef image = img.CGImage;
        
        CGContextSaveGState(context);
        
        CGContextRotateCTM(context, M_PI);
        CGContextTranslateCTM(context, -img.size.width, -img.size.height);
        
        CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
        CGContextDrawImage(context, touchRect, image);
        CGContextRestoreGState(context);
    }];
    
    [DRAW_GRAPHIC_WITH_BLOCK(-1, @"正方形") {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        CGImageRef image = img.CGImage;
        
        CGContextSaveGState(context);
        
        CGAffineTransform myAffine = CGAffineTransformMakeRotation(M_PI);
        myAffine = CGAffineTransformTranslate(myAffine, -img.size.width, -img.size.height);
        CGContextConcatCTM(context, myAffine);
        
        CGContextRotateCTM(context, M_PI);
        CGContextTranslateCTM(context, -img.size.width, -img.size.height);
        
        CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
        CGContextDrawImage(context, touchRect, image);
        CGContextRestoreGState(context);
    }];

    // init button for dispatch message
    [self registerAllButtonsWithClick];
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

- (void)onClick:(UIButton *)sender
{
    DataInfo *dataInfo = dataDictionary[@(sender.tag)];
    dataInfo.enable = YES;
    
    [self drawMyGraphic];
}

- (void)registerAllButtonsWithClick
{
    NSArray *dataArray = [dataDictionary allValues];
    NSInteger index = 0;
    for(UIButton *btn in _baseView.subviews) {
        if(index<dataArray.count) {
            DataInfo *dataInfo = dataArray[index++];
            btn.tag = dataInfo.index;
            [btn setTitle:dataInfo.name forState:UIControlStateNormal];
        } else {
            btn.tag = 9999;
        }
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)registerId:(MethodIndex)index
              name:(NSString *)name
      forDrawBlock:(void(^)(CGContextRef context))block
{
    if(block) {
        DataInfo *dataInfo = [DataInfo new];
        dataInfo.index = index;
        dataInfo.name = name;
        dataInfo.block = block;
        
        [dataDictionary setObject:dataInfo forKey:@(index)];
    }
}

- (void)drawMyGraphic
{
    CGFloat CGContexWith = self.imageView.bounds.size.width;
    CGFloat CGContexHeight = self.imageView.bounds.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 CGContexWith*2,
                                                 CGContexHeight*2,
                                                 8,
                                                 4*CGContexWith*2,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(context, 0, CGContexHeight*2);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // filter array and excute block for draw graphic
    [dataDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        DataInfo *dataInfo = obj;
        if(dataInfo.enable && dataInfo.block) {
            dataInfo.block(context);
        }
    }];
    
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    self.imageView.image = [UIImage imageWithCGImage:imageRef];
}

@end
