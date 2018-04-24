//
//  XCShopServiceAddServiceViewController.m
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceAddServiceViewController.h"
#import "XCShopDetailSeclectCell.h"
#import "XCShopServiceModel.h"
#define kDetailSelectID @"DetailSelectID"
@interface XCShopServiceAddServiceViewController ()<XCDistributionFooterViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation XCShopServiceAddServiceViewController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureData];
    [self createUI];
}

#pragma mark - Init Method
- (void)configureData
{

}

- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCShopDetailSeclectCell class] forCellReuseIdentifier:kDetailSelectID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
}
#pragma mark - Action Method
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    
    NSMutableArray *addItemsArrM = [[NSMutableArray alloc] init];
    for (XCShopServiceModel *model  in self.dataArrM) {
        if (model.isSelect) {
            if (isUsable(model.serviceId, [NSNumber class])) {
                [addItemsArrM addObject:model.serviceId];
            }
        }
    }
    
    NSDictionary *param = @{
                            @"storeId":self.storeID,
                            @"category":addItemsArrM,
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI insertService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errorStr = response[@"errormsg"];
        if ([response[@"result"] integerValue] == 1) {
            errorStr = @"提交成功";
        }
        [strongSelf showAlterInfoWithNetWork:errorStr];
   [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
        [strongSelf showAlterInfoWithNetWork:errStr];
    }];
    
    
    
}

#pragma mark - Delegates & Notifications
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCShopServiceModel *model = self.dataArrM[indexPath.row];
    XCShopDetailSeclectCell *cell = (XCShopDetailSeclectCell *)[tableView dequeueReusableCellWithIdentifier:kDetailSelectID forIndexPath:indexPath];
    NSString *name = @"未知";
    if (isUsableNSString(model.serviceName, @"")) {
        name = model.serviceName;
    }
    [cell setTitle:name];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88 * ViewRateBaseOnIP6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCShopDetailSeclectCell *cell = (XCShopDetailSeclectCell *)[tableView cellForRowAtIndexPath:indexPath];
    XCShopServiceModel *model = self.dataArrM[indexPath.row];
    model.isSelect = !model.isSelect;
    [cell setButtonSelect:model.isSelect];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"提交审核"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  20 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (60 + 88 + 60) * ViewRateBaseOnIP6;
}


#pragma mark - Privacy Method

#pragma mark - Setter&Getter
@end
