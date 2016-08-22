//
//  DrawGraphicController.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "DrawGraphicController.h"

@interface DrawGraphicController ()
{
    NSMutableArray *pointArray;
    NSInteger index;
}
@end

@implementation DrawGraphicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    pointArray = [NSMutableArray arrayWithCapacity:10];
    self.view.layer.shouldRasterize = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //UIImage *image = [self drawMyGraphic];
    //[self updateUIWithImage:image];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if(pointArray.count<3) {
        [pointArray addObject:NSStringFromCGPoint(point)];
    }
    else {
        CGPathRef path = [self pathFromPoint:point];
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
        for(NSInteger i=0; i<pointArray.count; i++) {
            NSString *str = pointArray[i];
            if(CGPathContainsPoint(path, &transform, CGPointFromString(str), true)) {
                index = i;
                break;
            }
        }
    }
    
    UIImage *image = [self drawGraphic];
    [self updateUIWithImage:image];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if(index>=0) {
        [pointArray removeObjectAtIndex:index];
        [pointArray insertObject:NSStringFromCGPoint(point) atIndex:index];
        UIImage *image = [self drawGraphic];
        [self updateUIWithImage:image];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    index = -1;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (CGPathRef)pathFromPoint:(CGPoint)point
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    CGPathAddArc(path, &transform, point.x, point.y, 20, 0, 2*M_PI, true);
    return path;
}

- (UIImage *)drawGraphic
{
    CGFloat CGContexWith = self.view.bounds.size.width;
    CGFloat CGContexHeight = self.view.bounds.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 CGContexWith,
                                                 CGContexHeight,
                                                 8,
                                                 4*CGContexWith*2,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    CGContextTranslateCTM(context, 0, CGContexHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetRGBStrokeColor(context, 1, 0, 1, 1);
    CGContextSetLineWidth(context, 2);
    
    CGPoint point = CGPointZero;
    for(NSString *str in pointArray) {
        point = CGPointFromString(str);
        CGPathRef path = [self pathFromPoint:point];
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathStroke);
        
        CGPathRelease(path);
        CGContextAddArc(context, point.x, point.y, 2, 0, 2*M_PI, 1);
    }
    
    // 二次曲线函数
    
    if(pointArray.count==2) {
        CGPoint point1 = CGPointFromString(pointArray[0]);
        CGPoint point2 = CGPointFromString(pointArray[1]);
        CGPoint point3 = CGPointMake((point1.x+point2.x)/2, (point1.y+point2.y)/2);
        
        CGContextSetRGBStrokeColor(context, 0, 1, 1, 1);
        CGContextMoveToPoint(context, point1.x, point1.y);//设置Path的起点
        CGContextAddQuadCurveToPoint(context, point3.x, point3.y, point2.x, point2.y);//设置贝塞尔曲线的控制点坐标和终点坐标
        CGContextStrokePath(context);
    } else if(pointArray.count>2) {
        CGPoint point1 = CGPointFromString(pointArray[0]);
        CGPoint point2 = CGPointFromString(pointArray[1]);
        CGPoint point3 = CGPointFromString(pointArray[2]);
        
        CGContextSetRGBStrokeColor(context, 0, 1, 1, 1);
        CGContextMoveToPoint(context, point1.x, point1.y);//设置Path的起点
        CGContextAddQuadCurveToPoint(context, point3.x, point3.y, point2.x, point2.y);//设置贝塞尔曲线的控制点坐标和终点坐标
        CGContextStrokePath(context);
    }
    // 三次曲线函数
    // 设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    //CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}
















- (UIImage *)drawMyGraphic
{
    CGFloat CGContexWith = self.view.bounds.size.width;
    CGFloat CGContexHeight = self.view.bounds.size.height;
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
    
    //UIGraphicsPushContext(context);
    //UIGraphicsPopContext();
    // NO.1画一条线
    if(1) {
        CGContextSaveGState(context);
        CGContextSetRGBStrokeColor(context, 1.0, 0.5, 0.5, 0.5);//线条颜色
        CGContextMoveToPoint(context, 20, 20);
        CGContextAddLineToPoint(context, 200,20);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
    // NO.2写文字
    if(1) {
        UIGraphicsPushContext(context);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetRGBFillColor (context, 0.5, 1.0, 0.5, 0.5);
        UIFont *font = [UIFont boldSystemFontOfSize:18.0];
        [@"公司：北京中软科技股份有限公司\n部门：ERP事业部\n姓名：McLiang" drawInRect:CGRectMake(20, 40, 280, 300) withFont:font];
        UIGraphicsPopContext();
    }
    // NO.3画一个正方形图形 没有边框
    if(0) {
        CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5);
        CGContextFillRect(context, CGRectMake(2, 2, 270, 270));
        CGContextStrokePath(context);
    }
    // NO.4画正方形边框
    if(0) {
        CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
        CGContextSetLineWidth(context, 2.0);
        CGContextAddRect(context, CGRectMake(2, 2, 270, 270));
        CGContextStrokePath(context);
    }
    // NO.5画方形背景颜色
    if(1) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context,320);
        CGContextSetRGBStrokeColor(context, 250.0/255, 250.0/255, 210.0/255, 0.7);
        CGContextStrokeRect(context, CGRectMake(0, 0, 320, 460));
        CGContextRestoreGState(context);
    }
    // NO.6椭圆
    if(0) {
        CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
        CGContextSetLineWidth(context, 3.0);
        CGRect aRect= CGRectMake(80, 80, 160, 100);
        CGContextAddEllipseInRect(context, aRect); //椭圆
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // NO.7
    if(0) {
        CGContextBeginPath(context);
        CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddArcToPoint(context, 50, 100, 50, 150, 50);
        CGContextStrokePath(context);
    }
    // NO.8渐变
    if(0) {
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
    }
    // NO.9四条线画一个正方形
    //画线
    if(1) {
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
    }
    // NO.10
    if(0) {
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
    }
    
    // NO.11 画一个实心的圆
    if(0) {
        CGContextFillEllipseInRect(context, CGRectMake(95, 95, 100.0, 100));
    }
    
    // NO.12 画一个菱形
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 150, 150);
        CGContextAddLineToPoint(context, 100, 200);
        CGContextAddLineToPoint(context, 50, 150);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextStrokePath(context);
    }
    // NO.13 画矩形
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect rectangle = CGRectMake(60,170,200,80);
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
    }
    // 椭圆
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect rectangle = CGRectMake(60,170,200,80);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
    }
    
    // 用红色填充了一段路径:
    if(0) {
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 150, 150);
        CGContextAddLineToPoint(context, 100, 200);
        CGContextAddLineToPoint(context, 50, 150);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillPath(context);
    }
    // 填充一个蓝色边的红色矩形
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect rectangle = CGRectMake(60,170,200,80);
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillRect(context, rectangle);
    }
    
    // 画弧
    //弧线的是通过指定两个切点，还有角度，调用CGContextAddArcToPoint()绘制
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddArcToPoint(context, 100,200, 300,200, 100);
        CGContextStrokePath(context);
    }
    // 绘制贝兹曲线
    // 贝兹曲线是通过移动一个起始点，然后通过两个控制点,还有一个中止点，调用CGContextAddCurveToPoint() 函数绘制
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 10, 10);
        CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
        CGContextStrokePath(context);
    }
    // 绘制二次贝兹曲线
    if(0) {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 10, 200);
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
        CGContextStrokePath(context);
    }
    // 绘制虚线
    if(0) {
        CGContextSetLineWidth(context, 5.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGFloat dashArray[] = {2,6,4,2};
        CGContextSetLineDash(context, 3, dashArray, 4);//跳过3个再画虚线，所以刚开始有6-（3-2）=5个虚点
        CGContextMoveToPoint(context, 10, 200);
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
        CGContextStrokePath(context);
    }
    //绘制图片
    if(0) {
        NSString* imagePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage* myImageObj = [[UIImage alloc] initWithContentsOfFile:imagePath];
        //[myImageObj drawAtPoint:CGPointMake(0, 0)];
        [myImageObj drawInRect:CGRectMake(0, 0, 320, 480)];
        NSString *s = @"我的小狗";
        [s drawAtPoint:CGPointMake(100, 0) withFont:[UIFont systemFontOfSize:34.0]];
    }
    
    if(0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        CGImageRef image = img.CGImage;
        CGContextSaveGState(context);
        CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
        CGContextDrawImage(context, touchRect, image);
        CGContextRestoreGState(context);
    }
    
    if(0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        CGImageRef image = img.CGImage;
        
        CGContextSaveGState(context);
        
        CGContextRotateCTM(context, M_PI);
        CGContextTranslateCTM(context, -img.size.width, -img.size.height);
        
        CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
        CGContextDrawImage(context, touchRect, image);
        CGContextRestoreGState(context);
    }
    
    if(0) {
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
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    return [UIImage imageWithCGImage:imageRef];
}

- (void)updateUIWithImage:(UIImage *)image
{
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
}

@end
