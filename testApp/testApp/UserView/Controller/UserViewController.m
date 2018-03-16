//
//  UserViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserViewController.h"
#import "XCUserTopView.h"
@interface UserViewController ()

@property (nonatomic, strong) XCUserTopView * topView;
@property (nonatomic, strong) UITableView * userTableView ;

@end

@implementation UserViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"个人中心";
//    [self.navigationItem setTitle:@"个人中心"];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI
- (void)setUI {
    [self.navigationController setNavigationBarHidden:YES];
    self.topView = [[XCUserTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 155 + 44)]; // 要适配IPhoneX
    self.topView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.topView];
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
