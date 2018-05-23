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
#import "XCPhotoPreViewController.h"
#import "MoneyInputVIew.h"
#import "LYZAlertView.h"

@interface GetCarViewController ()<BaseNavigationBarDelegate,GetCarViewDelegate,MoneyInputVIewDelegate>


@end

@implementation GetCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"接车";
    if (self.getCarBtnType == GetCarBtnTypePay) {
        topBar.title = @"已接车";
    }else if (self.getCarBtnType == GetCarBtnTypeFinish){
        topBar.title = @"交易完成";
    }
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
                    model.appointmentTime = _appointmentTime;
                    model.receptionTime = _receptionTime;
                    model.finishTime = _finishTime;
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
    GetCarView *view = [[GetCarView alloc] initWithFrame:CGRectMake(0, 10 + kHeightForNavigation, SCREEN_WIDTH, _isFix ? 495 : 530) model:model isFix:_isFix orderCategory:_orderCategory getCarType:self.getCarBtnType];
    view.delegate = self;
    [self.view addSubview:view];

    UIButton *getCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view.frame) +10, SCREEN_WIDTH - 30, 44)];
    [getCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCarBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [getCarBtn addTarget:self action:@selector(pressGetCarBtn) forControlEvents:UIControlEventTouchUpInside];
    getCarBtn.layer.cornerRadius = 5;
    getCarBtn.layer.masksToBounds = YES;
    getCarBtn.backgroundColor = COLOR_RGB_255(0, 72, 162);
    [self.view addSubview:getCarBtn];

    if (self.getCarBtnType == GetCarBtnTypeGet) {
        [getCarBtn setTitle:@"接车" forState:UIControlStateNormal];

    }else if (self.getCarBtnType == GetCarBtnTypePay){
        [getCarBtn setTitle:@"完成" forState:UIControlStateNormal];

    }else{
        getCarBtn.hidden = YES;
    }
}

- (void)pressGetCarBtn
{
    if (self.getCarBtnType == GetCarBtnTypeGet) {

        LYZAlertView *alert = [LYZAlertView alterViewWithTitle:@"是否接车?" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
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
        }];
        [self.view addSubview:alert];
    }else{

            if ([self.orderCategory isEqualToString:@"维修"]) {
                MoneyInputVIew *moneyInput = [[MoneyInputVIew alloc] init];
                moneyInput.orderId = self.orderID;
                moneyInput.delegate = self;
                [self.view addSubview:moneyInput];
            }else{
                LYZAlertView *alert = [LYZAlertView alterViewWithTitle:@"是否完成?" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
                    NSDictionary *param = @{@"id":_orderID};
                    [RequestAPI getGetCarFinish:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                        if (isUsableDictionary(response)) {
                            if ([response[@"result"] integerValue] == 1) {
                                NSLog(@"交易成功");
                                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

                                dispatch_async(dispatch_get_main_queue(), ^{
                                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"交易完成!" complete:^{
                                        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadGetCarListWithPlateNO)]) {
                                            [self.delegate reloadGetCarListWithPlateNO];
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }
                                    }];

                                    [self.view addSubview:tipsView];

                                });

                            }else{
                                NSLog(@"交易失败");
                                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"交易错误" complete:nil];
                                [self.view addSubview:tipsView];
                            }
                        }

                    } fail:^(id error) {
                        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
                        [self.view addSubview:tipsView];
                    }];
                }];
                [self.view addSubview:alert];
            }
        }

}

- (void)GetCarViewDidSelectImageIndex:(NSInteger)index source:(NSMutableArray *)source
{
    XCPhotoPreViewController *vc = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览" sources:source];
    [vc updatePositionWithIndex:index];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reloadGetCarListWithPlateNO
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadGetCarListWithPlateNO)]) {
        [self.delegate reloadGetCarListWithPlateNO];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
