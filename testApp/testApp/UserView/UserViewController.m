//
//  UserViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UITableView * userTableView ;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的";
    [self setUI];
}

- (void)setUI {
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 155)];
    self.topView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
