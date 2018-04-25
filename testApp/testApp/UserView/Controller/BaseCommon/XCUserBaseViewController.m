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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
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

#pragma mark - scrollerViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}


#pragma mark - Privacy Method
//判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
- (void)showAlterInfoWithNetWork:(NSString *)titleStr
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:nil];
    [self.view addSubview:tipsView];
}

#pragma mark - Setter&Getter

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    [_topBar setTitle:navTitle];
}


@end
