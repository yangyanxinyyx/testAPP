//
//  UserViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserViewController.h"
#import "XCCheckoutBaseTableViewController.h"
#import "XCUserTopView.h"
#import "XCUserListView.h"
#import "XCUserListCollectionViewCell.h"
#import "XCUserListHeaderView.h"
#import "XCUserListFooterView.h"
#import "XCUserListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XCMyCommissionViewController.h"
#import "XCModifyPwdViewController.h"
#import "LoginViewController.h"
#define kCellID @"myCellID"
#define kHeaderViewID @"myHeaderID"
#define kFooterViewID @"myFooterID"
#import "UserViewController+ListCellNetworkHandler.h"
#import "AppDelegate.h"
@interface UserViewController ()<XCUserTopViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XCUserListFooterViewDelegate>
{
    BOOL _isStore; //判断用户 是否门店ID
}
@property (nonatomic, strong) XCUserTopView * topView;
@property (nonatomic, strong) XCUserListView * listView ;
@property (nonatomic, strong) NSMutableArray * listViewDataArray ;

@end

@implementation UserViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UserInfoManager *userManager = [UserInfoManager shareInstance];
    _isStore = NO;
    if (userManager.isStore) {
        _isStore = YES;
    }
    [self initWithListData];
    [self setUI];
    //设置用户头型数据UI
    if (userManager) {
        [self.topView setUserName:userManager.employeeName];
        if (userManager.iconUrl) {
            [self.topView setUserIconUrlString:userManager.iconUrl];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    UserInfoManager *userManager = [UserInfoManager shareInstance];
    _isStore = NO;
    if (userManager.isStore) {
        _isStore = YES;
    }
    [self initWithListData];
    //设置用户头型数据UI
    if (userManager) {
        [self.topView setUserName:userManager.employeeName];
        if (userManager.iconUrl) {
            [self.topView setUserIconUrlString:userManager.iconUrl];
        }
    }
    [self.listView reloadData];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.topView setFrame:CGRectMake(0, isIPhoneX?safeAreaTop:STATUS_BAR_HEIGHT + safeAreaTop, SCREEN_WIDTH, (88 + 310) * ViewRateBaseOnIP6)]; //88为导航栏高度
    [self.listView setFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.topView.frame) - SCREEN_TABBAR_HEIGHT )];

}

#pragma mark - UI

- (void)setUI {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.topView = [[XCUserTopView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, (88 + 310) * ViewRateBaseOnIP6)]; // 要适配IPhoneX
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    if (self.listViewDataArray) {
        [self.view addSubview:self.listView];
        [self.view bringSubviewToFront:self.topView];
    }
}

#pragma mark - Action Method

- (void)clickMyCommission
{
    NSDictionary *param = @{
                            @"user_id":[UserInfoManager shareInstance].userID,
                            };
    __weak typeof (self)weakSelf = self;
    [RequestAPI getMyCommission:param header:[UserInfoManager shareInstance].ticketID  success:^(id response) {
        XCMyCommissionViewController *myCommissionVC = [[XCMyCommissionViewController alloc] init];
        if (isUsableArray(response[@"data"], 0)) {
            NSMutableArray <XCMyCommissionListModel *>*modelArr = [[NSMutableArray alloc] init];
            NSArray *dataArr  = response[@"data"];
            for (NSDictionary *commissionInfo in dataArr) {
                XCMyCommissionListModel  * listModel = [XCMyCommissionListModel getMyCommissionListWithDataInfo:commissionInfo];
                [modelArr addObject:listModel];
            }
            myCommissionVC.dataArrM = modelArr;
        }
        [weakSelf.navigationController pushViewController:myCommissionVC animated:YES];
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        XCMyCommissionViewController *myCommissionVC = [[XCMyCommissionViewController alloc] init];
        [weakSelf.navigationController pushViewController:myCommissionVC animated:YES];
    }];
}

- (void)clickModifyBtn
{
    XCLog(@"ClickModifyPasswordBtn");
    XCModifyPwdViewController *modifyVC = [[XCModifyPwdViewController alloc] init];
    [self.navigationController pushViewController:modifyVC animated:YES];
}

#pragma mark - Delegates & Notifications

#pragma mark - XCUserListFooterViewDelegate
-(void)XCUserListFooterViewClickCancelBtn:(UIButton *)button
{
    __weak __typeof(self) weakSelf = self;
    LYZAlertView *alterView = [LYZAlertView alterViewWithTitle:@"是否退出登录" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [UserInfoManager destroyInstance];
        [weakSelf.tabBarController setSelectedIndex:0];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController presentViewController:loginVC animated:NO completion:nil];    }];
    [self.view addSubview:alterView];
}

#pragma mark - XCUserTopViewDelegate

- (void)XCUserTopViewMyCommissionButtonClickHandler:(UIButton *)button
{
    [self clickMyCommission];
}

- (void)XCUserTopViewModifyPasswordButtonClickHandler:(UIButton *)button
{
    [self clickModifyBtn];
}

#pragma mark - UICollectionViewDataSource&&UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.listViewDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *groupInfo = self.listViewDataArray[section];
    NSArray *listArr = groupInfo[@"List"];
    return listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCUserListCollectionViewCell *cell =(XCUserListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.title = nil;
    cell.icon = nil;
    NSDictionary *groupInfo = self.listViewDataArray[indexPath.section];
    NSArray *listArr = groupInfo[@"List"];
    XCUserListModel *model = [[XCUserListModel alloc] initWithItemInfo:listArr[indexPath.row]];
    cell.title = model.title;
//  cell.icon = [UIImage imageWithContentsOfFile:model.iconPath];
    cell.icon = [UIImage imageNamed:model.iconPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        XCUserListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID forIndexPath:indexPath];
        NSDictionary *groupInfo = self.listViewDataArray[indexPath.section];
        headerView.groupName = groupInfo[@"GroupName"];
        if (indexPath.section == 0) {
            headerView.frame = CGRectMake(0, 0, self.listView.frame.size.width, 88 * ViewRateBaseOnIP6);
        }
        return headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        
        XCUserListFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterViewID forIndexPath:indexPath];
        footerView.delegate = self;
        return footerView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.listView.frame.size.width, 70 * ViewRateBaseOnIP6);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section != (self.listViewDataArray.count - 1)){
        return CGSizeMake(self.listView.frame.size.width,0);
    }
    return CGSizeMake(self.listView.frame.size.width, [XCUserListFooterView getFooterViewHeight]);
}
#pragma mark - UICollectionViewDidSeclect

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *groupInfo = self.listViewDataArray[indexPath.section];
    NSArray *listArr = groupInfo[@"List"];
    XCUserListModel *model = [[XCUserListModel alloc] initWithItemInfo:listArr[indexPath.row]];
    NSLog(@"=====CollectionViewSelect %@",model.urlString);
    if (isUsableNSString(model.urlString, @"")) {
        [self clickCellHanderNetWorkDataWithModel:model];
    }
}

#pragma mark - Privacy Method
- (void)showAlterInfoWithNetWork:(NSString *)titleStr complete:(void (^)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:complete];
        [self.view addSubview:tipsView];
    });
  
}
- (void)initWithListData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"userListViewData" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *dataArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSInteger listCount = dataArr.count;
        if (!_isStore) {
            if (dataArr.count >= 1) {
                listCount = dataArr.count - 1;
            }
        }
        self.listViewDataArray = [NSMutableArray arrayWithCapacity:listCount];
        for (int i = 0 ; i < listCount; i++) {
            id object = dataArr[i];
            [self.listViewDataArray addObject:object];
        }
    }else {
        XCLog(@"Error: class:%@ -initWithData filePath was None",[self class]);
    }
}

- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}

#pragma mark - Setter&Getter

- (XCUserListView *)listView
{
    if (!_listView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        //  layout.itemSize = CGSizeMake(188 * ViewRateBaseOnIP6 , 180 * ViewRateBaseOnIP6);
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 4)/4.0 , 180 * ViewRateBaseOnIP6);
        
        _listView = [[XCUserListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.topView.frame) - SCREEN_TABBAR_HEIGHT) collectionViewLayout:layout];
        _listView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        [_listView  registerClass:[XCUserListCollectionViewCell class] forCellWithReuseIdentifier:kCellID];
        [_listView registerClass:[XCUserListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID];
        [_listView registerClass:[XCUserListFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterViewID];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.bounces = NO;
        _listView.dataSource = self;
        _listView.delegate = self;
    }
    return _listView;
}
@end
