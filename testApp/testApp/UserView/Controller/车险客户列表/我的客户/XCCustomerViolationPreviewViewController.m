//
//  XCCustomerViolationPreviewViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerViolationPreviewViewController.h"
#import "XCUserViolationDetailHeaderView.h"
#import "XCUserViolationDetailClickCell.h"
#define kheaderViewID @"headerViewID"
#define kClickCellID @"clickCellID"
@interface XCCustomerViolationPreviewViewController ()<XCUserViolationDetailClickCellDelegate>

@end

@implementation XCCustomerViolationPreviewViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserViolationDetailClickCell class] forCellReuseIdentifier:kClickCellID];
    [self.tableView registerClass:[XCUserViolationDetailHeaderView class] forHeaderFooterViewReuseIdentifier:kheaderViewID];
    [self initUI];
    [self configureData];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
#pragma mark - Init Method

- (void)configureData
{
}
- (void)initUI
{
    
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - Delegates & Notifications
- (void)XCUserViolationDetailClickCellClickButton:(UIButton *)button
{
    //预约
    button.selected = YES;
    button.userInteractionEnabled = NO ;
    [button setTitle:@"处理中" forState:UIControlStateSelected];
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCUserViolationDetailModel *model =  self.dataArrM[indexPath.row];
    XCUserViolationDetailClickCell *clickCell = [tableView dequeueReusableCellWithIdentifier:kClickCellID];
    clickCell.delegate = self;
    clickCell.detailModel = model;
    
    return clickCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XCUserViolationDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kheaderViewID];
    [headerView setGroupName:@"违章记录:"];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XCUserViolationDetailClickCell getCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [XCUserViolationDetailHeaderView getHeaderViewHeight];
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
