//
//  BaseTabbarController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseTabbarController.h"

#import "CoverMainViewController.h"
#import "PriceViewController.h"
#import "GetCarViewController.h"
#import "UserViewController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    CoverMainViewController *cover = [[CoverMainViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:cover];
    cover.tabBarItem.title = @"首页";
    cover.tabBarItem.selectedImage = [UIImage imageNamed:@"首页"];
    cover.tabBarItem.image = [UIImage imageNamed:@"首页"];

    PriceViewController *price = [[PriceViewController alloc] init ];
    UINavigationController *navPrice = [[UINavigationController alloc] initWithRootViewController:price];
    price.tabBarItem.title = @"报价";
    price.tabBarItem.selectedImage = [UIImage imageNamed:@"报价"];
    price.tabBarItem.image = [UIImage imageNamed:@"报价"];

    GetCarViewController *getCar = [[GetCarViewController alloc] init ];
    UINavigationController *navGetCar = [[UINavigationController alloc] initWithRootViewController:getCar];
    getCar.tabBarItem.title = @"接车";
    getCar.tabBarItem.image = [UIImage imageNamed:@"接车"];
    getCar.tabBarItem.selectedImage = [UIImage imageNamed:@"接车"];

    UserViewController *user = [[UserViewController alloc] init ];
    UINavigationController *navUser = [[UINavigationController alloc ] initWithRootViewController:user];
    user.tabBarItem.title = @"我的";
    user.tabBarItem.image = [UIImage imageNamed:@"我的"];
    user.tabBarItem.selectedImage = [UIImage imageNamed:@"我的"];



    self.viewControllers = [NSArray arrayWithObjects:navVC,navPrice,navGetCar,navUser, nil];
    self.tabBar.translucent = NO;

    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:90/255.0 green:192/255.0 blue:249/255.0 alpha:1]];


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
