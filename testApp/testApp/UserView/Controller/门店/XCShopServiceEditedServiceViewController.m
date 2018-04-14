//
//  XCShopServiceEditedServiceViewController.m
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceEditedServiceViewController.h"

@interface XCShopServiceEditedServiceViewController ()<XCDistributionFooterViewDelegate>

@end

@implementation XCShopServiceEditedServiceViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID ];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}

#pragma mark - Init Method

- (void)configureData
{
//    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"预约时间",@"类型选择",@"年审费用",@"行驶证拍照"]];
}
- (void)initUI
{
    
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - XCDistributionFooterViewDelegate


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
    
    if (indexPath.row == 2) {
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        [textFiledCell setTitle:title];
        //        [textFiledCell setTitlePlaceholder:placetext];
        return textFiledCell;
        
    }else if(indexPath.row == 3) {
        
    }
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
    [footerView setTitle:@"保存"];
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

#pragma mark - Setter&Getter

@end
