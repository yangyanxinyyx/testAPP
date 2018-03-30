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
#import "PriceCustomerInformEntryViewController.h"
#import "PriceUnderwritingViewController.h"
#import "PriceAdjustViewController.h"
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
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(220, 144, 150, 50);
    [button3 setTitle:@"客户信息录入" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(touchButtonFunction3) forControlEvents:UIControlEventTouchDown];
    button3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(20, 244, 100, 50);
    [button4 setTitle:@"调整核保" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(touchButtonFunction4) forControlEvents:UIControlEventTouchDown];
    button4.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(220, 244, 150, 50);
    [button5 setTitle:@"调整报价" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(touchButtonFunction5) forControlEvents:UIControlEventTouchDown];
    button5.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button5];
    

    
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

- (void)touchButtonFunction3{
    PriceCustomerInformEntryViewController *pinfoVC = [[PriceCustomerInformEntryViewController alloc]init];
    [self.navigationController pushViewController:pinfoVC animated:YES];
}

- (void)touchButtonFunction4{
    PriceUnderwritingViewController *pinfoVC = [[PriceUnderwritingViewController alloc]init];
    [self.navigationController pushViewController:pinfoVC animated:YES];
}

- (void)touchButtonFunction5{
    PriceAdjustViewController *vc = [[PriceAdjustViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
