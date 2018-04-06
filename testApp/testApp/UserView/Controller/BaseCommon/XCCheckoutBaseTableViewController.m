//
//  XCCheckoutBaseTableViewController.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#import "XCCheckoutBaseTableViewController.h"
@interface XCCheckoutBaseTableViewController ()
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCCheckoutTableViewCell class] forCellReuseIdentifier:kcheckCellID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kheaderViewID];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kfooterViewID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat scrrenH = SCREEN_HEIGHT;
    CGFloat navH = kHeightForNavigation;
    CGFloat tableH = scrrenH -  navH - safeAreaBottom ;
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, tableH)];
    // =================== modify by Liangyz 删除功能01
    //    if (self.editingIndexPath)
    //    {
    //        [self configSwipeButtons];
    //    }
    // ===================

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

#pragma mark - Privacy Method

//- (void)configSwipeButtons
//{
//    UIButton *deleteButton = nil;
//    // 获取选项按钮的reference
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0"))
//    {
//        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
//        for (UIView *subview in self.tableView.subviews)
//        {
//
//            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")])
//            {
//                // 和iOS 10的按钮顺序相反
//                [subview setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
//                deleteButton = subview.subviews[0];
//                [deleteButton setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
//
//                [self configDeleteButton:deleteButton];
//            }
//        }
//    }
//    else
//    {
//        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
//        XCCheckoutTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
//        for (UIView *subview in tableCell.subviews)
//        {
//
//            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
//            {
//                deleteButton = subview.subviews[0];
//                [self configDeleteButton:deleteButton];
//                [subview setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
//
//            }
//        }
//    }
//
//}
//
//- (void)configDeleteButton:(UIButton*)deleteButton
//{
//    if (deleteButton)
//    {
//        [deleteButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
//        [deleteButton setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
//
//    }
//}

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kfooterViewID];

    [footerView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    return footerView;
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


// =================== modify by Liangyz 删除功能03
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.editingIndexPath = indexPath;
//    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.editingIndexPath = nil;
//}
// ===================

@end
