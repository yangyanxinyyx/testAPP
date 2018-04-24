//
//  XCUserDistributionDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/4/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserDistributionDetailViewController.h"
#import "XCUserCaseDetailTextCell.h"
#import "XCUserCaseDetailProgressCell.h"
#define kDetailTextCellID @"DetailTextCellID"
#define kDetailProgressCellID @"DetailProgressCellID"
@interface XCUserDistributionDetailViewController ()

@end

@implementation XCUserDistributionDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseDetailProgressCell class] forCellReuseIdentifier:kDetailProgressCellID];
    [self.tableView registerClass:[XCUserCaseDetailTextCell class] forCellReuseIdentifier:kDetailTextCellID];
    
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
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
        [processCell setProcessStr:_detailModel.policyStatus];
        [processCell setIsFinish:NO];
        return processCell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //基本信息Cell
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kDetailTextCellID forIndexPath:indexPath];
        [detailTextCell setTitleStr:@"基本信息"];
        [detailTextCell setupDistributionCellWithDetailBaseModel:_detailModel];
        
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
        num = 20;
    }
    else {
        num = 5;
    }
    return  (20 + 88 + 30 + 24) * ViewRateBaseOnIP6 + (num - 1) * ((24+24) * ViewRateBaseOnIP6) + 30 * ViewRateBaseOnIP6;
}

@end
