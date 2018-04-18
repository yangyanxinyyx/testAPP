//
//  XCCustomerRepairViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerRepairViewController.h"
#import "XCCustomerShopModel.h"
#import "SelectTimeView.h"
#import "XCCustomerShopListView.h"
@interface XCCustomerRepairViewController ()<XCDistributionFooterViewDelegate>
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * shopModelArrM ;
@end

@implementation XCCustomerRepairViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    self.shopModelArrM = [[NSMutableArray alloc] init];
    

  
}

#pragma mark - Init Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"门店选择",@"预约日期:"]];
}
- (void)initUI
{
    
}
#pragma mark - Action Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row == 0) {
        __weak __typeof(self) weakSelf = self;
        XCCustomerShopListView *listView = [[XCCustomerShopListView alloc] initWithDataArr:self.shopModelArrM confirmBlock:^(XCCustomerShopModel *model) {
            
            NSLog(@"%@",model);
        }];
        [self.view addSubview:listView];
    }
    
}
#pragma mark - Delegates & Notifications
#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    FinishTipsView *alterView = [[FinishTipsView alloc] initWithTitle:@"预约成功" complete:^{
        
    }];
    [self.view addSubview:alterView];
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArrM[indexPath.row];
    XCDistributionPicketCell *cell = (XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID forIndexPath:indexPath];
    if (indexPath.row == self.dataArrM.count - 1) {
        cell.shouldShowSeparator = NO;
    }
    [cell setTitle:title];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"预约"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerViewHeigth;
    footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
    return footerViewHeigth;
}

#pragma mark - Privacy Method
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Setter&Getter

- (void)setLocation:(CLLocation *)location
{
    _location = location;
    __weak __typeof(self) weakSelf = self;
    NSDictionary *param = @{
                            @"longitude":[NSNumber numberWithDouble:_location.coordinate.longitude],
                            @"latitude":[NSNumber numberWithDouble:_location.coordinate.latitude],
                            @"PageSize":[NSNumber numberWithInt:10],
                            };
    [RequestAPI appFindStore:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"data"]) {
            if (response[@"data"][@"dataSet"]) {
                NSArray *origionDataArr = response[@"data"][@"dataSet"];
                for (NSDictionary *dataInfo in origionDataArr) {
                    XCCustomerShopModel *shopModel = [XCCustomerShopModel yy_modelWithJSON:dataInfo];
                    if (shopModel) {
                        [strongSelf.shopModelArrM addObject:shopModel];
                    }
                }
            }
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf requestFailureHandler];
    }];

}

@end
