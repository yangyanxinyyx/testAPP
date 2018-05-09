//
//  XCUserWaitingToPayingDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserWaitingToPayingDetailViewController.h"
#import "XCDistributionPolicyViewController.h"
#import "XCDistributionBillViewController.h"
#import "XCCheckoutDetailBaseModel.h"
#import "XCUserPackageModel.h"
#import "NSString+MoneyString.h"

@interface XCUserWaitingToPayingDetailViewController ()
@property (nonatomic, strong) UIButton  * distributionPolicyBtn ;
@property (nonatomic, strong) UIButton * distributionBillBtn ;
@end

@implementation XCUserWaitingToPayingDetailViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
//    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCCheckoutDetailInputCell class] forCellReuseIdentifier:kTextInputCellID];
    [self.tableView registerClass:[XCCheckoutDetailHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.bottomHeight = 140 * ViewRateBaseOnIP6;
    [_distributionPolicyBtn setFrame:CGRectMake(55 * ViewRateBaseOnIP6, CGRectGetMaxY(self.tableView.frame) + 40 * ViewRateBaseOnIP6 , 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6)];
    [_distributionBillBtn setFrame:CGRectMake(CGRectGetMaxX(_distributionPolicyBtn.frame) + 40 * ViewRateBaseOnIP6, _distributionPolicyBtn.frame.origin.y, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6)];

}

#pragma mark - Action Method

#pragma mark 点击配送保单
- (void)clickDistributionPolicyBtn:(UIButton *)button
{
    //加载礼包
    __weak __typeof(self) weakSelf = self;
    //车险客户列表
        NSDictionary *param = @{
                                @"ticketId":[UserInfoManager shareInstance].ticketID ,
                                };
      __block NSMutableArray *packArrM = [[NSMutableArray alloc] init];

        [RequestAPI getValidPackage:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                NSArray *dataArr = response[@"data"];
                for (NSDictionary *dataInfo in dataArr) {
                    XCUserPackageModel *packageModel = [XCUserPackageModel yy_modelWithJSON:dataInfo];
                    if (packageModel) {
                        [packArrM addObject:packageModel];
                    }
                }
            }

            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
        }];

    
    NSString *jqMoneyStr = @"¥0.00";
    NSString *syMoneyStr = @"¥0.00";

    if (isUsable(self.model.jqMoney, [NSNumber class]) && [self.model.jqMoney doubleValue]!= 0) {
        jqMoneyStr = [NSString stringWithMoneyNumber:[self.model.jqMoney doubleValue]];
    }
    if (isUsable(self.model.syMoney, [NSNumber class]) && [self.model.syMoney doubleValue]!= 0) {
        syMoneyStr = [NSString stringWithMoneyNumber:[self.model.syMoney doubleValue]];
    }
    XCDistributionPolicyViewController *policyVC = [[XCDistributionPolicyViewController alloc] initWithTitle:@"配送保单"];
    policyVC.jqMoney = jqMoneyStr;
    policyVC.syMoney = syMoneyStr;
    policyVC.packageArr = packArrM;
    policyVC.policyId = self.model.BillID;
    policyVC.model = self.model;
    [self.navigationController pushViewController:policyVC animated:YES];
}

#pragma mark 点击配送缴费单
- (void)clickDistributionBillBtn:(UIButton *)button
{
    //加载礼包
    //车险客户列表
    NSDictionary *param = @{
                            @"ticketId":[UserInfoManager shareInstance].ticketID ,
                            };
    __block NSMutableArray *packArrM = [[NSMutableArray alloc] init];
    
    [RequestAPI getValidPackage:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"]) {
            NSArray *dataArr = response[@"data"];
            for (NSDictionary *dataInfo in dataArr) {
                XCUserPackageModel *packageModel = [XCUserPackageModel yy_modelWithJSON:dataInfo];
                if (packageModel) {
                    [packArrM addObject:packageModel];
                }
            }
        }
        
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
    }];
    
    
    NSString *jqMoneyStr = @"¥0.00";
    NSString *syMoneyStr = @"¥0.00";
    if (isUsable(self.model.jqMoney, [NSNumber class]) && [self.model.jqMoney doubleValue]!= 0) {
        jqMoneyStr = [NSString stringWithMoneyNumber:[self.model.jqMoney doubleValue]];
    }
    if (isUsable(self.model.syMoney, [NSNumber class]) && [self.model.syMoney doubleValue]!= 0) {
        syMoneyStr = [NSString stringWithMoneyNumber:[self.model.syMoney doubleValue]];
    }

    XCDistributionBillViewController *billVC = [[XCDistributionBillViewController alloc] initWithTitle:@"配送缴费单"];
    billVC.jqMoney = jqMoneyStr;
    billVC.syMoney = syMoneyStr;
    billVC.packageArr = packArrM;
    billVC.policyId = self.model.BillID;
    billVC.model = self.model;
    [self.navigationController pushViewController:billVC animated:YES];
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configureData
{
    // 12 15 16 有输入
    NSArray *baseTitleNameArr = @[@"投保人:",@"身份证:",@"车牌号:",
                                  @"车架号:",@"初登日期:",@"发动机号:",
                                  @"品牌型号:",@"车型代码:",@"(商业)起保日期:",
                                  @"(交强)起保日期:",@"保险公司:",@"缴费通知单号:",
                                  @"交强险(业务员)金额:",@"商业险(业务员)金额:",@"交强险(出单员)金额:",
                                  @"商业险(出单员)金额:",@"出单员:",@"是否续保"];
    NSArray *policyTitleNameArr = @[@"交强险:",@"机动车损险:",@"第三责任险:",@"车上(司机)险:",@"车上(乘客)险:"];
    self.dataTitleArrM = [[NSMutableArray alloc] init];
    [self.dataTitleArrM addObject:baseTitleNameArr];
    [self.dataTitleArrM addObject:policyTitleNameArr];
}

- (void)initUI
{
    _distributionPolicyBtn = [UIButton buttonWithType:0];
    [_distributionPolicyBtn setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
    [_distributionPolicyBtn.titleLabel setFont:[UIFont systemFontOfSize:32 * ViewRateBaseOnIP6]];
    [_distributionPolicyBtn setTitle:@"配送保单" forState:UIControlStateNormal];
    _distributionPolicyBtn.layer.cornerRadius = 3;
    _distributionPolicyBtn.layer.borderWidth = 1;
    [_distributionPolicyBtn.layer setBorderColor: COLOR_RGB_255(104, 153, 232).CGColor];
    [_distributionPolicyBtn setBackgroundColor:[UIColor whiteColor]];
    [_distributionPolicyBtn addTarget:self action:@selector(clickDistributionPolicyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _distributionBillBtn = [UIButton buttonWithType:0];
    [_distributionBillBtn setTitleColor:COLOR_RGB_255(255, 255, 255) forState:UIControlStateNormal];
    [_distributionBillBtn.titleLabel setFont:[UIFont systemFontOfSize:32 * ViewRateBaseOnIP6]];
    _distributionBillBtn.layer.cornerRadius = 3;
    _distributionBillBtn.layer.borderWidth = 1;
    _distributionBillBtn.layer.borderColor = COLOR_RGB_255(104, 153, 232).CGColor;
    [_distributionBillBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
    [_distributionBillBtn setTitle:@"配送缴费单" forState:UIControlStateNormal];
    [_distributionBillBtn addTarget:self action:@selector(clickDistributionBillBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_distributionPolicyBtn];
    [self.view addSubview:_distributionBillBtn];

    
}

- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"撤销成功" complete:nil];
    [self.view addSubview:tipsView];
}

#pragma mark - Setter&Getter

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataTitleArrM.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArr = self.dataTitleArrM[section];
    
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *titleArr = self.dataTitleArrM[indexPath.section];
    NSString *title = titleArr[indexPath.row];

    if (indexPath.section == 0 && indexPath.row == 18 - 1){
            BOOL mark = NO;
            if ([self.model.isContinue isEqualToString:@"Y"])
            {
                mark = YES;
            }
            XCCheckoutDetailInputCell *inputCell = (XCCheckoutDetailInputCell *)[tableView dequeueReusableCellWithIdentifier:kTextInputCellID forIndexPath:indexPath];
            [inputCell setTitle:title];
            [inputCell setIsContinue:mark];
            inputCell.userInteractionEnabled = NO;
            
            return inputCell;
    }else {
        XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [cell setTitle:title];
        [cell setupCellWithDetailPolicyModel:self.model];
        return cell;
    }
}

@end
