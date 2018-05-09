//
//  XCCheckoutBaseTableViewController.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutBaseTableViewController.h"
#import "UILabel+createLabel.h"
@interface XCCheckoutBaseTableViewController ()
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * bgImageView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * bgLabel ;
@end

@implementation XCCheckoutBaseTableViewController

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
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"dataEmpty"];
    _bgImageView.image = image;
    _bgLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(153, 153, 153)];
    [_bgLabel setText:@"暂无查询数据"];
    _bgLabel.hidden = YES;
    _bgImageView.hidden = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCCheckoutTableViewCell class] forCellReuseIdentifier:kcheckCellID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kheaderViewID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.tableView addSubview:_bgImageView];
    [self.tableView addSubview:_bgLabel];
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGSize labelSize = CGSizeMake(218 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6);
    [_bgImageView setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5,kHeightForNavigation + 342 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_bgLabel sizeToFit];
    labelSize = _bgLabel.frame.size;
    [_bgLabel setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5, CGRectGetMaxY(_bgImageView.frame) + 40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom))];
    
}


#pragma mark - Action Method

#pragma mark - Privacy Method
- (void)showAlterInfoWithNetWork:(NSString *)titleStr
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:nil];
        [self.view addSubview:tipsView];
    });
   
}

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

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    [_topBar setTitle:navTitle];
}

#pragma mark - Delegates & Notifications

#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kheaderViewID];

    [headerView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    return headerView;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kfooterViewID];
//
//    return footerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20 * ViewRateBaseOnIP6;
    }else {
        return 0.1;
    }
}


@end
