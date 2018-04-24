//
//  XCCustomerViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerViewController.h"
#import "XCCustomerDetailViewController.h"
#import "XCCustomerListModel.h"
#import <MJRefresh/MJRefresh.h>
#import "XCCustomerDetailModel.h"
#import "XCCustomerADDViewController.h"
#import "PriceCarInsuranceQViewController.h"
@interface XCCustomerViewController ()<XCCheckoutTableViewCellDelegate> {
    CGFloat _addBtnHeigth;
}
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * addCustomerBtn ;

@end

@implementation XCCustomerViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _addBtnHeigth = 88 * ViewRateBaseOnIP6;
    self.pageIndex = 1;
    [self createUI];
    __weak typeof (self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSDictionary *param = @{
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        weakSelf.pageIndex = 1;
        [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
        [RequestAPI getCustomerList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCustomerListModel *baseModel = [XCCustomerListModel yy_modelWithJSON:dataInfo];
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
                                @"PageIndex":[NSNumber numberWithInt:weakSelf.pageIndex],
                                @"PageSize":[NSNumber numberWithInt:6]
                                };
        if (weakSelf.pageIndex <= weakSelf.pageCount) {
            [RequestAPI getCustomerList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"]) {
                    if (response[@"data"][@"dataSet"]) {
                        NSArray *origionDataArr = response[@"data"][@"dataSet"];
                        for (NSDictionary *dataInfo in origionDataArr) {
                            XCCustomerListModel *baseModel = [XCCustomerListModel yy_modelWithJSON:dataInfo];
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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + _addBtnHeigth + kBottomMargan))];
    [self.addCustomerBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, _addBtnHeigth)];
    
}

#pragma mark - Action Method

- (void)clickAddCustomerButton:(UIButton *)button
{
    XCCustomerADDViewController *customerADDVC = [[XCCustomerADDViewController alloc] initWithTitle:@"新增客户"];
    [self.navigationController pushViewController:customerADDVC animated:YES];
}


#pragma mark - privary Method

- (void)createUI
{
    _addCustomerBtn = [UIButton buttonWithType:0];
    [_addCustomerBtn setTitle:@"新增客户" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"NewCustomeradd2"];
    [_addCustomerBtn setImage:image forState:UIControlStateNormal];
    [_addCustomerBtn setBackgroundColor:COLOR_RGB_255(104, 153, 232)];
    [_addCustomerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 24 * ViewRateBaseOnIP6, 0, 0)];
    [_addCustomerBtn addTarget:self action:@selector(clickAddCustomerButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addCustomerBtn];
}

- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    cell.delegate = self;
    XCCustomerListModel *model = self.dataArr[indexPath.row];
    [cell setupCellWithMYCustomerListModel:model];
//    cell.carNumber = @"粤AAAAAA";
//    cell.userName = @"梁艺钟";
//    cell.issureTime = @"a123213-321-321-3";
    cell.isCustomerCell = YES;
    return cell;
}



#pragma mark - XCCheckoutTableViewCellDelegate

//点击查看按钮
- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
//    [self clickCheckDetailButton];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XCCustomerListModel *model = self.dataArr[indexPath.row];

    NSDictionary *param = @{
                            @"carId":model.carId,
                            @"customerId":model.customerId
                            };
    __weak typeof (self)weakSelf = self;
    [RequestAPI getCustomerParticularsList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        BOOL configureSucess  = NO;
        if (response[@"data"]) {
            
          
            XCCustomerDetailModel *detailModel = [XCCustomerDetailModel yy_modelWithJSON:response[@"data"]];
            detailModel.customerId = model.customerId;
            XCCustomerDetailViewController *detailVC = [[XCCustomerDetailViewController alloc] initWithTitle:@"客户详情"];
            detailVC.model = detailModel;
            if ([model.status isEqualToString:@"新客户"]||[model.status isEqualToString:@"跟进中"]) {
                detailVC.shouldClickFllowerBtn = YES;
            }else {
                detailVC.shouldClickFllowerBtn = NO;
            }
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
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

//点击核保按钮
-(void)XCCheckoutCellClickUnderWritingButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
   NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    XCCustomerDetailModel *detailModel = self.dataArr[indexPath.row];
    PriceCarInsuranceQViewController *insuranceQVC = [[PriceCarInsuranceQViewController alloc] init];
    insuranceQVC.carID = [detailModel.carId stringValue];
    insuranceQVC.customerId = [detailModel.customerId stringValue];
    [self.navigationController pushViewController:insuranceQVC animated:YES];
}

@end
