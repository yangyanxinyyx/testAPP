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
@interface XCShopServiceAddServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 提交审核按钮 */
@property (nonatomic, strong) UIButton * confirmBtn ;

@end

@implementation XCShopServiceAddServiceViewController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureData];
    [self createUI];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    CGFloat tmpContentViewHeight =  (40 + 88 + 40 ) * ViewRateBaseOnIP6;
    CGFloat btnW = 690 * ViewRateBaseOnIP6;
    CGFloat btnH = 88 * ViewRateBaseOnIP6;
    [_confirmBtn setFrame:CGRectMake(30 * ViewRateBaseOnIP6,SCREEN_HEIGHT - tmpContentViewHeight + (tmpContentViewHeight - btnH) * 0.5 , btnW, btnH)];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom  + tmpContentViewHeight))];
}

#pragma mark - Init Method
- (void)configureData
{

}

- (void)createUI
{
    [self.view setBackgroundColor:COLOR_RGB_255(242, 242, 242)];

    _confirmBtn = [UIButton buttonWithType:0];
    _confirmBtn.layer.cornerRadius = 5;
    _confirmBtn.layer.backgroundColor = COLOR_RGB_255(0, 77, 162).CGColor;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:36 * ViewRateBaseOnIP6];
    [_confirmBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCShopDetailSeclectCell class] forCellReuseIdentifier:kDetailSelectID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
    
}
#pragma mark - Action Method

- (void)clickConfirmBtn:(UIButton *)button
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
                            @"serviceArrayId":[addItemsArrM yy_modelToJSONString],
                            @"storeId":self.storeID,
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI insertService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errorStr = response[@"errormsg"];
        if ([response[@"result"] integerValue] == 1) {
            errorStr = @"提交成功,待审核!";
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  20 * ViewRateBaseOnIP6;
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
@end
