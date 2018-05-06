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
#import "UILabel+createLabel.h"
#import <MJRefresh.h>
@interface XCCustomerViolationPreviewViewController ()<XCUserViolationDetailClickCellDelegate>
/** <# 注释 #> */
@property (nonatomic, assign) int  pageIndex;
//下拉刷新获取总页数
@property (nonatomic, assign) int pageCount ;

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
#warning 委托办理成功后，后台没有及时更新UI，故不加刷新
//    __weak typeof (self)weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        NSDictionary *param = @{
//                                @"carId":weakSelf.model.carId,
//                                };
//        weakSelf.pageIndex = 1;
//        [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
//        [RequestAPI getWZMessageByCarId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
//            if (response[@"data"][@"lists"]) {
//                NSArray *dataArr = response[@"data"][@"lists"];
//                NSMutableArray *detailModelArrM = [[NSMutableArray alloc] init];
//                for (NSDictionary *dataInfo in dataArr) {
//                    XCUserViolationDetailModel *model = [XCUserViolationDetailModel yy_modelWithJSON:dataInfo];
//                    model.customerId = weakSelf.model.customerId;
//                    model.customerName = weakSelf.model.customerName;
//                    model.phone = weakSelf.model.phoneNo;
//                    model.contacts = weakSelf.model.customerName;
//                    model.carId = weakSelf.model.carId;
//                    model.plateNo = weakSelf.model.plateNo;
//                    model.remark = weakSelf.model.remark;
//                    model.type = @"违章";
//                    [detailModelArrM addObject:model];
//                }
//                weakSelf.dataArrM = detailModelArrM;
//                [weakSelf.tableView reloadData];
//            }
//            [weakSelf.tableView.mj_header endRefreshing];
//            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
//        } fail:^(id error) {
//            [weakSelf.tableView.mj_header endRefreshing];
//        }];
//    }];
//
//    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
//        weakSelf.pageIndex ++;
//        NSDictionary *param = @{
//                                @"carId":weakSelf.model.carId,
//                                };
//        if (weakSelf.pageIndex <= weakSelf.pageCount) {
//            [RequestAPI getWZMessageByCarId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
//                if (response[@"data"][@"lists"]) {
//                    NSArray *dataArr = response[@"data"][@"lists"];
//                    for (NSDictionary *dataInfo in dataArr) {
//                        XCUserViolationDetailModel *model = [XCUserViolationDetailModel yy_modelWithJSON:dataInfo];
//                        model.customerId = weakSelf.model.customerId;
//                        model.customerName = weakSelf.model.customerName;
//                        model.phone = weakSelf.model.phoneNo;
//                        model.contacts = weakSelf.model.customerName;
//                        model.carId = weakSelf.model.carId;
//                        model.plateNo = weakSelf.model.plateNo;
//                        model.remark = weakSelf.model.remark;
//                        model.type = @"违章";
//                        [weakSelf.dataArrM  addObject:model];
//                    }
//                    [weakSelf.tableView reloadData];
//                }
//                [weakSelf.tableView.mj_header endRefreshing];
//                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
//            } fail:^(id error) {
//                weakSelf.pageIndex --;
//                [weakSelf.tableView.mj_footer endRefreshing];
//            }];
//        }else {
//            weakSelf.pageIndex --;
//            if (weakSelf.pageIndex == weakSelf.pageCount) {
//                [weakSelf.tableView.mj_footer setState:MJRefreshStateNoMoreData];
//            }else {
//                [weakSelf.tableView.mj_footer endRefreshing];
//            }
//        }
//    }];
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications
- (void)XCUserViolationDetailClickCellClickButton:(UIButton *)button
                                      statusLabel:(UILabel *)statusLabel
                                            model:(XCUserViolationDetailModel *)model
{
    
    NSDictionary *param = @{
                            @"customerId":model.customerId,
                            @"customerName":model.customerName,
                            @"phone":model.phone,
                            @"contacts":model.contacts,
                            @"carId":model.carId,
                            @"plateNo":model.plateNo,
                            @"type":@"违章",
                            @"remark":model.remark,
                            @"buckleScores":model.buckleScores,
                            @"weizhangDate":model.weizhangDate,
                            @"weizhangArea":model.weizhangArea,
                            @"weizhangCity":model.weizhangCity,
                            @"weizhangClause":model.weizhangClause,
                            };
    __weak __typeof(self) weakSelf = self;
    __block NSString *requstStr = @"未知错误";
    [RequestAPI addOrderByAuditAndRules:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if ([response[@"result"] boolValue] == 1) {
            requstStr = @"预约成功";
        }else {
           requstStr = @"预约失败";
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:requstStr complete:nil];
        [strongSelf.view addSubview:tipsView];
        model.handled = @"2";
        //预约
        button.selected = YES;
        button.userInteractionEnabled = NO ;
        [statusLabel setText:@"处理中"];
        [statusLabel setTextColor:COLOR_RGB_255(253, 161, 0)];
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [strongSelf.view addSubview:tipsView];
    }];

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
//    return [XCUserViolationDetailClickCell getCellHeight];
    
    CGFloat num = 4 - 1;
    XCUserViolationDetailModel *model =  self.dataArrM[indexPath.row];
    CGFloat weizhangHeight = (26 + 12) * ViewRateBaseOnIP6;
    if (model.weizhangClause) {
        weizhangHeight = 12  * ViewRateBaseOnIP6  + [UILabel getXCTextHeightLineWithString:[NSString stringWithFormat:@"违章条款: %@",model.weizhangClause] withWidth:SCREEN_WIDTH - 30 * ViewRateBaseOnIP6  withFontSize:28];
    }
    return  (10 + 30) * ViewRateBaseOnIP6 + ((26 + 12) * ViewRateBaseOnIP6  * num) + 1 + (30 + 46+ 27 + 47)* ViewRateBaseOnIP6 + weizhangHeight;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [XCUserViolationDetailHeaderView getHeaderViewHeight];
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
