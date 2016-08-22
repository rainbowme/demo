//
//  ApproachThreadController.m
//  DrawGraphic
//
//  Created by Aurora on 16/8/16.
//  Copyright © 2016年 howbuy. All rights reserved.
//

#import "ApproachThreadController.h"
#import "ApproachThreadController+OperationQueue.h"
#import "ApproachThreadController+GCD.h"

CLASS_EXPORTS(ApproachThreadController) ()

@end

@implementation ApproachThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];

    //[self operationQueue];
    //[self blockOperation];
    [self gcdDemo];
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
