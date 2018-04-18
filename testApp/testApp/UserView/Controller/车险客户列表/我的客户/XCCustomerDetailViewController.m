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
#import <AMapLocationKit/AMapLocationKit.h>
@interface XCCustomerDetailViewController ()
@property (nonatomic, strong) UIButton  * customerFollowUpBtn ;
@property (nonatomic, strong) UIButton * subscribeBtn ;
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

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGFloat bottomHeight = 140 * ViewRateBaseOnIP6;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom + bottomHeight))];
    [_customerFollowUpBtn setFrame:CGRectMake(55 * ViewRateBaseOnIP6, CGRectGetMaxY(self.tableView.frame) + 40 * ViewRateBaseOnIP6 , 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6)];
    [_subscribeBtn setFrame:CGRectMake(CGRectGetMaxX(_customerFollowUpBtn.frame) + 40 * ViewRateBaseOnIP6, _customerFollowUpBtn.frame.origin.y, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method

- (void)clickCustomerFollowUpBtn:(UIButton *)button
{

    XCCustomerFollowViewController *followVC = [[XCCustomerFollowViewController alloc] initWithTitle:@"客户跟进"];
    followVC.customerID = self.model.customerId;
    followVC.customerName = self.model.customerName;
    [self.navigationController pushViewController:followVC animated:YES];
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
            XCCustomerAnnualReviewViewController *annualReviewVC = [[XCCustomerAnnualReviewViewController alloc] initWithTitle:@"年审预约"];
            [weakSelf.navigationController pushViewController:annualReviewVC animated:YES];
        }else if([selectStr isEqualToString:@"违章预约"]) {
            XCCustomerViolationPreviewViewController *violationVC = [[XCCustomerViolationPreviewViewController alloc] initWithTitle:@"违章预约"];
            [weakSelf.navigationController pushViewController:violationVC animated:YES];
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
                                                            @"身份证:",@"车牌号:",@"车品牌:",
                                                                 @"初登日期:",@"车架号:",@"发动机号:",
                                                                 @"车型代码:",@"联系方式:"]];
}

- (void)initUI
{
    _customerFollowUpBtn = [UIButton buttonWithType:0];
    [_customerFollowUpBtn setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
    [_customerFollowUpBtn.titleLabel setFont:[UIFont systemFontOfSize:32 * ViewRateBaseOnIP6]];
    [_customerFollowUpBtn setTitle:@"客户跟进" forState:UIControlStateNormal];
    _customerFollowUpBtn.layer.cornerRadius = 3;
    _customerFollowUpBtn.layer.borderWidth = 1;
    [_customerFollowUpBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_customerFollowUpBtn setBackgroundColor:[UIColor whiteColor]];
    [_customerFollowUpBtn addTarget:self action:@selector(clickCustomerFollowUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
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


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];
    XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
    [cell setTitle:title];
    [cell setupCellWithCustomerDetailModel:self.model];
//    [cell setTitlePlaceholder:@"刘某某"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (30 + 25) * ViewRateBaseOnIP6;
}

@end
