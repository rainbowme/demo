//
//  OffscreenRenderController.m
//  FunctionModules
//
//  Created by Aurora on 16/8/22.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "OffscreenRenderController.h"

@interface OffscreenRenderController ()

@end

@implementation OffscreenRenderController
//1234567
- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"OffscreenRenderController" bundle:nil];
    OffscreenRenderController *vc = [sb instantiateViewControllerWithIdentifier:@"IDOffscreenRenderController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"IDMyCell"];
    for(NSInteger i = 0; i<20; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = [UIImage imageNamed:@"add_optional"];
                [cell addSubview:imageView];
            });
        });
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDMyCell"];
    for(UIView *view in cell.contentView.subviews) {
        if([view isKindOfClass:[UIImageView class]]) {
            view.layer.cornerRadius = 15;
            view.clipsToBounds = YES;
            view.layer.borderWidth = 2;
            view.layer.borderColor = [UIColor greenColor].CGColor;
        }
    }
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = 2.0f;
    if(cell) {
        
    }
    
    return cell;
}

@end
