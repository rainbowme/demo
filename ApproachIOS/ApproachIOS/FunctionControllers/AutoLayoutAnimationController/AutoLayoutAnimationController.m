//
//  AutoLayoutAnimationController.m
//  ApproachIOS
//
//  Created by Aurora on 16/8/24.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "AutoLayoutAnimationController.h"

@interface AutoLayoutAnimationController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *dview;
//int ptrace(int request, int pid, int addr, int data);@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;
@end

@implementation AutoLayoutAnimationController

- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AutoLayoutAnimationController" bundle:nil];
    AutoLayoutAnimationController *vc = [sb instantiateViewControllerWithIdentifier:@"IDAutoLayoutAnimationController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dview.layer.borderWidth = 2.0f;
    self.dview.layer.borderColor = [UIColor greenColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:1.0f initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.dview.bounds = CGRectMake(0, 10, self.dview.bounds.size.width, self.dview.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

@end
