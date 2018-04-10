//
//  XCMyCommissionViewController.m
//  testApp
//
//  Created by Melody on 2018/3/22.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionViewController.h"
#import "RequestAPI.h"
#define kmyCommissionCellID @"myCommissionCellID"
#define kheaderViewID @"tableHeaderViewID"
#define kfooterViewID @"tableFooterViewID"

@interface XCMyCommissionViewController ()<UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate>

@property (nonatomic, strong) UITableView * tableView ;
@end

@implementation XCMyCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  

    [self setupNav];
//    self.dataArrM = [[NSMutableArray alloc] init];
//
//    NSDictionary *dictory = @{
//                                          @"car_commission":@(336),
//                                          @"car_royalties":@(426),
//                                          @"medal_bonus":@(300),
//                                          @"car_performance":@(466319),
//                                          @"creat_time":@"2018-03-30 17:58:05.0"
//                                          };
//
//    XCMyCommissionListModel *model = [XCMyCommissionListModel getMyCommissionListWithDataInfo:dictory];
//
//    [self.dataArrM addObject:model];
//    [self.dataArrM addObject:model];
//    [self.dataArrM addObject:model];

    [self setUI];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, 64 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 )];
}

#pragma mark - InitUI

- (void)setupNav
{
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"我的佣金";
    [self.view addSubview:topBar];
}

- (void)setUI
{
    [self.view setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCMyCommissionListCell class] forCellReuseIdentifier:kmyCommissionCellID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kheaderViewID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kfooterViewID];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

#pragma  mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - UITableViewDelegate&DateSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArrM.count ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30 * ViewRateBaseOnIP6;
    }else {
        return 20 * ViewRateBaseOnIP6;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dataArrM.count - 1) {
        return 20 * ViewRateBaseOnIP6;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kcellForTimeViewH + kcellForCarListViewH + kcellForServiceListViewH + kcellForMedalViewH ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kheaderViewID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kfooterViewID];
    
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCMyCommissionListCell *cell = [tableView dequeueReusableCellWithIdentifier:kmyCommissionCellID];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XCMyCommissionListModel *model = self.dataArrM[indexPath.section];
    if (model) {
        [cell setupCellDataWithModel:model];
    }
    return cell;
}

#pragma mark - Setter&&Getter

- (void)setDataArrM:(NSMutableArray<XCMyCommissionListModel *> *)dataArrM
{
    _dataArrM = dataArrM;
    [self.tableView reloadData];
}

@end
