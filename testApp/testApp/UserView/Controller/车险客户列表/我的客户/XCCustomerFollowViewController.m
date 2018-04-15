//
//  XCCustomerFollowViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerFollowViewController.h"
#import "SelectTimeView.h"
#import "PriceUnderwritingImportTableViewCell.h"
#define kimportTableCellID @"importTableCellID"
@interface XCCustomerFollowViewController ()<XCDistributionFooterViewDelegate>
@property (nonatomic, strong) SelectTimeView * SelectTimeV ;

@end

@implementation XCCustomerFollowViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self.tableView registerClass:[PriceUnderwritingImportTableViewCell class] forCellReuseIdentifier:kimportTableCellID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}

#pragma mark - Init Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"操作类型",@"下次跟进时间",@"跟进内容"]];
}
- (void)initUI
{
    __weak typeof (self)weakSelf = self;
    _SelectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _SelectTimeV.hidden = YES;
    self.SelectTimeV.block = ^(NSString *string ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        XCDistributionPicketCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        [cell setTitleValue:string];
//        weakSelf.billModel.shipmentTime = string;
    };
}
#pragma mark - Action Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof (self)weakSelf = self;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([NSStringFromClass([cell class]) isEqualToString:NSStringFromClass([XCDistributionPicketCell class])]) {
        if ((indexPath.section == 0 && indexPath.row == 0)) {
            NSArray * arr = @[@"无责事故案件",@"代垫付案件",@"人伤案件",@"特俗案件",@"其他案件"];
            LYZSelectView *alterView = [LYZSelectView alterViewWithArray:arr confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
//                weakSelf.billModel.packageGiveOrBuy = selectStr;
                [(XCDistributionPicketCell *)cell setTitleValue:selectStr];
            }];
            [weakSelf.view addSubview:alterView];
        }
        else if ((indexPath.section == 0 && indexPath.row == 1)) {
            [self.SelectTimeV inputSelectTiemView:YES];
        }
       
    }
}
#pragma mark - Delegates & Notifications
#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    FinishTipsView *alterView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:^{
        
    }];
    [self.view addSubview:alterView];
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        PriceUnderwritingImportTableViewCell *cell = (PriceUnderwritingImportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kimportTableCellID forIndexPath:indexPath];
        return cell;
    }else {
        XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
        if (indexPath.row == self.dataArrM.count - 1) {
            cell.shouldShowSeparator = NO;
        }
        [cell setTitle:title];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"提交"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 233 * ViewRateBaseOnIP6;
    }
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerViewHeigth;
    footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
    return footerViewHeigth;
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter


@end
