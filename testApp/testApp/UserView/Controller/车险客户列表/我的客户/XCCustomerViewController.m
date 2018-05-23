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
#import "PriceCarInsuranceQViewController.h"
#import "PriceCustomerInformEntryViewController.h"
#import "XCCustomerSearchView.h"

@interface XCCustomerViewController ()<XCCheckoutTableViewCellDelegate,XCCustomerSearchViewDelegate> {
    CGFloat _addBtnHeigth;
}
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * addCustomerBtn ;

/** <# 注释 #> */
@property (nonatomic, strong) XCCustomerSearchView * searchView ;

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
                weakSelf.pageCount = [pageCountNum intValue];
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
    
    [self.searchView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, 96 * ViewRateBaseOnIP6)];
    [self.tableView setFrame:CGRectMake(0, CGRectGetMaxY(self.searchView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + _addBtnHeigth + kBottomMargan + 96 * ViewRateBaseOnIP6))];
    [self.addCustomerBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, _addBtnHeigth)];
    
}

#pragma mark - Action Method

- (void)clickAddCustomerButton:(UIButton *)button
{
    PriceCustomerInformEntryViewController *customerADDVC = [[PriceCustomerInformEntryViewController alloc] init];
    customerADDVC.titleName = @"新增客户";
    [self.navigationController pushViewController:customerADDVC animated:YES];
}


#pragma mark - privary Method

- (void)createUI
{
    
    _searchView = [[XCCustomerSearchView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, 96 * ViewRateBaseOnIP6)];
    _searchView.delegate = self;
    [self.view addSubview:_searchView];
    
    _addCustomerBtn = [UIButton buttonWithType:0];
    [_addCustomerBtn setTitle:@"新增客户" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"NewCustomeradd2"];
    [_addCustomerBtn setImage:image forState:UIControlStateNormal];
    [_addCustomerBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
    [_addCustomerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 24 * ViewRateBaseOnIP6, 0, 0)];
    [_addCustomerBtn addTarget:self action:@selector(clickAddCustomerButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addCustomerBtn];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)requestFailureHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    });
}


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
    cell.delegate = self;
    XCCustomerListModel *model = self.dataArr[indexPath.row];
    [cell setupCellWithMYCustomerListModel:model];

    cell.isCustomerCell = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return 0.1;
    }
}

#pragma mark - XCCustomerSearchViewDelegate

- (void)XCCustomerSearchViewClickSerachWithText:(NSString *)text textFiled:(UITextField *)textfiled
{
    NSLog(@"====>Click");
    [self viewTapped:nil];
    
    NSDictionary *param = @{
                            @"PageIndex":[NSNumber numberWithInt:1],
                            @"PageSize":[NSNumber numberWithInt:10],
                            @"searchCriteria":text
                            };
    self.pageIndex = 1;
    __weak __typeof(self) weakSelf = self;
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.dataArr = dataArrM;
                    [weakSelf.tableView reloadData];
                });
            }
            NSNumber *pageCountNum = response[@"data"][@"pageCount"];
            weakSelf.pageCount = [pageCountNum intValue];
        }

        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        [weakSelf showAlterInfoWithNetWork:@"网络错误"];
    }];
   
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
    [UserInfoManager shareInstance].carID = [detailModel.carId stringValue];
    insuranceQVC.customerId = [detailModel.customerId stringValue];
    [self.navigationController pushViewController:insuranceQVC animated:YES];
}


@end
