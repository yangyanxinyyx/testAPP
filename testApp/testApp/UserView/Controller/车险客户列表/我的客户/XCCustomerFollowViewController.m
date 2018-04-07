//
//  XCCustomerFollowViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerFollowViewController.h"

@interface XCCustomerFollowViewController ()<XCDistributionFooterViewDelegate>

@end

@implementation XCCustomerFollowViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
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
    
}
#pragma mark - Action Method

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
    XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
    if (indexPath.row == self.dataArrM.count - 1) {
        cell.shouldShowSeparator = NO;
    }
    [cell setTitle:title];
    
    return cell;
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
