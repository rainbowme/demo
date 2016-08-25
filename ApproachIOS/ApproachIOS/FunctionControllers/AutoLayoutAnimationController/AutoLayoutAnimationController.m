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
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            NSLog(@"%@", [NSThread currentThread]);
            
            self.view.frame = CGRectMake(100, 100, 50, 50);
        }];
    });
}

@end
