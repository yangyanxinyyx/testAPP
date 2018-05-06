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
#import "XCShopServiceAddsServiceFooterView.h"
#import "XCShopServiceEditedServiceViewController.h"
#import "UILabel+createLabel.h"
#define kDetailSelectID @"DetailSelectID"
#import <MJRefresh/MJRefresh.h>
@interface XCShopServiceAddServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView * bgImageView ;
@property (nonatomic, strong) UILabel * bgLabel ;

/** 提交审核按钮 */
@property (nonatomic, strong) UIButton * confirmBtn ;

/** <# 注释 #> */
@property (nonatomic, strong) XCShopServiceModel * currentModel ;
@end

@implementation XCShopServiceAddServiceViewController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureData];
    [self createUI];
    
    __weak __typeof(self) weakSelf = self;
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           NSDictionary *param = @{
                                   @"storeId":[UserInfoManager shareInstance].storeID,
                                   @"category":self.titleTypeStr,
                                   @"PageSize":@"-1"
                                   };
           [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
           [RequestAPI queryServiceByStoreId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
               if (response[@"data"]) {
                   if (response[@"data"][@"dataSet"]) {
                       NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                       NSArray *origionDataArr = response[@"data"][@"dataSet"];
                       for (NSDictionary *dataInfo in origionDataArr) {
                           //                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                           XCShopServiceModel *serviceModel = [[XCShopServiceModel alloc] init];
                           NSNumber *number;
                           NSString *serviceName;
                           NSNumber *price;
                           NSNumber *vipPrice;
                           if (dataInfo[@"id"]){
                               number = [NSNumber numberWithLong:[dataInfo[@"id"] longValue]];
                           }
                           if(dataInfo[@"name"]) {
                               serviceName = dataInfo[@"name"];
                           }
                           if (dataInfo[@"price"]){
                               price = [NSNumber numberWithLong:[dataInfo[@"price"] doubleValue]];
                           }
                           if (dataInfo[@"vipPrice"]){
                               vipPrice = [NSNumber numberWithLong:[dataInfo[@"vipPrice"] doubleValue]];
                           }
                           serviceModel.serviceId = number;
                           serviceModel.serviceName = serviceName;
                           serviceModel.price = price;
                           serviceModel.vipPrice = vipPrice;
                           [dataArrM addObject:serviceModel];
                       }
                       weakSelf.dataArrM = dataArrM;
                       [weakSelf.tableView reloadData];
                   }
               }
               [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
               [weakSelf.tableView.mj_header endRefreshing];
           } fail:^(id error) {
               [weakSelf.tableView.mj_header endRefreshing];

           }];
       }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isUsable([UserInfoManager shareInstance].storeID, [NSNumber class])) {
        NSDictionary *param = @{
                                @"storeId":[UserInfoManager shareInstance].storeID,
                                @"category":self.titleTypeStr,
                                @"PageSize":@"-1"
                                };
        __weak __typeof(self) weakSelf = self;
        [RequestAPI queryServiceByStoreId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        //                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                        XCShopServiceModel *serviceModel = [[XCShopServiceModel alloc] init];
                        NSNumber *number;
                        NSString *serviceName;
                        NSNumber *price;
                        NSNumber *vipPrice;
                        if (dataInfo[@"id"]){
                            number = [NSNumber numberWithLong:[dataInfo[@"id"] longValue]];
                        }
                        if(dataInfo[@"name"]) {
                            serviceName = dataInfo[@"name"];
                        }
                        if (dataInfo[@"price"]){
                            price = [NSNumber numberWithLong:[dataInfo[@"price"] doubleValue]];
                        }
                        if (dataInfo[@"vipPrice"]){
                            vipPrice = [NSNumber numberWithLong:[dataInfo[@"vipPrice"] doubleValue]];
                        }
                        
                        serviceModel.serviceId = number;
                        serviceModel.serviceName = serviceName;
                        serviceModel.price = price;
                        serviceModel.vipPrice = vipPrice;
                        
                        [dataArrM addObject:serviceModel];
                    }
                    weakSelf.dataArrM = dataArrM;
                    [weakSelf.tableView reloadData];
                }
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            
        }];
    }
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    CGSize labelSize = CGSizeMake(218 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6);
    [_bgImageView setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5,kHeightForNavigation + 342 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_bgLabel sizeToFit];
    labelSize = _bgLabel.frame.size;
    [_bgLabel setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5, CGRectGetMaxY(_bgImageView.frame) + 40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
    CGFloat tmpContentViewHeight =  (40 + 88 + 40 ) * ViewRateBaseOnIP6;
    CGFloat btnW = 690 * ViewRateBaseOnIP6;
    CGFloat btnH = 88 * ViewRateBaseOnIP6;
    [_confirmBtn setFrame:CGRectMake(30 * ViewRateBaseOnIP6,SCREEN_HEIGHT - tmpContentViewHeight + (tmpContentViewHeight - btnH) * 0.5 - safeAreaBottom , btnW, btnH)];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom  + tmpContentViewHeight))];
}

#pragma mark - Init Method
- (void)configureData
{

}

- (void)createUI
{
    [self.view setBackgroundColor:COLOR_RGB_255(242, 242, 242)];

    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"dataEmpty"];
    _bgImageView.image = image;
    _bgLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(153, 153, 153)];
    [_bgLabel setText:@"暂无查询数据"];
    _bgLabel.hidden = YES;
    _bgImageView.hidden = YES;
    
    _confirmBtn = [UIButton buttonWithType:0];
    _confirmBtn.layer.cornerRadius = 5;
    _confirmBtn.layer.backgroundColor = COLOR_RGB_255(0, 77, 162).CGColor;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:36 * ViewRateBaseOnIP6];
    [_confirmBtn setTitle:@"编辑价格" forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCShopDetailSeclectCell class] forCellReuseIdentifier:kDetailSelectID];
    [self.tableView registerClass:[XCShopServiceAddsServiceFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:_bgImageView];
    [self.tableView addSubview:_bgLabel];
    
}
#pragma mark - Action Method

- (void)clickConfirmBtn:(UIButton *)button
{
    
    if (self.currentModel) {
        XCShopServiceEditedServiceViewController *editedVC = [[XCShopServiceEditedServiceViewController alloc] initWithTitle:self.currentModel.serviceName];
        editedVC.model = self.currentModel;
        editedVC.isNewService = YES;
        [self.navigationController pushViewController:editedVC animated:YES];
    }else {
        [self showAlterInfoWithNetWork:@"请选择一项服务" complete:nil];
    }
 
    
}

#pragma mark - Delegates & Notifications
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArrM.count > 0 ) {
        [self hideNullDataView];
    }else {
        [self showNullDataView];
    }
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCShopServiceModel *model = self.dataArrM[indexPath.row];
    XCShopDetailSeclectCell *cell = (XCShopDetailSeclectCell *)[tableView dequeueReusableCellWithIdentifier:kDetailSelectID forIndexPath:indexPath];
    if (isUsableNSString(model.serviceName, @"")) {
        [cell setTitle:model.serviceName];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88 * ViewRateBaseOnIP6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (XCShopDetailSeclectCell *selectCell in self.tableView.visibleCells) {
        [selectCell setButtonSelect:NO];
    }
    for (XCShopServiceModel *model in self.dataArrM) {
        model.isSelect = NO;
    }
    XCShopDetailSeclectCell *cell = (XCShopDetailSeclectCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.currentModel = self.dataArrM[indexPath.row];
    self.currentModel.isSelect = YES;
    [cell setButtonSelect:self.currentModel.isSelect];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.dataArrM.count > 0) {
        XCShopServiceAddsServiceFooterView *footerView = [[XCShopServiceAddsServiceFooterView alloc] initWithReuseIdentifier:kFooterViewID];
        return footerView;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  20 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 
    return [XCShopServiceAddsServiceFooterView getFooterViewHeight];
}

#pragma mark - Privacy Method
- (void)showNullDataView
{
    if (self.bgLabel) {
        self.bgLabel.hidden = NO;
    }
    if (self.bgImageView) {
        self.bgImageView.hidden = NO;
    }
    if (self.tableView) {
        self.tableView.backgroundColor = [UIColor clearColor];
    }
}

- (void)hideNullDataView
{
    if (self.bgLabel) {
        self.bgLabel.hidden =YES;
    }
    if (self.bgImageView) {
        self.bgImageView.hidden = YES;
    }
    if (self.tableView) {
        self.tableView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    }
}
#pragma mark - Setter&Getter
@end
