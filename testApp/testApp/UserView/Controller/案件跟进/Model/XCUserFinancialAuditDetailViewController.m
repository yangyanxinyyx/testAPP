//
//  XCUserFinancialAuditDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/4/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserFinancialAuditDetailViewController.h"
#import "XCUserCaseDetailTextCell.h"
#import "XCUserCaseDetailProgressCell.h"
#define kDetailTextCellID @"DetailTextCellID"
#define kDetailProgressCellID @"DetailProgressCellID"
@interface XCUserFinancialAuditDetailViewController ()

@end

@implementation XCUserFinancialAuditDetailViewController
#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseDetailProgressCell class] forCellReuseIdentifier:kDetailProgressCellID];
    [self.tableView registerClass:[XCUserCaseDetailTextCell class] forCellReuseIdentifier:kDetailTextCellID];
    
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    [self hideNullDataView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation )];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configureData
{
    
    
    
}

- (void)initUI
{
    
}


#pragma mark - Setter&Getter

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //进度状态Cell
        XCUserCaseDetailProgressCell *processCell =  (XCUserCaseDetailProgressCell *)[tableView dequeueReusableCellWithIdentifier:kDetailProgressCellID forIndexPath:indexPath];
        if (isUsableNSString(_detailModel.financeRemark, @"出纳审核通过")) {
            [processCell setIsFinish:YES];
        }else {
            [processCell setIsFinish:NO];
        }
        if (isUsableNSString(_detailModel.financeRemark, @"")) {
            [processCell setProcessStr:_detailModel.financeRemark];
        }else {
            [processCell setProcessStr:@"无"];
        }
        return processCell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //基本信息Cell
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kDetailTextCellID forIndexPath:indexPath];
        [detailTextCell setTitleStr:@"基本信息"];
        [detailTextCell setupFinaAudiaCellWithDetailBaseModel:_detailModel];
        
        return detailTextCell;
    } else {
        //保单信息Cell
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kDetailTextCellID forIndexPath:indexPath];
        [detailTextCell setTitleStr:@"保单信息"];
        [detailTextCell setupCommonDFBillCellWithDetailBaseModel:_detailModel];
        return detailTextCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger num = 0;
    if (indexPath.row == 0 ) {
        return [XCUserCaseDetailProgressCell getCellHeight];
    }else if (indexPath.row == 1) {
        num = 24;
    }
    else {
        num = 5;
    }
    return  (20 + 88 + 30 + 24) * ViewRateBaseOnIP6 + (num - 1) * ((24+24) * ViewRateBaseOnIP6) + 30 * ViewRateBaseOnIP6;

}
@end
