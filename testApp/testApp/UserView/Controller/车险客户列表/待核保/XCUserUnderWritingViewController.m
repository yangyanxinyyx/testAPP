//
//  XCUserUnderWritingViewController.m
//  testApp
//
//  Created by Melody on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserUnderWritingViewController.h"
#import "XCUserUnderWritingDetailViewController.h"
#import "XCCheckoutDetailBaseModel.h"
@interface XCUserUnderWritingViewController ()<XCCheckoutTableViewCellDelegate>

@end

@implementation XCUserUnderWritingViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Action Method

#pragma mark - privary Method

//    LYZAlertView *alertView = [LYZAlertView alterViewWithTitle:@"是否删除" content:nil comfirmStr:@"是" cancelStr:@"否" comfirmClick:^(LYZAlertView *alertView) {
//        [self.dataArr removeObjectAtIndex:indexpath.row];
//
//        //(TODO)删除数据
//        [weakSelf removeAlertView:alertView cellIndexpath:indexpath];
//        [self.tableView reloadData];
//           } cancelClick:^(LYZAlertView *alertView) {
//        [weakSelf removeAlertView:alertView cellIndexpath:indexpath];
//    }];
//
//    [self.view addSubview:alertView];

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
    
    return cell;
}

#pragma mark - XCCheckoutTableViewCellDelegate

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    XCCheckoutDetailBaseModel *baseModel = self.dataArr[indexPath.row];
    
    XCUserUnderWritingDetailViewController *detailVC = [[XCUserUnderWritingDetailViewController alloc] initWithTitle:@"核保详情"];
    detailVC.model = baseModel;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end
