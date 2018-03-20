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
    navVC.tabBarItem.title = @"首页";
    navVC.tabBarItem.selectedImage = [UIImage imageNamed:@"coverMain_nomnal.png"];
    navVC.tabBarItem.image = [UIImage imageNamed:@"coverMain_select.png"];
    [navVC setNavigationBarHidden:YES];

    PriceViewController *price = [[PriceViewController alloc] init ];
    UINavigationController *navPrice = [[UINavigationController alloc] initWithRootViewController:price];
    navPrice.tabBarItem.title = @"报价";
    navPrice.tabBarItem.selectedImage = [UIImage imageNamed:@"price_select.png"];
    navPrice.tabBarItem.image = [UIImage imageNamed:@"price_nomnal.png"];
    [navPrice setNavigationBarHidden:YES];

    GetCarViewController *getCar = [[GetCarViewController alloc] init ];
    UINavigationController *navGetCar = [[UINavigationController alloc] initWithRootViewController:getCar];
    navGetCar.tabBarItem.title = @"接车";
    navGetCar.tabBarItem.image = [UIImage imageNamed:@"getCar_nomnal.png"];
    navGetCar.tabBarItem.selectedImage = [UIImage imageNamed:@"getCar_select.png"];
    [navGetCar setNavigationBarHidden:YES];

    UserViewController *user = [[UserViewController alloc] init ];
    UINavigationController *navUser = [[UINavigationController alloc ] initWithRootViewController:user];
    navUser.tabBarItem.title = @"我的";
    navUser.tabBarItem.image = [UIImage imageNamed:@"user_nomnal.png"];
    navUser.tabBarItem.selectedImage = [UIImage imageNamed:@"user_select.png"];
    [navUser setNavigationBarHidden:YES];

    self.tabBar.tintColor = COLOR_RGB_255(0, 77, 162);

    self.viewControllers = [NSArray arrayWithObjects:navVC,navPrice,navGetCar,navUser, nil];
    self.tabBar.translucent = NO;

    [[UINavigationBar appearance] setTranslucent:YES];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:90/255.0 green:192/255.0 blue:249/255.0 alpha:1]];


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
