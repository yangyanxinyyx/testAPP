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
#import "YXScrollView.h"
#import "CoverAnnouncementView.h"

@interface CoverMainViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) CoverPerformanceView *carView;
@property (nonatomic,strong) CoverPerformanceView *repairView;
@property (nonatomic,strong) YXScrollView *imageScrollView;
@property (nonatomic,strong) CoverAnnouncementView *announcementView;

@end

@implementation CoverMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    [self.navigationController setNavigationBarHidden:YES];
    [self getLoginUserInfo];

    [self createUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"kReloadCoverMainViewData" object:nil];

}

- (void)createUI
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavMargan + STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - kNavMargan - STATUS_BAR_HEIGHT)];
    _scrollView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [ self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(0, 898-20);
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;


    NSArray *array = [NSArray arrayWithObjects:[UIImage imageNamed:@"汽车1.jpg"],[UIImage imageNamed:@"汽车2.jpg"],[UIImage imageNamed:@"汽车3.jpg"], nil];

    self.imageScrollView = [[YXScrollView alloc] initWithImageArray:array imageClick:^(NSInteger index) {
        NSLog(@"点了图片%ld",index);
    }];
    self.imageScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190 * kScaleHeight);
    self.imageScrollView.time = 3;
    //self.imageScrollView.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];

    [_scrollView addSubview:_imageScrollView];

    self.announcementView = [[CoverAnnouncementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [_scrollView addSubview:_announcementView];

    _carView = [[CoverPerformanceView alloc] initWithTitle:@"个人车险业绩" UserData:@[@"3213",@"31223",@"3123",@"3",@"2",@"1"]];
    _carView.frame = CGRectMake(0, 190 * kScaleHeight, SCREEN_WIDTH, 280);
    [_scrollView addSubview:_carView];

    _repairView = [[CoverPerformanceView alloc] initWithTitle:@"个人维修业绩" UserData:@[@"3213",@"31223",@"3123",@"3",@"2",@"1"]];
    _repairView.frame = CGRectMake(0, 190 * kScaleHeight + 280, SCREEN_WIDTH, 280);
    [_scrollView addSubview:_repairView];

    UIButton *medalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_repairView.frame) + 15, SCREEN_WIDTH, 44)];
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

- (void)reloadData
{
    [_carView removeFromSuperview];
    [_repairView removeFromSuperview];
    NSArray * array = @[
                        [UserInfoManager shareInstance].performanceMedal.lastYearCar,
                        [UserInfoManager shareInstance].performanceMedal.lastMonthCar,
                        [UserInfoManager shareInstance].performanceMedal.nowMonthCar,
                        [UserInfoManager shareInstance].performanceMedal.lastYearCarRanking,
                        [UserInfoManager shareInstance].performanceMedal.lastMonthCarRanking,
                        [UserInfoManager shareInstance].performanceMedal.nowMonthCarRanking,
                        ];

    _carView = [[CoverPerformanceView alloc] initWithTitle:@"个人车险业绩" UserData:array];
    _carView.frame = CGRectMake(0, 190 * kScaleHeight, SCREEN_WIDTH, 280);
    [_scrollView addSubview:_carView];

    _repairView = [[CoverPerformanceView alloc] initWithTitle:@"个人维修业绩" UserData:array];
    _repairView.frame = CGRectMake(0, 190 * kScaleHeight + 280, SCREEN_WIDTH, 280);
    [_scrollView addSubview:_repairView];
}

- (void)getLoginUserInfo
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:NO completion:nil];
}

- (void)pressMedalBtn
{
    NSDictionary *param = @{
                            @"salesman_id":[UserInfoManager shareInstance].userID,
                            };

    [RequestAPI getMyMedal:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取勋章成功");
                if (isUsableDictionary(response[@"data"])) {
                    NSDictionary *data = response[@"data"];
                    [UserInfoManager shareInstance].userMedal.yearFirst = data[@"medal_type_year_one"]?[NSString stringWithFormat:@"%@",data[@"medal_type_year_one"]]:@"";
                    [UserInfoManager shareInstance].userMedal.yearSecond = data[@"medal_type_year_two"]?[NSString stringWithFormat:@"%@",data[@"medal_type_year_two"]]:@"";
                    [UserInfoManager shareInstance].userMedal.yearThird = data[@"medal_type_year_three"]?[NSString stringWithFormat:@"%@",data[@"medal_type_year_three"]]:@"";
                    [UserInfoManager shareInstance].userMedal.presonFirst = data[@"medal_type_month_one"]?[NSString stringWithFormat:@"%@",data[@"medal_type_month_one"]]:@"";
                    [UserInfoManager shareInstance].userMedal.presonSecond = data[@"medal_type_month_two"]?[NSString stringWithFormat:@"%@",data[@"medal_type_month_two"]]:@"";
                    [UserInfoManager shareInstance].userMedal.presonThird = data[@"medal_type_month_three"]?[NSString stringWithFormat:@"%@",data[@"medal_type_month_three"]]:@"";
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    UserInfoManager *manager = [UserInfoManager shareInstance];
                    NSLog(@"");
                    
                    MyMedalViewController *medal = [[MyMedalViewController alloc] init];
                    [self.navigationController pushViewController:medal animated:YES];
                }
            }else{
                NSLog(@"获取勋章失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取勋章错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];


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
