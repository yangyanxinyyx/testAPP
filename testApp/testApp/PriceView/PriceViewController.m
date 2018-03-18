//
//  PriceViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceViewController.h"
#import "PriceInfoViewController.h"

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
    
}

- (void)touchButtonFunction{
    PriceInfoViewController *pinfoVC = [[PriceInfoViewController alloc]init];
    [self.navigationController pushViewController:pinfoVC animated:YES];
}


@end
