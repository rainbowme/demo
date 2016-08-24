//
//  DrawBezierCurveController.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/24.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "DrawBezierCurveController.h"

CLASS_EXPORTS(DrawBezierCurveController) ()
{
    NSMutableArray *pointArray;
    NSInteger index;
}
@end

@implementation DrawBezierCurveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    pointArray = [NSMutableArray arrayWithCapacity:10];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)updateUIWithImage:(UIImage *)image
{
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
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
@end
