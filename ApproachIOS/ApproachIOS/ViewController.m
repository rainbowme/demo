//
//  ViewController.m
//  HowbuyFund
//
//  Created by Aurora on 16/8/8.
//  Copyright © 2016年 howbuy.com. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import <mach-o/getsect.h>

static NSArray *ExportedMethodsByModule(void)
{
    NSMutableArray *array = [NSMutableArray array];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifdef __LP64__
        typedef uint64_t ExportValue;
        typedef struct section_64 ExportSection;
#define GetSectByNameFromHeader getsectbynamefromheader_64
#else
        typedef uint32_t ExportValue;
        typedef struct section ExportSection;
#define GetSectByNameFromHeader getsectbynamefromheader
#endif
        Dl_info info;
        dladdr(&ExportedMethodsByModule, &info);
        const ExportValue mach_header = (ExportValue)info.dli_fbase;
        const ExportSection *section = GetSectByNameFromHeader((void *)mach_header, "__DATA", "__class_export");
        
        if (section == NULL) {
            return;
        }
        
        for (ExportValue addr = section->offset;
             addr < (section->offset + section->size);
             addr += sizeof(const char **))
        {
            const char **entries = (const char **)(mach_header + addr); // Get data entry
            //NSLog(@"%s, %s", entries[0], entries[1]);
         
            [array addObject:[NSString stringWithFormat:@"%s", entries[0]]];
        }
    });
    
    return array;
}

@interface ViewController ()
{
    NSArray *dataArray;
}
@end

#include <objc/runtime.h>
#include <objc/message.h>
#define kCommonTableViewCell    @"IDCommonTableViewCell"
@implementation ViewController

static id invoke_method(id self, SEL _cmd, id newValue, id newValue2)
{
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };

    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue, newValue2);
    
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

static Class rich_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    // Do any additional setup after loading the view.
    // NSLog(@"%@", PT(456789));

    dataArray = ExportedMethodsByModule();
    
    // construct a class
    // 1
    Class aSuperClass = object_getClass(self);
    Class aClass = objc_allocateClassPair(aSuperClass, "UIRichViewController", 0);
    
    // 2
    SEL aSel = @selector(tableView:viewForFooterInSection:);
//    Method clazzMethod = class_getInstanceMethod(aSuperClass, aSel);
//    const char *types = method_getTypeEncoding(clazzMethod);
    const char *types = "@32@0:8@16q24";
    class_addMethod(aClass, aSel, (IMP)invoke_method, types);
    
    // 3
    // grab class method's signature so we can borrow it
    SEL aSel1 = @selector(class);
    Method clazzMethod1 = class_getInstanceMethod(aSuperClass, aSel1);
    const char *types1 = method_getTypeEncoding(clazzMethod1);
    class_addMethod(aClass, aSel1, (IMP)rich_class, types1);
    
    // 4
    objc_registerClassPair(aClass);
    // isa point to aClass
    object_setClass(self, aClass);
    
    
    //[self performSelector:aSel withObject:self.tableView withObject:@(0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommonTableViewCell];
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = dataArray[indexPath.row];
    Class aClass = NSClassFromString(className);
    
    id vc = [[aClass alloc] init];
    if([vc isKindOfClass:[UIViewController class]]) {
        [vc setValue:className forKeyPath:@"navigationItem.title"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
