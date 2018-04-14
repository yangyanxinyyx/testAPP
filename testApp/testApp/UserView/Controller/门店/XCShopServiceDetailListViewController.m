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
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_collectionView setFrame:CGRectMake(0, kHeightForNavigation + kBottomMargan, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - 98 * ViewRateBaseOnIP6 - kBottomMargan)];
    [_addServiceBtn setFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame) , SCREEN_WIDTH, 98 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method
- (void)clickAddNewService:(UIButton *)button
{
    XCShopServiceAddServiceViewController *addService = [[XCShopServiceAddServiceViewController alloc] initWithTitle:@"添加服务"];
    [self.navigationController pushViewController:addService animated:YES];
}
#pragma mark - Delegates & Notifications
#pragma  mark - XCShopDetailListCellDelegate

-(void)XCShopDetailListCellClickEditedButton:(UIButton *)button
{
    NSLog(@"点击编辑");
    
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
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCShopDetailListCell *cell = (XCShopDetailListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDetailListCellID forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupCellWithModel:self.currentModel];
    
    return cell;
}

#pragma mark - Privacy Method

- (void)configureData
{
    self.currentModel = [[XCShopServiceModel alloc] init];
    _currentModel.serviceName = @"标准清洗";
    _currentModel.vipPrice = @"40";
    _currentModel.price = @"45";
}

- (void)createUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumInteritemSpacing = 18 * ViewRateBaseOnIP6;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - (30 + 18 + 30)*ViewRateBaseOnIP6) * 0.5 , (336+158) * ViewRateBaseOnIP6);
    layout.sectionInset =  UIEdgeInsetsMake( 20 * ViewRateBaseOnIP6, 25* ViewRateBaseOnIP6, 0,25 * ViewRateBaseOnIP6);
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
    UIImage *image = [UIImage imageNamed:@"添加符号"];
    [_addServiceBtn setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:_collectionView];
    [self.view addSubview:_addServiceBtn];
}
#pragma mark - Setter&Getter

@end
