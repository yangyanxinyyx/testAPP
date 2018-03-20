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
#import "CoverPerformanceView.h"


@interface CoverMainViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation CoverMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    [self.navigationController setNavigationBarHidden:YES];
    [self getLoginUserInfo];

    [self createUI];

}

- (void)createUI
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [ self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(375, 898-20);
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;

    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190 * kScaleHeight)];
    [_scrollView addSubview:topImageView];
    topImageView.backgroundColor = [UIColor redColor];
    topImageView.image = [UIImage imageNamed:@""];

    CoverPerformanceView *carView = [[CoverPerformanceView alloc] initWithTitle:@"个人车险业绩" UserData:@[@"3213",@"31223",@"3123",@"3",@"2",@"1"]];
    carView.frame = CGRectMake(0, 190 * kScaleHeight, SCREEN_WIDTH, 280);
    [_scrollView addSubview:carView];

    CoverPerformanceView *repairView = [[CoverPerformanceView alloc] initWithTitle:@"个人维修业绩" UserData:@[@"3213",@"31223",@"3123",@"3",@"2",@"1"]];
    repairView.frame = CGRectMake(0, 190 * kScaleHeight + 280, SCREEN_WIDTH, 280);
    [_scrollView addSubview:repairView];

    UIButton *medalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(repairView.frame) + 15, SCREEN_WIDTH, 44)];
    medalBtn.backgroundColor = [UIColor whiteColor];
    [medalBtn addTarget:self action:@selector(pressMedalBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:medalBtn];

    UILabel *medalLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 15, 60, 14)];
    medalLabel.text = @"我的勋章";
    medalLabel.textColor = COLOR_RGB_255(68, 68, 68);
    medalLabel.backgroundColor = [UIColor clearColor];
    medalLabel.font = [UIFont systemFontOfSize:13];
    [medalBtn addSubview:medalLabel];

    UIImage *image = [UIImage imageNamed:@"next.png"];
    UIImageView *medalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - image.size.width, (44 - image.size.height)/2, image.size.width, image.size.height)];
    medalImageView.image = image;
    [medalBtn addSubview:medalImageView];
    

}

- (void)getLoginUserInfo
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:NO completion:nil];
}

- (void)pressMedalBtn
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
