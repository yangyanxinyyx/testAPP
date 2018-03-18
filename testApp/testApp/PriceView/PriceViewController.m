//
//  PriceViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceViewController.h"
#import "PriceInfoViewController.h"
#import "PriceInspectViewController.h"
#import "PriceCarInsuranceQViewController.h"
@interface PriceViewController ()

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报价";

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 44, 100, 50);
    [button setTitle:@"报价详情" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchButtonFunction) forControlEvents:UIControlEventTouchDown];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(220, 44, 100, 50);
    [button1 setTitle:@"查看报价" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(touchButtonFunction1) forControlEvents:UIControlEventTouchDown];
    button1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(20, 144, 100, 50);
    [button2 setTitle:@"车险报价" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(touchButtonFunction2) forControlEvents:UIControlEventTouchDown];
    button2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button2];
    
}

- (void)touchButtonFunction{
    PriceInfoViewController *pinfoVC = [[PriceInfoViewController alloc]init];
    [self.navigationController pushViewController:pinfoVC animated:YES];
}

- (void)touchButtonFunction1{
    PriceInspectViewController *pinfoVC = [[PriceInspectViewController alloc]init];
    [self.navigationController pushViewController:pinfoVC animated:YES];
}

- (void)touchButtonFunction2{
    PriceCarInsuranceQViewController *pinfoVC = [[PriceCarInsuranceQViewController alloc]init];
    [self.navigationController pushViewController:pinfoVC animated:YES];
}
@end
