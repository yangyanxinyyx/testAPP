//
//  XCCustomerDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerDetailViewController.h"
#import "XCCustomerRepairViewController.h"
#import "XCCustomerAnnualReviewViewController.h"
#import "XCCustomerViolationPreviewViewController.h"
#import "XCCustomerFollowViewController.h"
#import "XCUserViolationDetailModel.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "PriceUnderwritingImportTableViewCell.h"
#define kimportTableCellID @"importTableCellID"
@interface XCCustomerDetailViewController ()
@property (nonatomic, strong) UIButton  * customerFollowUpBtn ;
@property (nonatomic, strong) UIButton * subscribeBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * bottomLine ;

/** <# 注释 #> */
@property (nonatomic, strong) AMapLocationManager * locationManager ;

/** 用户定位 */
@property (nonatomic, strong) CLLocation *location ;
@end

@implementation XCCustomerDetailViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[PriceUnderwritingImportTableViewCell class] forCellReuseIdentifier:kimportTableCellID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    self.locationManager.locationTimeout = 3;
    
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        NSLog(@"location:%@", location);
        self.location = location;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"kehuxiangqing" object:nil];

}

- (void)InfoNotificationAction:(NSNotification *)notification{
    
    NSLog(@"%@",notification.userInfo);
    NSLog(@"---接收到通知---");
    if (self.model) {
        NSDictionary *param = @{
                                @"carId":self.model.carId,
                                @"customerId":self.model.customerId
                                };
        __weak typeof (self)weakSelf = self;
        [RequestAPI getCustomerParticularsList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                XCCustomerDetailModel *detailModel = [XCCustomerDetailModel yy_modelWithJSON:response[@"data"]];
                detailModel.customerId = weakSelf.model.customerId;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.model = detailModel;
                    [weakSelf.tableView reloadData];
                });
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            }
        } fail:^(id error) {
            [weakSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
        }];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGFloat bottomHeight = 120 * ViewRateBaseOnIP6;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom + bottomHeight))];
    [_bottomLine setFrame:CGRectMake(0, SCREEN_HEIGHT - bottomHeight - 1 - safeAreaBottom, SCREEN_WIDTH, 1)];
    
    [_customerFollowUpBtn setFrame:CGRectMake(55 * ViewRateBaseOnIP6,CGRectGetMaxY(_bottomLine.frame) + (SCREEN_HEIGHT - CGRectGetMaxY(_bottomLine.frame)  - 80 * ViewRateBaseOnIP6) * 0.5 , 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6)];
    [_subscribeBtn setFrame:CGRectMake(CGRectGetMaxX(_customerFollowUpBtn.frame) + 40 * ViewRateBaseOnIP6, _customerFollowUpBtn.frame.origin.y, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method

- (void)clickCustomerFollowUpBtn:(UIButton *)button
{
    
    __block NSMutableArray * selectArrM = [[NSMutableArray alloc] init];
    __weak __typeof(self) weakSelf = self;
    NSDictionary *param = @{
                            @"dictCode":@"three_case_type",
                            };
    [RequestAPI getSelectLinesByDictCode:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (isUsable(response[@"data"], [NSArray class])) {
            selectArrM = response[@"data"];
            XCCustomerFollowViewController *followVC = [[XCCustomerFollowViewController alloc] initWithTitle:@"客户跟进"];
            followVC.customerID = self.model.customerId;
            followVC.customerName = self.model.customerName;
            followVC.selectArr = selectArrM;
            [strongSelf.navigationController pushViewController:followVC animated:YES];
        }else {
            [strongSelf showAlterInfoWithNetWork:@"提交失败" complete:nil];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
    }];
    
}

- (void)clickSubscribeBtn:(UIButton *)button
{
    NSArray *dataArr = @[@"维修预约",@"年审预约",@"违章预约"];
    __weak typeof (self)weakSelf = self;
    LYZSelectView *alterView = [LYZSelectView alterViewWithArray:dataArr confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
        if ([selectStr isEqualToString:@"维修预约"]) {
            if (self.location) {
                XCCustomerRepairViewController *repairVC = [[XCCustomerRepairViewController alloc] initWithTitle:@"维修预约"];
                repairVC.location = self.location;
                repairVC.model = self.model;
                [self.navigationController pushViewController:repairVC animated:YES];
            }
        }else if([selectStr isEqualToString:@"年审预约"]) {
            
            NSDictionary *param = @{
                                    @"carId":_model.carId,
                                    };
            [RequestAPI getCarVerificationMoney:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"]) {
                    NSArray *origionDataArr = response[@"data"];
                        if (origionDataArr) {
                            XCCustomerAnnualReviewViewController *annualReviewVC = [[XCCustomerAnnualReviewViewController alloc] initWithTitle:@"年审预约"];
                            annualReviewVC.dataArr = origionDataArr;
                            annualReviewVC.model = weakSelf.model;
                            [weakSelf.navigationController pushViewController:annualReviewVC animated:YES];
                        }
                }else {
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"预约失败" complete:nil];
                    [weakSelf.view addSubview:tipsView];
                }
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            } fail:^(id error) {
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网路错误" complete:nil];
                [weakSelf.view addSubview:tipsView];
            }];
         
        }else if([selectStr isEqualToString:@"违章预约"]) {
            NSDictionary *param = @{
                                    @"carId":weakSelf.model.carId,
                                    };
            [RequestAPI getWZMessageByCarId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                                if (response[@"data"][@"lists"]) {
                    NSArray *dataArr = response[@"data"][@"lists"];
                    NSMutableArray *detailModelArrM = [[NSMutableArray alloc] init];
                    for (NSDictionary *dataInfo in dataArr) {
                        XCUserViolationDetailModel *model = [XCUserViolationDetailModel yy_modelWithJSON:dataInfo];
                        model.customerId = weakSelf.model.customerId;
                        model.customerName = weakSelf.model.customerName;
                        model.phone = weakSelf.model.phoneNo;
                        model.contacts = weakSelf.model.customerName;
                        model.carId = weakSelf.model.carId;
                        model.plateNo = weakSelf.model.plateNo;
                        model.remark = weakSelf.model.remark;
                        model.type = @"违章";
                        [detailModelArrM addObject:model];
                    }
                     XCCustomerViolationPreviewViewController *violationVC = [[XCCustomerViolationPreviewViewController alloc] initWithTitle:@"违章预约"];
                    violationVC.dataArrM = detailModelArrM;
                    violationVC.model = weakSelf.model;
                    [weakSelf.navigationController pushViewController:violationVC animated:YES];
                }else{
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"预约失败" complete:nil];
                    [weakSelf.view addSubview:tipsView];
                }
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            } fail:^(id error) {
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
                [weakSelf.view addSubview:tipsView];
            }];
            
        }
        
    }];
    [self.view addSubview:alterView];
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"客户名称:",@"客户来源:",@"性别:",
                                                            @"生日:",@"区域:",@"地址:",
                                                            @"身份证:",@"车牌号:",@"品牌型号:",
                                                            @"初登日期:",@"车架号:",@"发动机号:",@"联系方式:",@"跟进类型:",@"跟进时间:",@"备注:"]];
}

- (void)initUI
{
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    [_bottomLine setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:_bottomLine];
    _customerFollowUpBtn = [UIButton buttonWithType:0];
    [_customerFollowUpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_customerFollowUpBtn.titleLabel setFont:[UIFont systemFontOfSize:32 * ViewRateBaseOnIP6]];
    [_customerFollowUpBtn setTitle:@"客户跟进" forState:UIControlStateNormal];
    _customerFollowUpBtn.layer.cornerRadius = 3;
    _customerFollowUpBtn.layer.borderWidth = 1;
//    [_customerFollowUpBtn.layer setBorderColor:[UIColor grayColor].CGColor];
//    [_customerFollowUpBtn setBackgroundColor:[UIColor whiteColor]];
    [_customerFollowUpBtn addTarget:self action:@selector(clickCustomerFollowUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_customerFollowUpBtn setEnabled:NO];
    
    _subscribeBtn = [UIButton buttonWithType:0];
    [_subscribeBtn setTitleColor:COLOR_RGB_255(255, 255, 255) forState:UIControlStateNormal];
    [_subscribeBtn.titleLabel setFont:[UIFont systemFontOfSize:32 * ViewRateBaseOnIP6]];
    _subscribeBtn.layer.cornerRadius = 3;
    _subscribeBtn.layer.borderWidth = 1;
    _subscribeBtn.layer.borderColor = COLOR_RGB_255(104, 153, 232).CGColor;
    [_subscribeBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
    [_subscribeBtn setTitle:@"车务预约" forState:UIControlStateNormal];
    [_subscribeBtn addTarget:self action:@selector(clickSubscribeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_customerFollowUpBtn];
    [self.view addSubview:_subscribeBtn];
    
}
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:nil];
    [self.view addSubview:tipsView];
}

#pragma mark - Setter&Getter
- (void)setShouldClickFllowerBtn:(BOOL)shouldClickFllowerBtn
{
    _shouldClickFllowerBtn = shouldClickFllowerBtn;
    if (shouldClickFllowerBtn) {
        [_customerFollowUpBtn setTitleColor:COLOR_RGB_255(255, 255, 255) forState:UIControlStateNormal];
        _customerFollowUpBtn.layer.borderColor = COLOR_RGB_255(104, 153, 232).CGColor;
        [_customerFollowUpBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
        [_customerFollowUpBtn setEnabled:YES];
    }else {
        [_customerFollowUpBtn setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
        [_customerFollowUpBtn.layer setBorderColor:COLOR_RGB_255(1, 77, 163).CGColor];
        [_customerFollowUpBtn setBackgroundColor:[UIColor whiteColor]];
        [_customerFollowUpBtn setEnabled:NO];

    }
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];
    if (indexPath.row == self.dataArrM.count - 1) {
        PriceUnderwritingImportTableViewCell *cell = (PriceUnderwritingImportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kimportTableCellID forIndexPath:indexPath];
        if (isUsableNSString(self.model.content, @"")) {
            cell.textView.text = self.model.content;
        }else {
            cell.textView.text = @"";
        }
        cell.textView.editable = NO;
        return cell;
    }else {
        XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [cell setTitle:title];
        [cell setupCellWithCustomerDetailModel:self.model];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArrM.count - 1) {
        return 233 * ViewRateBaseOnIP6;
    }
    return (30 + 25 ) * ViewRateBaseOnIP6;
}

@end
