//
//  DrawGraphicController.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "DrawGraphicController.h"
#import "DrawGraphicController+RegisterDrawMethod.h"

@interface DataInfo : NSObject
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL enable;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) void(^block)(CGContextRef context);
@end
@implementation DataInfo
@end


@interface DrawGraphicController ()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@end

CLASS_EXPORTS(DrawGraphicController) ()
{
    NSMutableDictionary *dataDictionary;
    NSMutableDictionary *blockDictionary;
}
@end


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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // init draw method
    [self registerDrawMethod];
    
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
    CGSize size = self.imageView.frame.size;
    NSArray *dataArray = [dataDictionary allValues];
    NSInteger index = 0;
    
    CGFloat width = 80.0f;
    CGFloat height = 40.0f;
    NSInteger lineItemsCount = (size.width)/(width+10);
    CGFloat mod = size.width-(width+10)*lineItemsCount+10;
    
    CGFloat yOffset = 0.0f;
    for(DataInfo *dataInfo in dataArray) {
        CGFloat xOffset = mod/2+(width+10)*(index%lineItemsCount);
        yOffset = 10+(height+10)*(index/lineItemsCount);
        index++;
        
        CGRect frame = CGRectMake(xOffset, yOffset, width, height);
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.tag = dataInfo.index;
        [btn setTitle:dataInfo.name forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btn];
    }
    ((UIScrollView *)_baseView).contentSize = CGSizeMake(_baseView.frame.size.width, yOffset+height+10);
}

- (void)registerId:(MethodIndex)index
              name:(NSString *)name
      forDrawBlock:(void(^)(CGContextRef context))block
{
    if(block && index!=kMIDrawnUnknow) {
        DataInfo *dataInfo = [DataInfo new];
        dataInfo.index = index;
        dataInfo.name = name;
        dataInfo.block = block;
        
        [dataDictionary setObject:dataInfo forKey:@(index)];
    }
}

- (void)drawMyGraphic
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat CGContexWith = self.imageView.bounds.size.width*scale;
    CGFloat CGContexHeight = self.imageView.bounds.size.height*scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 CGContexWith,
                                                 CGContexHeight,
                                                 8,
                                                 4*CGContexWith,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(context, 0, CGContexHeight);
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
