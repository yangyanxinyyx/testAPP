//
//  XCUserCaseBaseTableViewController.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseBaseTableViewController.h"
#import "UILabel+createLabel.h"
@interface XCUserCaseBaseTableViewController ()
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * bgImageView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * bgLabel ;
@end

@implementation XCUserCaseBaseTableViewController

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
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"dataEmpty"];
    _bgImageView.image = image;
    _bgLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(153, 153, 153)];
    [_bgLabel setText:@"暂无查询数据"];
    [self.view addSubview:_bgImageView];
    [self.view addSubview:_bgLabel];
    [self.view setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize labelSize = CGSizeMake(218 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6);
    [_bgImageView setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5,kHeightForNavigation + 342 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_bgLabel sizeToFit];
    labelSize = _bgLabel.frame.size;
    [_bgLabel setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5, CGRectGetMaxY(_bgImageView.frame) + 40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];

    if (self.dataArr.count > 0 ) {
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom))];
    }else {
        [self.tableView setFrame:CGRectZero];
    }
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    [headerView.contentView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0 * ViewRateBaseOnIP6;
}
#pragma mark - Privacy Method

#pragma mark - Setter&Getter

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    [_topBar setTitle:navTitle];
}
@end
