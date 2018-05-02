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
    __weak typeof (self)weakSelf = self;
    self.requestKey = @"待出单";

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSDictionary *param = @{
                                @"policyStatus":self.requestKey ,
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        weakSelf.pageIndex = 1;
        [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
        [RequestAPI getMyPolicyInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCheckoutDetailBaseModel *baseModel = [XCCheckoutDetailBaseModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [dataArrM addObject:baseModel];
                        }
                    }
                    weakSelf.dataArr = dataArrM;
                    [weakSelf.tableView reloadData];
                }
                NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                self.pageCount = [pageCountNum intValue];
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageIndex ++;
        NSDictionary *param = @{
                                @"policyStatus":self.requestKey ,
                                @"PageIndex":[NSNumber numberWithInt:weakSelf.pageIndex],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        if (weakSelf.pageIndex <= weakSelf.pageCount) {
            [RequestAPI getMyPolicyInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"]) {
                    if (response[@"data"][@"dataSet"]) {
                        NSArray *origionDataArr = response[@"data"][@"dataSet"];
                        for (NSDictionary *dataInfo in origionDataArr) {
                            XCCheckoutDetailBaseModel *baseModel = [XCCheckoutDetailBaseModel yy_modelWithJSON:dataInfo];
                            if (baseModel) {
                                [weakSelf.dataArr addObject:baseModel];
                            }
                        }
                        [weakSelf.tableView reloadData];
                        
                    }
                }
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                [weakSelf.tableView.mj_footer endRefreshing];
            } fail:^(id error) {
                weakSelf.pageIndex --;
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
        }else {
            weakSelf.pageIndex --;
            if (weakSelf.pageIndex == weakSelf.pageCount) {
                [weakSelf.tableView.mj_footer setState:MJRefreshStateNoMoreData];
            }else {
                [weakSelf.tableView.mj_footer endRefreshing];
            }
        }
    }];
}

#pragma mark - Action Method

#pragma mark - privary Method

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count > 0 ) {
        [self hideNullDataView];
    }else {
        [self showNullDataView];
    }
     return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setTimeTitleStr:@"创建时间"];
    cell.delegate = self;
    XCCheckoutDetailBaseModel *baseModel = self.dataArr[indexPath.row];
    if(baseModel) {
        cell.baseModel = baseModel;
    }

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
