//
//  Module2ObjController.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/19.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "Module2ObjController.h"
#import "NSObject+AutoMagicCoding.h"

#define CELL_INFO_MODULE_BEGIN(module, base) \
@protocol module <NSObject> \
@end \
@interface module : base


#define CELL_INFO_MODULE_END(module) \
@end \
@implementation module \
@end



CELL_INFO_MODULE_BEGIN(ModuleInfoCell, NSObject)
@property (strong, nonatomic) NSString *hello;
@property (strong, nonatomic) NSString *baby;
CELL_INFO_MODULE_END(ModuleInfoCell)


@interface ModuleInfoDemo : NSObject
@property (strong, nonatomic) NSString *string;
@property (strong, nonatomic) NSArray<ModuleInfoCell> *array;
@property (strong, nonatomic) NSDictionary *dictionary;
@end
@implementation ModuleInfoDemo
+ (BOOL) AMCEnabled
{
    return YES;
}
@end





@interface Module2ObjController ()

@end

@implementation Module2ObjController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightTextColor];
    
    ModuleInfoCell *cell = [ModuleInfoCell new];
    cell.hello = @"23456786543";
    cell.baby = @"ghgfdsfrh";
    
    ModuleInfoDemo *demo = [ModuleInfoDemo new];
    demo.string = @"12345678";
    demo.array = @[cell, cell];
    demo.dictionary = @{@"key":@"value", @"key1":@"value1"};
    
    NSDictionary *dict = [demo dictionaryRepresentation];

    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    

    // Create new object from that dictionary.
    ModuleInfoDemo *newInstance = [ModuleInfoDemo objectWithDictionaryRepresentation:dict];
    
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
