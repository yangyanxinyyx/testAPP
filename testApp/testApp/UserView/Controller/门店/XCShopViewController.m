//
//  XCShopViewController.m
//  testApp
//
//  Created by Melody on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopViewController.h"
#import "BaseNavigationBar.h"
#import "priceCIQChangeView.h"
@interface XCShopViewController ()<UITableViewDelegate,UITableViewDataSource,priceCIQChangeViewDelegate,BaseNavigationBarDelegate>
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) priceCIQChangeView *CIQChangeView;
@property (nonatomic, strong) UIView *viewBear;
@property (nonatomic, strong) UIView *viewLastY;
@property (nonatomic, strong) UIView *viewPriceRecord;
@property (nonatomic, strong) UITableView *serviceTableView;
@property (nonatomic, strong) UITableView *storeTableView;
@property (nonatomic, strong) UIView *viewSegment;
@end

@implementation XCShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - lifeCycle

#pragma mark - Init Method
#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.contenView];
    [self.contenView addSubview:self.viewBear];
    [self.contenView addSubview:self.CIQChangeView];
    [self.viewBear addSubview:self.viewLastY];
    [self.viewBear addSubview:self.viewPriceRecord];
    [self.viewLastY addSubview:self.storeTableView];
    [self.viewPriceRecord addSubview:self.serviceTableView];
    [self.contenView addSubview:self.viewSegment];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark -priceCIQChangeViewDelegate
- (void)changeModel:(BOOL)isLaseY{
    if (isLaseY) {
        self.viewBear.frame = CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    } else {
        self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

#pragma mark - Privacy Method
- (void)configureData
{
    NSArray *storeTitleArr = @[@"门店名称:",@"联系方式:",@"负责人:",
                          @"负责人电话:",@"业务员提成:",@"团队经理提成:",
                          @"所属城市",@"所在地区",@"门店审核状态",
                          @"营业执照上传,1张",@"门店图片,最多4张"];
    NSArray *serviceTitleArr = @[@"洗车项目",@"美容项目",@"保养项目"];
}
#pragma mark - Setter&Getter
- (UIView *)contenView{
    if (!_contenView) {
        _contenView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _contenView;
}

- (priceCIQChangeView *)CIQChangeView{
    if (!_CIQChangeView) {
        _CIQChangeView = [[priceCIQChangeView alloc] initWithFrame:CGRectMake(0, 20 * ViewRateBaseOnIP6, SCREEN_WIDTH, 160 * ViewRateBaseOnIP6)];
        _CIQChangeView.delegate = self;
        [_CIQChangeView setleftTitle:@"门店信息" rightTitle:@"服务信息"];
    }
    return _CIQChangeView;
}

- (UITableView *)serviceTableView{
    if (!_serviceTableView) {
        _serviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 244 * ViewRateBaseOnIP6) style:UITableViewStylePlain];
        _serviceTableView.delegate = self;
        _serviceTableView.dataSource = self;
        _serviceTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _serviceTableView.showsVerticalScrollIndicator = NO;
        _serviceTableView.bounces = YES;
        _serviceTableView.separatorColor = [UIColor purpleColor];
        _serviceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _serviceTableView;
}

- (UITableView *)storeTableView{
    if (!_storeTableView) {
        _storeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 777 * ViewRateBaseOnIP6 - 64 ) style:UITableViewStylePlain];
        _storeTableView.delegate = self;
        _storeTableView.dataSource = self;
        _storeTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _storeTableView.showsVerticalScrollIndicator = NO;
        _storeTableView.bounces = YES;
        _storeTableView.separatorColor = [UIColor purpleColor];
        _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _storeTableView;
}

- (UIView *)viewBear{
    if (!_viewBear) {
        _viewBear = [[UIView alloc] initWithFrame:CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180)];
    }
    return _viewBear;
}

- (UIView *)viewLastY{
    if (!_viewLastY) {
        _viewLastY = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 180 * ViewRateBaseOnIP6)];
        _viewLastY.backgroundColor = [UIColor whiteColor];
    }
    return _viewLastY;
}

- (UIView *)viewPriceRecord{
    if (!_viewPriceRecord) {
        _viewPriceRecord = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 180 * ViewRateBaseOnIP6)];
        _viewPriceRecord.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _viewPriceRecord;
}

- (UIView *)viewSegment{
    if (!_viewSegment) {
        _viewSegment = [[UIView alloc] initWithFrame:CGRectMake(0, 180 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
        _viewSegment.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    }
    return _viewSegment;
}


@end
