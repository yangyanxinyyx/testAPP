//
//  XCUserBePaymentCaseViewController.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBePaymentCaseViewController.h"
#import "XCUserBePaymentCaseDetailViewController.h"
#import "XCUserCaseListModel.h"
#import "XCUserCaseDetailModel.h"
#import <YYModel.h>
#define kcaseType @"代垫付案件"

@interface XCUserBePaymentCaseViewController ()

@end

@implementation XCUserBePaymentCaseViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseListCell class] forCellReuseIdentifier:kCaseListCellID];
    __weak typeof (self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSDictionary *param = @{
                                @"caseType":kcaseType,
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        weakSelf.pageIndex = 1;
        [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
        [RequestAPI getThreeCaseApplyList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCUserCaseListModel *caseModel = [XCUserCaseListModel yy_modelWithJSON:dataInfo];
                        if (caseModel) {
                            [dataArrM addObject:caseModel];
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
                                @"caseType":kcaseType,
                                @"PageIndex":[NSNumber numberWithInt:weakSelf.pageIndex],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        if (weakSelf.pageIndex <= weakSelf.pageCount) {
            [RequestAPI getThreeCaseApplyList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"]) {
                    if (response[@"data"][@"dataSet"]) {
                        NSArray *origionDataArr = response[@"data"][@"dataSet"];
                        for (NSDictionary *dataInfo in origionDataArr) {
                            XCUserCaseListModel *caseModel = [XCUserCaseListModel yy_modelWithJSON:dataInfo];
                            if (caseModel) {
                                [weakSelf.dataArr addObject:caseModel];
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

#pragma mark - Init Method

#pragma mark - Action Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XCUserCaseListModel *model = self.dataArr[indexPath.row];
    
    NSDictionary *param = @{
                            @"id":model.caseID,
                            };
    __weak typeof (self)weakSelf = self;
    [RequestAPI getThreeCaseApply:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        BOOL configureSucess  = NO;
        if (response[@"data"]) {
            NSDictionary *dataInfo = response[@"data"];
            if(isUsable(dataInfo, [NSDictionary class])) {
                XCUserCaseDetailModel *detailModel = [XCUserCaseDetailModel yy_modelWithJSON:dataInfo];
                XCUserBePaymentCaseDetailViewController *injuryCaseDetailVC = [[XCUserBePaymentCaseDetailViewController alloc] initWithTitle:self.navTitle];
                injuryCaseDetailVC.detailModel = detailModel;
                [self.navigationController pushViewController:injuryCaseDetailVC animated:YES];
                configureSucess = YES;
            }
        }
        if (!configureSucess) {
            [weakSelf requestFailureHandler];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        [weakSelf requestFailureHandler];
    }];
    
    
}

#pragma mark - Delegates & Notifications

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArr.count > 0 ) {
        [self hideNullDataView];
    }else {
        [self showNullDataView];
    }
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCUserCaseListModel *model =self.dataArr[indexPath.row];
    XCUserCaseListCell *cell = (XCUserCaseListCell *)[tableView dequeueReusableCellWithIdentifier:kCaseListCellID forIndexPath:indexPath];
    [cell setupCellWithCaseListModel:model caseTypeStr:self.navTitle];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XCUserCaseListCell getCaseListCellHeight];
}

#pragma mark - Privacy Method
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
#pragma mark - Setter&Getter

@end
