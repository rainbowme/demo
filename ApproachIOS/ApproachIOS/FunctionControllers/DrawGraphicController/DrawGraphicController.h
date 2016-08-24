//
//  DrawGraphicController.h
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MethodIndex) {
    kMIDrawnUnknow,
    kMIDrawLine,
    kMIDrawText,
    kMIDrawGradientSqure, // 渐变矩形
    kMIDrawGroupLineSqure, // 四线矩形
    kMIDrawRhomb, // 菱形
    
    kMIDrawStar, // 图片渲染星星
};

@interface DrawGraphicController : UIViewController

- (void)registerId:(MethodIndex)index
              name:(NSString *)name
      forDrawBlock:(void(^)(CGContextRef context))block;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
