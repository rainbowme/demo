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

#define kCommonTableViewCell    @"IDCommonTableViewCell"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    // NSLog(@"%@", PT(456789));

    dataArray = ExportedMethodsByModule();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
