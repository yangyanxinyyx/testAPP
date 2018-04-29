//
//  GetCarViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarViewController.h"
#import "GetCarView.h"
#import "GetCarDetailModel.h"


@interface GetCarViewController ()<BaseNavigationBarDelegate,GetCarViewDelegate>


@end

@implementation GetCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"接车";
    [self.view addSubview:topBar];

    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);

    [self requestData];


}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestData
{
    NSDictionary *param = @{@"id":_orderID};
    [RequestAPI getGetCarDetail:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取接车详情成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

                    __block GetCarDetailModel *model = [[GetCarDetailModel alloc] init];
                    [model setValuesForKeysWithDictionary:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self createUIWithModel:model];
                    });
                }
            }else{
                NSLog(@"获取接车详情失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取接车详情错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }

    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];
}

- (void)createUIWithModel:(GetCarDetailModel *)model;
{
    GetCarView *view = [[GetCarView alloc] initWithFrame:CGRectMake(0, 10 + kHeightForNavigation, SCREEN_WIDTH, _isFix ? 519 : 554) model:model isFix:_isFix];
    view.delegate = self;
    [self.view addSubview:view];

    UIButton *getCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view.frame), SCREEN_WIDTH - 30, 44)];
    [getCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCarBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [getCarBtn addTarget:self action:@selector(pressGetCarBtn) forControlEvents:UIControlEventTouchUpInside];
    getCarBtn.layer.cornerRadius = 5;
    getCarBtn.layer.masksToBounds = YES;
    [getCarBtn setTitle:@"接车" forState:UIControlStateNormal];
    getCarBtn.backgroundColor = COLOR_RGB_255(0, 72, 162);
    [self.view addSubview:getCarBtn];

}

- (void)pressGetCarBtn
{
    NSDictionary *param = @{@"id":_orderID};
    [RequestAPI getGetCar:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"接车成功");
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

                dispatch_async(dispatch_get_main_queue(), ^{
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"接车信息已发出!" complete:^{

                        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadGetCarListWithPlateNO)]) {
                            [self.delegate reloadGetCarListWithPlateNO];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];

                    [self.view addSubview:tipsView];
                });
            }else{
                NSLog(@"接车失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"接车错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }

    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];

}

- (void)GetCarViewDidSelectImageIndex:(NSInteger)index
{

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
