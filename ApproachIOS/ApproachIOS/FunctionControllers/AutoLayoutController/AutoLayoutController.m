//
//  AutoLayoutController.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/23.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "AutoLayoutController.h"
#import "Masonry.h"

@interface AutoLayoutController ()
{
    IBOutlet __weak UIButton *btn;
}
@end

@implementation AutoLayoutController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AutoLayoutController" bundle:nil];
    AutoLayoutController *vc = [sb instantiateViewControllerWithIdentifier:@"IDAutoLayoutController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
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
