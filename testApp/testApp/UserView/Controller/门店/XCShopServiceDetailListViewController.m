//
//  XCShopServiceDetailListViewController.m
//  testApp
//
//  Created by Melody on 2018/4/13.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceDetailListViewController.h"
#import "XCShopDetailListCell.h"
#import "XCShopServiceModel.h"
#define kDetailListCellID @"DetailListCellID"
#import "XCShopServiceAddServiceViewController.h"
#import "XCShopServiceEditedServiceViewController.h"
#import "UILabel+createLabel.h"
#import <MJRefresh/MJRefresh.h>
#import "LYZAlertView.h"
@interface XCShopServiceDetailListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XCShopDetailListCellDelegate>


/** <# 注释 #> */
@property (nonatomic, strong) UICollectionView * collectionView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * addServiceBtn;
@end

@implementation XCShopServiceDetailListViewController

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

    [self configureData];
    [self createUI];
    __weak __typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf refreshServiceData];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshServiceData];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGSize labelSize = CGSizeMake(218 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6);
    [_bgImageView setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5,kHeightForNavigation + 342 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_bgLabel sizeToFit];
    labelSize = _bgLabel.frame.size;
    [_bgLabel setFrame:CGRectMake((self.view.bounds.size.width - labelSize.width) * 0.5, CGRectGetMaxY(_bgImageView.frame) + 40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
    [_collectionView setFrame:CGRectMake(0, kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - 98 * ViewRateBaseOnIP6 - kBottomMargan)];
    [_addServiceBtn setFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame) , SCREEN_WIDTH, 98 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method
- (void)clickAddNewService:(UIButton *)button
{
    NSDictionary *param = @{
                            @"storeId":self.storeID,
                            @"category":self.titleTypeStr,
                            @"PageSize":@"-1"
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI queryServiceByStoreId:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"data"]) {
            if (response[@"data"][@"dataSet"]) {
                NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                NSArray *origionDataArr = response[@"data"][@"dataSet"];
                for (NSDictionary *dataInfo in origionDataArr) {
                    //serviceID 为StoreID
//                    XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                    XCShopServiceModel *serviceModel = [[XCShopServiceModel alloc] init];
                    NSNumber *number;
                    NSString *serviceName;
                    if (dataInfo[@"id"]){
                         number = [NSNumber numberWithLong:[dataInfo[@"id"] longValue]];
                    }
                    if(dataInfo[@"name"]) {
                        serviceName = dataInfo[@"name"];
                    }
                    serviceModel.serviceId = number;
                    serviceModel.serviceName = serviceName;
                    [dataArrM addObject:serviceModel];
                }
                XCShopServiceAddServiceViewController *addService = [[XCShopServiceAddServiceViewController alloc] initWithTitle:@"添加服务"];
                addService.storeID = strongSelf.storeID;
                addService.dataArrM = dataArrM;
                [strongSelf.navigationController pushViewController:addService animated:YES];
            }
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误"];
    }];
    
}

- (void)refreshServiceData
{
    NSDictionary *param = @{
                            @"storeId":[UserInfoManager shareInstance].storeID,
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI getStoreService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (response[@"data"]) {
            NSDictionary *dataInfo = response[@"data"];
            NSArray *arr;
            if ([self.titleTypeStr isEqualToString:@"洗车"]) {
                arr = dataInfo[@"xcServiceList"];
            }
            else if ([self.titleTypeStr isEqualToString:@"美容"]) {
                arr = dataInfo[@"mrServiceList"];
            }
            else if ([self.titleTypeStr isEqualToString:@"保养"]) {
                arr = dataInfo[@"byServiceList"];
            }
            NSMutableArray * serviceDataArrM = [[NSMutableArray alloc] init];
            for (NSDictionary *dataInfo in arr) {
                XCShopServiceModel *serviceModel = [XCShopServiceModel yy_modelWithJSON:dataInfo];
                if (serviceModel) {
                    [serviceDataArrM addObject:serviceModel];
                }
            }
            strongSelf.dataArr = serviceDataArrM;
            [strongSelf.collectionView reloadData];
        }
        [strongSelf.collectionView.mj_header endRefreshing];
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误"];
    }];
}

#pragma mark - Delegates & Notifications
#pragma  mark - XCShopDetailListCellDelegate
-(void)XCShopDetailListCellClickEditedButton:(UIButton *)button serviceModel:(XCShopServiceModel *)serviceModel
{
    XCShopServiceEditedServiceViewController *editedVC = [[XCShopServiceEditedServiceViewController alloc] initWithTitle:serviceModel.serviceName];
    editedVC.model = serviceModel;
    
    [self.navigationController pushViewController:editedVC animated:YES];
    
}

- (void)XCShopDetailListCellClickDeleteButton:(UIButton *)button serviceModel:(XCShopServiceModel *)serviceModel
{
    //删除服务
    LYZAlertView *alterView = [LYZAlertView alterViewWithTitle:@"是否删除该项目" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
       
        NSDictionary *param = @{
                                @"storeServiceid":serviceModel.storeID,
                                };
        __weak __typeof(self) weakSelf = self;

        [RequestAPI deleteStoreService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1) {
                [strongSelf showAlterInfoWithNetWork:@"删除成功"];
                [strongSelf refreshServiceData];
            }else {
                [strongSelf showAlterInfoWithNetWork:@"删除失败"];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误"];
        }];
        
    }];
    [self.view addSubview:alterView];
}

#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UICollectionViewDataSource&&UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArr.count > 0 ) {
        [self hideNullDataView];
    }else {
        [self showNullDataView];
    }
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCShopServiceModel *model = self.dataArr[indexPath.row];
    XCShopDetailListCell *cell = (XCShopDetailListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDetailListCellID forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupCellWithModel:model];
    
    return cell;
}

#pragma mark - Privacy Method

- (void)configureData
{

}

- (void)createUI
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

     layout.itemSize = CGSizeMake(335 * ViewRateBaseOnIP6 ,(336 + 158) * ViewRateBaseOnIP6);
     layout.sectionInset =  UIEdgeInsetsMake( 30  * ViewRateBaseOnIP6, 30* ViewRateBaseOnIP6, 20 * ViewRateBaseOnIP6 ,30* ViewRateBaseOnIP6);
//    layout.minimumInteritemSpacing = 20 * ViewRateBaseOnIP6;
    layout.minimumLineSpacing = 20 * ViewRateBaseOnIP6;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - 98 * ViewRateBaseOnIP6) collectionViewLayout:layout];
    _collectionView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [_collectionView  registerClass:[XCShopDetailListCell class] forCellWithReuseIdentifier:kDetailListCellID];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _addServiceBtn = [UIButton buttonWithType:0];
    [_addServiceBtn setTitle:@"添加服务" forState:UIControlStateNormal];
    [_addServiceBtn setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
    _addServiceBtn.titleLabel.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
    [_addServiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,  24 * ViewRateBaseOnIP6, 0, 0)];
    [_addServiceBtn addTarget:self action:@selector(clickAddNewService:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image2 = [UIImage imageNamed:@"添加符号"];
    [_addServiceBtn setBackgroundColor:[UIColor whiteColor]];
    [_addServiceBtn setImage:image2 forState:UIControlStateNormal];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"dataEmpty"];
    _bgImageView.image = image;
    _bgLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(153, 153, 153)];
    [_bgLabel setText:@"暂无查询数据"];

    [self.view addSubview:_collectionView];
    [self.view addSubview:_addServiceBtn];
    [self.collectionView addSubview:_bgImageView];
    [self.collectionView addSubview:_bgLabel];
}

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
    if (self.collectionView) {
        self.collectionView.backgroundColor = [UIColor clearColor];
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
    if (self.collectionView) {
        self.collectionView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    }
}
#pragma mark - Setter&Getter

@end
