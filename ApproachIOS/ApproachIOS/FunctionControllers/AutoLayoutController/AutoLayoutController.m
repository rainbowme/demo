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
    //__weak IBOutlet UIButton *btn;
}
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

// 去掉SB的autolayout Checkingbox
@implementation AutoLayoutController
@synthesize btn;

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
    
    //
    __weak __typeof(&*self)weakSelf = self;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 1000));
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (IBAction)onClick:(id)sender
{
    __weak __typeof(&*self)weakSelf = self;
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.equalTo(weakSelf.view);
    }];
}

@end
