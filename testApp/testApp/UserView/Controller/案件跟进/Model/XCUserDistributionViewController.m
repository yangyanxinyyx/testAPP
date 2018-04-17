//
//  XCUserDistributionViewController.m
//  testApp
//
//  Created by Melody on 2018/4/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserDistributionViewController.h"
#import "XCUserDistributionDetailViewController.h"
#import "XCFinanicalAuditListCell.h"
#import "XCCheckoutDetailBaseModel.h"
#define kFinaListCellID @"FinaListCellID"
@interface XCUserDistributionViewController ()

@end

@implementation XCUserDistributionViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCFinanicalAuditListCell class] forCellReuseIdentifier:kFinaListCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init Method

#pragma mark - Action Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCCheckoutDetailBaseModel *baseModel = nil;
    if (self.dataArr.count >= indexPath.row) {
        baseModel =  self.dataArr[indexPath.row];
    }
    XCUserDistributionDetailViewController *detailVC = [[XCUserDistributionDetailViewController alloc] initWithTitle:@"配送详情"];
    if (baseModel) {
        detailVC.detailModel = baseModel;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
#pragma mark - Delegates & Notifications


#pragma mark - Delegates & Notifications

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArr.count;
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    XCCheckoutDetailBaseModel *model =self.dataArr[indexPath.row];
    XCFinanicalAuditListCell *cell = (XCFinanicalAuditListCell *)[tableView dequeueReusableCellWithIdentifier:kFinaListCellID forIndexPath:indexPath];
    [cell setTimeTitleStr:@"创建时间"];
    //    [cell setupCellWithCaseListModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180 * ViewRateBaseOnIP6;
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
