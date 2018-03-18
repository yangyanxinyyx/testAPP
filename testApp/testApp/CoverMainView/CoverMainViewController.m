//
//  CoverMainViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "CoverMainViewController.h"
#import "MyMedalViewController.h"
#import "LoginViewController.h"

@interface CoverMainViewController ()

@end

@implementation CoverMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";

    [self getLoginUserInfo];


}

- (void)getLoginUserInfo
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MyMedalViewController *medal = [[MyMedalViewController alloc] init];
    [self.navigationController pushViewController:medal animated:YES];
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
