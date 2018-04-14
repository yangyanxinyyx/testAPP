//
//  XCUserWaitingToWriteListViewController.m
//  testApp
//
//  Created by Melody on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserWaitingToWriteListViewController.h"
#import "XCUserWaitingToWriteListDetailViewController.h"
#import "XCCheckoutDetailBaseModel.h"

@interface XCUserWaitingToWriteListViewController ()<XCCheckoutTableViewCellDelegate>

@end

@implementation XCUserWaitingToWriteListViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Action Method

#pragma mark - privary Method

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    XCCheckoutDetailBaseModel *baseModel = self.dataArr[indexPath.row];
    cell.baseModel = baseModel;
//    cell.carNumber = @"粤AAAAAA";
//    cell.userName = @"梁艺钟";
//    cell.issureTime = @"a123213-321-321-3";
//
    return cell;
}

#pragma mark - XCCheckoutTableViewCellDelegate

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XCCheckoutDetailBaseModel *baseModel = self.dataArr[indexPath.row];
    XCUserWaitingToWriteListDetailViewController *detailVC = [[XCUserWaitingToWriteListDetailViewController alloc] initWithTitle:@"已缴费待打单详情"];
    detailVC.model = baseModel;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end
