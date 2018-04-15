//
//  XCShopServiceAddServiceViewController.m
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceAddServiceViewController.h"
#import "XCShopDetailSeclectCell.h"
#define kDetailSelectID @"DetailSelectID"
@interface XCShopServiceAddServiceViewController ()<XCDistributionFooterViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation XCShopServiceAddServiceViewController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureData];
    [self createUI];
}

#pragma mark - Init Method
- (void)configureData
{

}

- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCShopDetailSeclectCell class] forCellReuseIdentifier:kDetailSelectID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCShopDetailSeclectCell *cell = (XCShopDetailSeclectCell *)[tableView dequeueReusableCellWithIdentifier:kDetailSelectID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88 * ViewRateBaseOnIP6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCShopDetailSeclectCell *cell = (XCShopDetailSeclectCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setTitle:@"外表洗车"];
    cell.selected = !cell.selected;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"提交审核"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  20 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (60 + 88 + 60) * ViewRateBaseOnIP6;
}

#pragma  mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    NSLog(@"点击确认提交");
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:nil];
    [self.view addSubview:tipsView];
    
}
#pragma mark - Privacy Method

#pragma mark - Setter&Getter
@end
