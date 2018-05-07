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
#import "CoverWebViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CoverLoopimageModel.h"
#import <MJRefresh/MJRefresh.h>
#import "CoverAnnouncementModel.h"

@interface CoverMainViewController ()<UIScrollViewDelegate,CoverAnnouncementViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) CoverPerformanceView *nowMonthView;
@property (nonatomic,strong) CoverPerformanceView *lastMonthView;
@property (nonatomic,strong) CoverPerformanceView *yearView;
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT-49)];
    _scrollView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [ self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(0, 436 - 190 + 190 *kScaleHeight);
//    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;

    _scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];


    NSArray *array = [NSArray arrayWithObjects:[UIImage imageNamed:@"placeholder.png"],[UIImage imageNamed:@"placeholder.png"],[UIImage imageNamed:@"placeholder.png"], nil];

    self.imageScrollView = [[YXScrollView alloc] initWithImageArray:array imageClick:^(NSInteger index) {
        NSLog(@"点了图片%ld",index);
    }];
    self.imageScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190 * kScaleHeight);
    self.imageScrollView.time = 3;

    [_scrollView addSubview:_imageScrollView];



    _nowMonthView = [[CoverPerformanceView alloc] initWithTitle:@"本月数据统计" carAchie:@"0" carRank:@"0" repairAchie:@"0" repairRank:@"0"];
    _nowMonthView.frame = CGRectMake(0, 190 * kScaleHeight, SCREEN_WIDTH, 124);
    [_scrollView addSubview:_nowMonthView];

    _lastMonthView = [[CoverPerformanceView alloc] initWithTitle:@"上月数据统计" carAchie:@"0" carRank:@"0" repairAchie:@"0" repairRank:@"0"];
    _lastMonthView.frame = CGRectMake(0, 190 * kScaleHeight + 124, SCREEN_WIDTH, 124);
    [_scrollView addSubview:_lastMonthView];

    _yearView = [[CoverPerformanceView alloc] initWithTitle:@"年度数据统计" carAchie:@"0" carRank:@"0" repairAchie:@"0" repairRank:@"0"];
    _yearView.frame = CGRectMake(0, 190 * kScaleHeight + 124+124, SCREEN_WIDTH, 124);
    [_scrollView addSubview:_yearView];

    UIButton *medalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_yearView.frame) + 15, SCREEN_WIDTH, 44)];
    medalBtn.backgroundColor = [UIColor whiteColor];
    [medalBtn addTarget:self action:@selector(pressMedalBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:medalBtn];

    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(17, 10, 20, 20)];
    imageV.image = [UIImage imageNamed:@"我的勋章.jpg"];
    [medalBtn addSubview:imageV];

    UILabel *medalLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 60, 14)];
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

- (void)refresh
{
    //获取车险信息
    NSDictionary  *param = @{
                             @"salesman_id":[UserInfoManager shareInstance].userID
                             };
    [RequestAPI getPersonalPolicy:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        NSLog(@"%@",response);
        if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取车险信息成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                    [UserInfoManager shareInstance].performanceMedal.lastYearCar = data[@"last_year_car"] ? [NSString stringWithFormat:@"%@",data[@"last_year_car"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.lastMonthCar = data[@"last_month_car"] ? [NSString stringWithFormat:@"%@",data[@"last_month_car"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.nowMonthCar = data[@"now_month_car"] ? [NSString stringWithFormat:@"%@",data[@"now_month_car"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.lastYearCarRanking = data[@"last_year_car_ranking"] ? [NSString stringWithFormat:@"%@",data[@"last_year_car_ranking"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.lastMonthCarRanking = data[@"last_month_car_ranking"] ? [NSString stringWithFormat:@"%@",data[@"last_month_car_ranking"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.nowMonthCarRanking = data[@"now_month_car_ranking"] ? [NSString stringWithFormat:@"%@",data[@"now_month_car_ranking"]]:@"";

                    [UserInfoManager shareInstance].performanceMedal.lastYearInsurance = data[@"last_year_Insurance"] ? [NSString stringWithFormat:@"%@",data[@"last_year_Insurance"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.lastMonthInsurance = data[@"last_month_Insurance"] ? [NSString stringWithFormat:@"%@",data[@"last_month_Insurance"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.nowMonthInsurance = data[@"now_month_Insurance"] ? [NSString stringWithFormat:@"%@",data[@"now_month_Insurance"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.lastYearInsuranceRanking = data[@"last_year_Insurance_ranking"] ? [NSString stringWithFormat:@"%@",data[@"last_year_Insurance_ranking"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.lastMonthInsuranceRanking = data[@"last_month_Insurance_ranking"] ? [NSString stringWithFormat:@"%@",data[@"last_month_Insurance_ranking"]]:@"";
                    [UserInfoManager shareInstance].performanceMedal.nowMonthInsuranceRanking = data[@"now_month_Insurance_ranking"] ? [NSString stringWithFormat:@"%@",data[@"now_month_Insurance_ranking"]]:@"";

                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    [self loadCoverModel];

                }
            }else if (([response[@"result"] integerValue] == 0)){
                NSLog(@"获取车险信息失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取车险信息错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];

    [self.scrollView.mj_header endRefreshing];
}

- (void)loadCoverModel
{
    [[UserInfoManager shareInstance].coverMainModel.loopImageDatas removeAllObjects];
    [[UserInfoManager shareInstance].coverMainModel.announcementDatas removeAllObjects];
    //获取公告信息
    NSDictionary  *param = @{
                             @"PageSize":@(10),
                             @"PageIndex":@(1)
                             };
    [RequestAPI getCoverAnnouncement:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        NSLog(@"%@",response);
        if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取公告成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                    NSArray *dataSet = data[@"dataSet"];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    for (NSDictionary *dicData in dataSet) {
                        CoverAnnouncementModel *announcement = [[CoverAnnouncementModel alloc] init];
                        [announcement setValuesForKeysWithDictionary:dicData];
                        [[UserInfoManager shareInstance].coverMainModel.announcementDatas addObject:announcement];
                    }
                }

                //获取轮播图信息
                NSDictionary  *param = @{
                                         @"type":@"业务端首页轮播图"
                                         };
                [RequestAPI getCoverLoopImage:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                    NSLog(@"%@",response);
                    if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
                        if ([response[@"result"] integerValue] == 1) {
                            NSLog(@"获取轮播图成功");
                            if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
                                NSArray *dataSet =  response[@"data"];
                                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                                for (NSDictionary *dicData in dataSet) {
                                    CoverLoopimageModel *loopimage = [[CoverLoopimageModel alloc] init];
                                    [loopimage setValuesForKeysWithDictionary:dicData];
                                    [[UserInfoManager shareInstance].coverMainModel.loopImageDatas addObject:loopimage];
                                }
                            }
                            [self reloadData];

                        }else if (([response[@"result"] integerValue] == 0)){
                            NSLog(@"获取轮播图失败");
                            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取轮播图错误" complete:nil];
                            [self.view addSubview:tipsView];
                        }
                    }
                } fail:^(id error) {
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
                    [self.view addSubview:tipsView];
                }];


            }else if (([response[@"result"] integerValue] == 0)){
                NSLog(@"获取公告失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取公告错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];


}

- (void)reloadData
{
    [_nowMonthView removeFromSuperview];
    [_lastMonthView removeFromSuperview];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *muImageArray = [NSMutableArray array];
        for (CoverLoopimageModel *model in [UserInfoManager shareInstance].coverMainModel.loopImageDatas) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.url]];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [muImageArray addObject:image]; 
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [_imageScrollView removeFromSuperview];

            NSArray *imageArray = muImageArray;
            self.imageScrollView = [[YXScrollView alloc] initWithImageArray:imageArray imageClick:^(NSInteger index) {
                NSLog(@"点了图片%ld",index);
            }];
            self.imageScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190 * kScaleHeight);
            self.imageScrollView.time = 3;

            [_scrollView addSubview:_imageScrollView];

            self.announcementView = [[CoverAnnouncementView alloc] initWithFrame:CGRectMake(0, 190 * kScaleHeight - 40, SCREEN_WIDTH, 40)];
            _announcementView.delegate = self;
            [_scrollView addSubview:_announcementView];
        });
    });

    _nowMonthView = [[CoverPerformanceView alloc] initWithTitle:@"本月数据统计"
                     carAchie:[UserInfoManager shareInstance].performanceMedal.nowMonthCar carRank:[UserInfoManager shareInstance].performanceMedal.nowMonthCarRanking repairAchie:[UserInfoManager shareInstance].performanceMedal.nowMonthInsurance repairRank:[UserInfoManager shareInstance].performanceMedal.nowMonthInsuranceRanking];
    _nowMonthView.frame = CGRectMake(0, 190 * kScaleHeight, SCREEN_WIDTH, 124);
    [_scrollView addSubview:_nowMonthView];

    _lastMonthView = [[CoverPerformanceView alloc] initWithTitle:@"上月数据统计" carAchie:[UserInfoManager shareInstance].performanceMedal.lastMonthCar carRank:[UserInfoManager shareInstance].performanceMedal.lastMonthCarRanking repairAchie:[UserInfoManager shareInstance].performanceMedal.lastMonthInsurance repairRank:[UserInfoManager shareInstance].performanceMedal.lastMonthInsuranceRanking];
    _lastMonthView.frame = CGRectMake(0, 190 * kScaleHeight + 124, SCREEN_WIDTH, 124);
    [_scrollView addSubview:_lastMonthView];

    _yearView = [[CoverPerformanceView alloc] initWithTitle:@"年度数据统计" carAchie:[UserInfoManager shareInstance].performanceMedal.lastYearCar carRank:[UserInfoManager shareInstance].performanceMedal.lastYearCarRanking repairAchie:[UserInfoManager shareInstance].performanceMedal.lastYearInsurance repairRank:[UserInfoManager shareInstance].performanceMedal.lastYearInsuranceRanking];
    _yearView.frame = CGRectMake(0, 190 * kScaleHeight + 124+124, SCREEN_WIDTH, 124);
    [_scrollView addSubview:_yearView];
}

- (void)getLoginUserInfo
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"kUserAccout"] && [[NSUserDefaults standardUserDefaults] valueForKey:@"kUserPassword"]) {
        [loginVC loginWithUserDefault];
    }else{

        [self presentViewController:loginVC animated:NO completion:nil];
    }

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

                    [UserInfoManager shareInstance].userMedal.medal_type_year_one_bonus = data[@"medal_type_year_one_bonus"];
                    [UserInfoManager shareInstance].userMedal.medal_type_year_two_bonus = data[@"medal_type_year_two_bonus"];
                    [UserInfoManager shareInstance].userMedal.medal_type_year_three_bonus = data[@"medal_type_year_three_bonus"];
                    [UserInfoManager shareInstance].userMedal.medal_type_year_one_performance = data[@"medal_type_year_one_performance"];
                    [UserInfoManager shareInstance].userMedal.medal_type_year_two_performance = data[@"medal_type_year_two_performance"];
                    [UserInfoManager shareInstance].userMedal.medal_type_year_three_performance = data[@"medal_type_year_three_performance"];
                    [UserInfoManager shareInstance].userMedal.medal_type_month_one_bonus = data[@"medal_type_month_one_bonus"];
                    [UserInfoManager shareInstance].userMedal.medal_type_month_two_bonus = data[@"medal_type_month_two_bonus"];
                    [UserInfoManager shareInstance].userMedal.medal_type_month_three_bonus = data[@"medal_type_month_three_bonus"];
                    [UserInfoManager shareInstance].userMedal.medal_type_month_one_performance = data[@"medal_type_month_one_performance"];
                    [UserInfoManager shareInstance].userMedal.medal_type_month_two_performance = data[@"medal_type_month_two_performance"];
                    [UserInfoManager shareInstance].userMedal.medal_type_month_three_performance = data[@"medal_type_month_three_performance"];

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

- (void)pressToPushWebWithID:(NSNumber *)webId
{
    CoverWebViewController *webVC = [[CoverWebViewController alloc] init];
    webVC.webId = webId;
    [self.navigationController pushViewController:webVC animated:YES];
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
