//
//  BaseViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        BaseViewController *VC = (BaseViewController *)[self.navigationController.viewControllers lastObject];
        VC.tabBarController.tabBar.hidden = YES;

    }else{
        BaseViewController *VC = (BaseViewController *)[self.navigationController.viewControllers lastObject];
        VC.tabBarController.tabBar.hidden = NO;
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

@end
