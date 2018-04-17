//
//  XCUserRepairViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserRepairViewController.h"
#import "XCUserRepairDetailViewController.h"
#import "XCCarTransactionModel.h"

@interface XCUserRepairViewController ()<XCCheckoutTableViewCellDelegate>

@end

@implementation XCUserRepairViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self)weakSelf = self;
    self.pageIndex = 1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //车务客户列表
        NSDictionary *param = @{
                                @"type":@"维修",
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        weakSelf.pageIndex = 1;
        [RequestAPI getelectCarTransactionList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    [self.dataArr removeAllObjects];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCarTransactionModel *baseModel = [XCCarTransactionModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [self.dataArr addObject:baseModel];
                        }
                    }
                    [weakSelf.tableView reloadData];
                    NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                    weakSelf.pageCount = [pageCountNum intValue];
                    
                }
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
            [weakSelf.tableView.mj_header endRefreshing];
        } fail:^(id error) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        //车务客户列表
        weakSelf.pageIndex ++;
        NSDictionary *param = @{
                                @"type":@"维修",
                                @"PageIndex":[NSNumber numberWithInt:weakSelf.pageIndex ],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        if (weakSelf.pageIndex <= weakSelf.pageCount) {
            [RequestAPI getelectCarTransactionList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"]) {
                    if (response[@"data"][@"dataSet"]) {
                        NSArray *origionDataArr = response[@"data"][@"dataSet"];
                        for (NSDictionary *dataInfo in origionDataArr) {
                            XCCarTransactionModel *baseModel = [XCCarTransactionModel yy_modelWithJSON:dataInfo];
                            if (baseModel) {
                                [self.dataArr addObject:baseModel];
                            }
                        }
                        [weakSelf.tableView reloadData];
                        NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                        weakSelf.pageCount = [pageCountNum intValue];
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

- (void)clickCheckDetailButtonWithCell:(XCCheckoutTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    XCCarTransactionModel *model = self.dataArr[indexPath.row];
    __weak typeof (self)weakSelf = self;
    
    //车务客户列表
    NSDictionary *param = @{
                            @"id":model.carTransID,
                            };
    [RequestAPI getCarTransaction:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        BOOL configureSucess  = NO;
        if (response[@"data"]) {
            XCCarTransactioDetailModel *detailModel = [XCCarTransactioDetailModel yy_modelWithJSON:response[@"data"]];
       XCUserRepairDetailViewController *repairDetail = [[XCUserRepairDetailViewController alloc] initWithTitle:@"维修详情"];
            repairDetail.carTranDetailModel = detailModel;
            [self.navigationController pushViewController:repairDetail animated:YES];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            configureSucess = YES;
        }
        if (!configureSucess) {
            [weakSelf requestFailureHandler];
        }
    } fail:^(id error) {
        [weakSelf requestFailureHandler];
    }];
}
#pragma mark - privary Method
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"撤销成功" complete:nil];
    [self.view addSubview:tipsView];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    [cell setTimeTitleStr:@"创建时间"];
    cell.delegate = self;
    XCCarTransactionModel*carTranModel = self.dataArr[indexPath.row];
    [cell setupCellWithCarTransactionListModel:carTranModel];
//    cell.carNumber = @"粤AAAAAA";
//    cell.userName = @"梁艺钟";
//    cell.issureTime = @"a123213-321-321-3";
    
    return cell;
}

#pragma mark - XCCheckoutTableViewCellDelegate

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    [self clickCheckDetailButtonWithCell:cell];
}
@end
