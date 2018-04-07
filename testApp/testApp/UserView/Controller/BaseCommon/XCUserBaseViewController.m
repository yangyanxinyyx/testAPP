//
//  XCUserBaseViewController.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"

@interface XCUserBaseViewController ()

@end

@implementation XCUserBaseViewController

#pragma mark - Init Method

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
        _topBar = [[BaseNavigationBar alloc] init];
        _topBar.delegate  = self;
        _topBar.title = title;
        self.navTitle = title;
        [self.view addSubview:_topBar];
    }
    return self;
}
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.tableView];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom ))];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    [headerView.contentView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20 * ViewRateBaseOnIP6;
}
#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Privacy Method

#pragma mark - Setter&Getter

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    [_topBar setTitle:navTitle];
}


@end
