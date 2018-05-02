//
//  XCMyCommissionViewController.m
//  testApp
//
//  Created by Melody on 2018/3/22.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionViewController.h"
#import "RequestAPI.h"
#import "UILabel+createLabel.h"
#define kmyCommissionCellID @"myCommissionCellID"
#define kheaderViewID @"tableHeaderViewID"
#define kfooterViewID @"tableFooterViewID"

@interface XCMyCommissionViewController ()<UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate>

@property (nonatomic, strong) UIImageView * bgImageView ;
@property (nonatomic, strong) UILabel * bgLabel ;

@property (nonatomic, strong) UITableView * tableView ;
@end

@implementation XCMyCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setUI];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize labelSize = CGSizeMake(218 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6);
    [_bgImageView setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5,kHeightForNavigation + 342 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_bgLabel sizeToFit];
    labelSize = _bgLabel.frame.size;
    [_bgLabel setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5, CGRectGetMaxY(_bgImageView.frame) + 40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom))];

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
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    UIImage *image = [UIImage imageNamed:@"dataEmpty"];
    _bgImageView.image = image;
    _bgLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(153, 153, 153)];
    [_bgLabel setText:@"暂无查询数据"];
    [self.tableView addSubview:_bgImageView];
    [self.tableView addSubview:_bgLabel];
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
    if (self.dataArrM.count > 0 ) {
        [self hideNullDataView];
    }else {
        [self showNullDataView];
    }
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

#pragma mark - privaryMethod
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


#pragma mark - Setter&&Getter

- (void)setDataArrM:(NSMutableArray<XCMyCommissionListModel *> *)dataArrM
{
    _dataArrM = dataArrM;
    [self.tableView reloadData];
}

@end
