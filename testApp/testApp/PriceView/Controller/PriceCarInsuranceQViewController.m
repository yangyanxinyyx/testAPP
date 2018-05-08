//
//  PriceCarInsuranceQViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
// 车险报价

#import "PriceCarInsuranceQViewController.h"
#import "priceCIQChangeView.h"
#import "PriceCarRecordTableViewCell.h"
#import "priceCRQLastYLabelTableViewCell.h"
#import "PriceCRQLastYInfoTableViewCell.h"
#import "PriceAdjustViewController.h"
#import "PriceInspectViewController.h"
#import "PriceInfoViewController.h"
#import "CarLastYearRecodemodel.h"
#import "PriceInfoModel.h"
#import "PriceRecodeModel.h"
#import "LYZAlertView.h"
#import <MJRefresh/MJRefresh.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface PriceCarInsuranceQViewController ()<UITableViewDelegate,UITableViewDataSource,priceCIQChangeViewDelegate,BaseNavigationBarDelegate>
@property (nonatomic, strong) priceCIQChangeView *CIQChangeView;
@property (nonatomic, strong) UIView *viewBear;
@property (nonatomic, strong) UIView *viewLastY;
@property (nonatomic, strong) UIView *viewPriceRecord;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UITableView *tableViewlast;
@property (nonatomic, strong) UIView *viewSegmentation;
@property (nonatomic, strong) UIButton *buttonRevisePrice;
@property (nonatomic, strong) UIButton *buttonPrice;
@property (nonatomic, strong) UIView *viewSegment;
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) NSMutableDictionary *networkDic;
@property (nonatomic, assign) NSInteger requestCount; //请求次数
@property (nonatomic, strong) NSMutableArray *arrayLasetData;
@property (nonatomic, strong) NSMutableArray *arrayPriceRecodeData;
@property (nonatomic, assign) BOOL isFirstRequestPriceRecode;
@property (nonatomic, strong) NSMutableArray *arrayRecodeData;
@property (nonatomic, strong) NSMutableArray *arrayAllRecodeData;
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

@property (nonatomic, strong) UIView *viewRequestFailed;
@property (nonatomic, strong) UIView *viewDataEmpty;

@end

@implementation PriceCarInsuranceQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _requestCount = 0;
    _isFirstRequestPriceRecode = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"车险报价";
    [self.view addSubview:topBar];
    [self createUI];
    [self requestLastYearPrcie];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _isFirstRequestPriceRecode = NO;

    
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [_viewBear removeFromSuperview];
        _viewBear = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark- network

- (void)requestLastYearPrcie{
    
    [self.networkDic setObject:self.carID forKey:@"carId"];
    [self.networkDic setObject:[UserInfoManager shareInstance].code forKey:@"CustKey"];
    [self.networkDic setObject:@"1" forKey:@"appType"];
    [RequestAPI getLastYearPriceRecord:self.networkDic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
            _viewRequestFailed.hidden = YES;
            NSDictionary *data = response[@"data"];
            PriceInfoModel *jqModel = [[PriceInfoModel alloc] init];
            jqModel.name = @"交强险";

            NSNumber *jiaoqiangtoubao = [data objectForKey:@"jiaoqiang"];
            if (![jiaoqiangtoubao isKindOfClass:[NSNull class]]) {
                if ([jiaoqiangtoubao doubleValue] == 0) {
                    jqModel.isToubao = @"N";
                } else if ([jiaoqiangtoubao doubleValue] == 1) {
                    jqModel.isToubao = @"Y";
                }
            }
            jqModel.isMianpei = @"N";
            [self.arrayLasetData addObject:jqModel];
            
            PriceInfoModel *chesunModel = [[PriceInfoModel alloc] init];
            chesunModel.name = @"机动车损险";
            NSNumber *bujimianChesun = [data objectForKey:@"bujimianChesun"];
            if (![bujimianChesun isKindOfClass:[NSNull class]]) {
                NSInteger bujimianChesunValue = [bujimianChesun intValue];
                if (bujimianChesunValue == 0) {
                    chesunModel.isMianpei = @"N";
                } else {
                    chesunModel.isMianpei = @"Y";
                }
                
            }
            NSNumber *chesuntoubao = [data objectForKey:@"chesun"];
            if (![chesuntoubao isKindOfClass:[NSNull class]]) {
                if ([chesuntoubao doubleValue] == 0) {
                    chesunModel.isToubao = @"N";
                } else if ([chesuntoubao doubleValue] == 1) {
                    chesunModel.isToubao = @"Y";
                } else {
                    chesunModel.isToubao = [NSString stringWithFormat:@"%0.2f",[chesuntoubao doubleValue]];
                }
                
            }
            [self.arrayLasetData addObject:chesunModel];
            
            
            PriceInfoModel *sanzheModel = [[PriceInfoModel alloc] init];
            sanzheModel.name = @"第三责任险";
            NSNumber *bujimianSanzhe = [data objectForKey:@"bujimianSanzhe"];
            if (![bujimianSanzhe isKindOfClass:[NSNull class]]) {
                if ([bujimianSanzhe intValue] == 0) {
                    sanzheModel.isMianpei = @"N";
                } else {
                    sanzheModel.isMianpei = @"Y";
                }
            }
            NSNumber *sanzhe = [data objectForKey:@"sanzhe"];
            if (![sanzhe isKindOfClass:[NSNull class]]) {
                if ([sanzhe doubleValue] == 0) {
                    sanzheModel.isToubao = @"N";
                } else if ([sanzhe doubleValue] == 1) {
                    sanzheModel.isToubao = @"Y";
                } else {
                    sanzheModel.isToubao = [NSString stringWithFormat:@"%0.2f",[sanzhe doubleValue]];
                }
            }
            [self.arrayLasetData addObject:sanzheModel];
            
            PriceInfoModel *sijiModel = [[PriceInfoModel alloc] init];
            sijiModel.name = @"司机责任险";
            NSNumber *bujimianSiji = [data objectForKey:@"bujimianSiji"];
            if (![bujimianSiji isKindOfClass:[NSNull class]]) {
                if ([bujimianSiji intValue] == 0) {
                    sijiModel.isMianpei = @"N";
                } else {
                    sijiModel.isMianpei = @"Y";
                }
            }
            NSNumber *sijibao = [data objectForKey:@"siji"];
            if (![sijibao isKindOfClass:[NSNull class]]) {
                if ([sijibao doubleValue] == 0) {
                    sijiModel.isToubao = @"N";
                } else if ([sijibao doubleValue] == 1) {
                    sijiModel.isToubao = @"Y";
                } else {
                    sijiModel.isToubao = [NSString stringWithFormat:@"%0.2f",[sijibao doubleValue]];
                }
            }
            [self.arrayLasetData addObject:sijiModel];
            
            PriceInfoModel *chengkeModel = [[PriceInfoModel alloc] init];
            chengkeModel.name = @"乘客责任险";
            NSNumber *bujimianChengke = [data objectForKey:@"bujimianChengke"];
            if (![bujimianChengke isKindOfClass:[NSNull class]]) {
                if ([bujimianChengke intValue] == 0) {
                    chengkeModel.isMianpei = @"N";
                } else {
                    chengkeModel.isMianpei = @"Y";
                }
            }
            NSNumber *chengke = [data objectForKey:@"chengke"];
            if (![chengke isKindOfClass:[NSNull class]]) {
                if ([chengke doubleValue] == 0) {
                    chengkeModel.isToubao = @"N";
                } else if ([sijibao doubleValue] == 1) {
                    chengkeModel.isToubao = @"Y";
                } else {
                    chengkeModel.isToubao = [NSString stringWithFormat:@"%0.2f",[chengke doubleValue]];
                }
            }
            [self.arrayLasetData addObject:chengkeModel];
            
            PriceInfoModel *huahenModel = [[PriceInfoModel alloc] init];
            huahenModel.name = @"划痕损失险";
            NSNumber *bujimianHuahen = [data objectForKey:@"bujimianHuahen"];
            if (![bujimianHuahen isKindOfClass:[NSNull class]]) {
                if ([bujimianHuahen intValue] == 0) {
                    huahenModel.isMianpei = @"N";
                } else {
                    huahenModel.isMianpei = @"Y";
                }
            }
            NSNumber *huahen = [data objectForKey:@"huahen"];
            if (![huahen isKindOfClass:[NSNull class]]) {
                if ([huahen doubleValue] == 0) {
                    huahenModel.isToubao = @"N";
                } else if ([huahen doubleValue] == 1) {
                    huahenModel.isToubao = @"Y";
                } else {
                    huahenModel.isToubao = [NSString stringWithFormat:@"%0.2f",[huahen doubleValue]];
                }
            }
            [self.arrayLasetData addObject:huahenModel];
            
            PriceInfoModel *daoqiangModel = [[PriceInfoModel alloc] init];
            daoqiangModel.name = @"全车盗抢险";
            NSNumber *bujimianDaoqiang = [data objectForKey:@"bujimianDaoqiang"];
            if (![bujimianDaoqiang isKindOfClass:[NSNull class]]) {
                if ([bujimianDaoqiang intValue] == 0) {
                    daoqiangModel.isMianpei = @"N";
                } else {
                    daoqiangModel.isMianpei = @"Y";
                }
                
            }
            NSNumber *daoqiang = [data objectForKey:@"daoqiang"];
            if (![daoqiang isKindOfClass:[NSNull class]]) {
                if ([daoqiang doubleValue] == 0) {
                    daoqiangModel.isToubao = @"N";
                } else if ([daoqiang doubleValue] == 1) {
                    daoqiangModel.isToubao = @"Y";
                } else {
                    daoqiangModel.isToubao = [NSString stringWithFormat:@"%0.2f",[daoqiang doubleValue]];
                }
            }
            [self.arrayLasetData addObject:daoqiangModel];
            
            PriceInfoModel *sheshuiModel = [[PriceInfoModel alloc] init];
            sheshuiModel.name = @"涉水损失险 ";
            NSNumber *bujimianSheshui = [data objectForKey:@"bujimianSheshui"];
            if (![bujimianSheshui isKindOfClass:[NSNull class]]) {
                if ([bujimianSheshui intValue] == 0) {
                    sheshuiModel.isMianpei = @"N";
                } else {
                    sheshuiModel.isMianpei = @"Y";
                }
            }
            NSNumber *sheshui = [data objectForKey:@"sheshui"];
            if (![sheshui isKindOfClass:[NSNull class]]) {
                if ([sheshui doubleValue] == 0) {
                    sheshuiModel.isToubao = @"N";
                } else if ([sheshui doubleValue] == 1) {
                    sheshuiModel.isToubao = @"Y";
                } else {
                    sheshuiModel.isToubao = [NSString stringWithFormat:@"%0.2f",[sheshui doubleValue]];
                }
            }
            [self.arrayLasetData addObject:sheshuiModel];
            
            PriceInfoModel *ziranModel = [[PriceInfoModel alloc] init];
            ziranModel.name = @"自燃损失险";
            NSNumber *bujimianZiran = [data objectForKey:@"bujimianZiran"];
            if (![bujimianZiran isKindOfClass:[NSNull class]]) {
                if ([bujimianZiran intValue] == 0) {
                    ziranModel.isMianpei = @"N";
                } else {
                    ziranModel.isMianpei = @"Y";
                }
            }
            NSNumber *ziran = [data objectForKey:@"ziran"];
            if (![ziran isKindOfClass:[NSNull class]]) {
                if ([ziran doubleValue] == 0) {
                    ziranModel.isToubao = @"N";
                } else if ([ziran doubleValue] == 1) {
                    ziranModel.isToubao = @"Y";
                } else {
                    ziranModel.isToubao = [NSString stringWithFormat:@"%0.2f",[ziran doubleValue]];
                }
            }
            [self.arrayLasetData addObject:ziranModel];
            
            PriceInfoModel *boliModel = [[PriceInfoModel alloc] init];
            boliModel.name = @"玻璃破碎险";
            boliModel.isMianpei = @"N";
            NSNumber *boli = [data objectForKey:@"boli"];
            if (![boli isKindOfClass:[NSNull class]]) {
                if ([boli doubleValue] == 0) {
                    boliModel.isToubao = @"0";
                    
                } else if ([boli doubleValue] == 1) {
                    boliModel.isToubao = @"1";
                } else {
                    boliModel.isToubao = @"2";
                }
                boliModel.priceValue = [boli doubleValue];
            }
            [self.arrayLasetData addObject:boliModel];
            
            PriceInfoModel *hcsanfangModel = [[PriceInfoModel alloc] init];
            hcsanfangModel.name = @"无法找到三方";
            hcsanfangModel.isMianpei = @"N";
            NSNumber *hcsanfang = [data objectForKey:@"hcsanfang"];
            if (![hcsanfang isKindOfClass:[NSNull class]]) {
                if ([hcsanfang doubleValue] == 0) {
                    hcsanfangModel.isToubao = @"N";
                } else if ([hcsanfang doubleValue] == 1) {
                    hcsanfangModel.isToubao = @"Y";
                } else {
                    hcsanfangModel.isToubao = [NSString stringWithFormat:@"%0.2f",[hcsanfang doubleValue]];
                }
            }
            [self.arrayLasetData addObject:hcsanfangModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableViewlast reloadData];
            });
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_requestCount == 3) {
                    _requestCount = 0;
                    FinishTipsView *finshTV = [[FinishTipsView alloc] initWithTitle:@"请求上年续保报价失败" complete:^{
                        
                    }];
                    [[UIApplication sharedApplication].keyWindow addSubview:finshTV];
                    _viewRequestFailed.hidden = NO;
                    return ;
                }
                _requestCount ++;
                [self requestLastYearPrcie];
            });
            
        }
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_requestCount == 3) {
                _requestCount = 0;
                FinishTipsView *finshTV = [[FinishTipsView alloc] initWithTitle:@"请求上年续保报价失败" complete:^{
                    
                }];
                _viewRequestFailed.hidden = NO;
                [[UIApplication sharedApplication].keyWindow addSubview:finshTV];
                return ;
            }
            _requestCount ++;
            [self requestLastYearPrcie];
        });
    }];
}

//报价记录
- (void)requestPriceRecode{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.customerId forKey:@"customerId"];
    [dic setObject:self.carID forKey:@"carId"];
    [dic setObject:@"10" forKey:@"PageSize"];
    [dic setObject:@"1" forKey:@"PageIndex"];
    
    self.myTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [RequestAPI getPriceRecord:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        
        if (response[@"data"]) {
            NSLog(@"%@",response[@"data"]);
            NSDictionary *dic = response[@"data"];
            _viewDataEmpty.hidden = YES;
            for (NSDictionary *data in dic[@"dataSet"]) {
                NSMutableArray *dataArray = [NSMutableArray array];
                NSMutableArray *allDataArray = [NSMutableArray array];
                PriceInfoModel *jqModel = [[PriceInfoModel alloc] init];
                jqModel.name = @"交强险";
                NSNumber *jqIsSelect = [data objectForKey:@"jqIsSelect"];
                if (![jqIsSelect isKindOfClass:[NSNull class]]) {
                    jqModel.isToubao = [data objectForKey:@"jqIsSelect"];
                }
                NSNumber *jqBaoFei = [data objectForKey:@"offerTciPrice"];
                if (![jqBaoFei isKindOfClass:[NSNull class]]) {
                    jqModel.number = [jqBaoFei doubleValue];
                }
                [dataArray addObject:jqModel];
                [allDataArray addObject:jqModel];
                
                
                //车损险
                PriceInfoModel *csModel = [[PriceInfoModel alloc] init];
                csModel.name = @"车损险";
                NSNumber *csIsSelect = [data objectForKey:@"csIsSelect"];
                if (![csIsSelect isKindOfClass:[NSNull class]]) {
                    csModel.isToubao = [data objectForKey:@"csIsSelect"];
                }
                NSNumber *csBaoFei = [data objectForKey:@"csBaoFei"];
                if (![csBaoFei isKindOfClass:[NSNull class]]) {
                    csModel.number = [csBaoFei doubleValue];
                }
                NSNumber *csWithout = [data objectForKey:@"csWithout"];
                if (![csWithout isKindOfClass:[NSNull class]]) {
                    csModel.isMianpei = [data objectForKey:@"csWithout"];
                }
                NSNumber *csValue = [data objectForKey:@"csValue"];
                if (![csValue isKindOfClass:[NSNull class]]) {
                    csModel.priceValue = [csValue doubleValue];
                }
                if ([csModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:csModel];
                }
                [allDataArray addObject:csModel];
                
                //第三者险
                PriceInfoModel *szModel = [[PriceInfoModel alloc] init];
                szModel.name = @"三者险";
                NSNumber *szIsSelect = [data objectForKey:@"szIsSelect"];
                if (![szIsSelect isKindOfClass:[NSNull class]]) {
                    szModel.isToubao = [data objectForKey:@"szIsSelect"];
                }
                NSNumber *szBaoFei = [data objectForKey:@"szBaoFei"];
                if (![szBaoFei isKindOfClass:[NSNull class]]) {
                    szModel.number = [szBaoFei doubleValue];
                }
                NSNumber *szWithout = [data objectForKey:@"szWithout"];
                if (![szWithout isKindOfClass:[NSNull class]]) {
                    szModel.isMianpei = [data objectForKey:@"szWithout"];
                }
                NSNumber *szValue = [data objectForKey:@"szValue"];
                if (![szValue isKindOfClass:[NSNull class]]) {
                    szModel.priceValue = [szValue doubleValue];
                }
                if ([szModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:szModel];
                }
                [allDataArray addObject:szModel];
                
                
                
                //车上司机险
                PriceInfoModel *cssjModel = [[PriceInfoModel alloc] init];
                cssjModel.name = @"车上司机险";
                NSNumber *cssjIsSelect = [data objectForKey:@"cssjIsSelect"];
                if (![cssjIsSelect isKindOfClass:[NSNull class]]) {
                    cssjModel.isToubao = [data objectForKey:@"cssjIsSelect"];
                }
                NSNumber *cssjBaoFei = [data objectForKey:@"cssjBaoFei"];
                if (![cssjBaoFei isKindOfClass:[NSNull class]]) {
                    cssjModel.number = [cssjBaoFei doubleValue];
                }
                NSNumber *cssjWithout = [data objectForKey:@"cssjWithout"];
                if (![cssjWithout isKindOfClass:[NSNull class]]) {
                    cssjModel.isMianpei = [data objectForKey:@"cssjWithout"];
                }
                NSNumber *cssjValue = [data objectForKey:@"cssjValue"];
                if (![cssjValue isKindOfClass:[NSNull class]]) {
                    cssjModel.priceValue = [cssjValue doubleValue];
                }
                if ([cssjModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:cssjModel];
                }
                [allDataArray addObject:cssjModel];
                
                
                //车上乘客险
                PriceInfoModel *csckModel = [[PriceInfoModel alloc] init];
                csckModel.name = @"车上乘客险";
                NSNumber *csckIsSelect = [data objectForKey:@"csckIsSelect"];
                if (![csckIsSelect isKindOfClass:[NSNull class]]) {
                    csckModel.isToubao = [data objectForKey:@"csckIsSelect"];
                }
                NSNumber *csckBaoFei = [data objectForKey:@"csckBaoFei"];
                if (![csckBaoFei isKindOfClass:[NSNull class]]) {
                    csckModel.number = [csckBaoFei doubleValue];
                }
                NSNumber *csckWithout = [data objectForKey:@"csckWithout"];
                if (![csckWithout isKindOfClass:[NSNull class]]) {
                    csckModel.isMianpei = [data objectForKey:@"csckWithout"];
                }
                NSNumber *csckValue = [data objectForKey:@"csckValue"];
                if (![csckValue isKindOfClass:[NSNull class]]) {
                    csckModel.priceValue = [csckValue doubleValue];
                }
                if ([csckModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:csckModel];
                }
                [allDataArray addObject:csckModel];
                
                
                
                //车身划痕险
                PriceInfoModel *cshhModel = [[PriceInfoModel alloc] init];
                cshhModel.name = @"车身划痕险";
                NSNumber *cshhIsSelect = [data objectForKey:@"cshhIsSelect"];
                if (![cshhIsSelect isKindOfClass:[NSNull class]]) {
                    cshhModel.isToubao = [data objectForKey:@"cshhIsSelect"];
                }
                NSNumber *cshhBaoFei = [data objectForKey:@"cshhBaoFei"];
                if (![cshhBaoFei isKindOfClass:[NSNull class]]) {
                    cshhModel.number = [cshhBaoFei doubleValue];
                }
                NSNumber *cshhWithout = [data objectForKey:@"cshhWithout"];
                if (![cshhWithout isKindOfClass:[NSNull class]]) {
                    cshhModel.isMianpei = [data objectForKey:@"cshhWithout"];
                }
                NSNumber *cshhValue = [data objectForKey:@"cshhValue"];
                if (![cshhValue isKindOfClass:[NSNull class]]) {
                    cshhModel.priceValue = [cshhValue doubleValue];
                }
                if ([cshhModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:cshhModel];
                }
                [allDataArray addObject:cshhModel];
                
                //盗抢险
                PriceInfoModel *dqModel = [[PriceInfoModel alloc] init];
                dqModel.name = @"盗抢险";
                NSNumber *dqIsSelect = [data objectForKey:@"dqIsSelect"];
                if (![dqIsSelect isKindOfClass:[NSNull class]]) {
                    dqModel.isToubao = [data objectForKey:@"dqIsSelect"];
                }
                NSNumber *dqBaoFei = [data objectForKey:@"dqBaoFei"];
                if (![dqBaoFei isKindOfClass:[NSNull class]]) {
                    dqModel.number = [dqBaoFei doubleValue];
                }
                NSNumber *dqWithout = [data objectForKey:@"dqWithout"];
                if (![dqWithout isKindOfClass:[NSNull class]]) {
                    dqModel.isMianpei = [data objectForKey:@"dqWithout"];
                }
                NSNumber *dqValue = [data objectForKey:@"dqValue"];
                if (![dqValue isKindOfClass:[NSNull class]]) {
                    dqModel.priceValue = [dqValue doubleValue];
                }
                if ([dqModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:dqModel];
                }
                [allDataArray addObject:dqModel];
                
                //发动机涉水险
                PriceInfoModel *fdjsModel = [[PriceInfoModel alloc] init];
                fdjsModel.name = @"发动机涉水险";
                NSNumber *fdjssIsSelect = [data objectForKey:@"fdjssIsSelect"];
                if (![fdjssIsSelect isKindOfClass:[NSNull class]]) {
                    fdjsModel.isToubao = [data objectForKey:@"fdjssIsSelect"];
                }
                NSNumber *fdjssBaoFei = [data objectForKey:@"fdjssBaoFei"];
                if (![fdjssBaoFei isKindOfClass:[NSNull class]]) {
                    fdjsModel.number = [fdjssBaoFei doubleValue];
                }
                NSNumber *fdjssWithout = [data objectForKey:@"fdjssWithout"];
                if (![fdjssWithout isKindOfClass:[NSNull class]]) {
                    fdjsModel.isMianpei = [data objectForKey:@"fdjssWithout"];
                }
                NSNumber *fdjssValue = [data objectForKey:@"fdjssValue"];
                if (![fdjssValue isKindOfClass:[NSNull class]]) {
                    fdjsModel.priceValue = [fdjssValue doubleValue];
                }
                if ([fdjsModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:fdjsModel];
                }
                [allDataArray addObject:fdjsModel];
                
                //自燃险
                PriceInfoModel *zrModel = [[PriceInfoModel alloc] init];
                zrModel.name = @"自然险";
                NSNumber *zrxIsSelect = [data objectForKey:@"zrxIsSelect"];
                if (![zrxIsSelect isKindOfClass:[NSNull class]]) {
                    zrModel.isToubao = [data objectForKey:@"zrxIsSelect"];
                }
                NSNumber *zrxBaoFei = [data objectForKey:@"fdjssBaoFei"];
                if (![zrxBaoFei isKindOfClass:[NSNull class]]) {
                    zrModel.number = [zrxBaoFei doubleValue];
                }
                NSNumber *zrxWithout = [data objectForKey:@"zrxWithout"];
                if (![zrxWithout isKindOfClass:[NSNull class]]) {
                    zrModel.isMianpei = [data objectForKey:@"zrxWithout"];
                }
                NSNumber *zrxValue = [data objectForKey:@"zrxValue"];
                if (![zrxValue isKindOfClass:[NSNull class]]) {
                    zrModel.priceValue = [zrxValue doubleValue];
                }
                if ([zrModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:zrModel];
                }
                [allDataArray addObject:zrModel];
                
                // 玻璃险
                PriceInfoModel *blModel = [[PriceInfoModel alloc] init];
                blModel.name = @"玻璃险";
                NSNumber *blpsIsSelect = [data objectForKey:@"blpsIsSelect"];
                if (![blpsIsSelect isKindOfClass:[NSNull class]]) {
                    blModel.isToubao = [data objectForKey:@"blpsIsSelect"];
                }
                NSNumber *blpsBaoFei = [data objectForKey:@"blpsBaoFei"];
                if (![blpsBaoFei isKindOfClass:[NSNull class]]) {
                    blModel.number = [blpsBaoFei doubleValue];
                }
                NSNumber *blValue = [data objectForKey:@"blpsValue"];
                if (![blValue isKindOfClass:[NSNull class]]) {
                    blModel.priceValue = [blValue doubleValue];
                }
                if ([blModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:blModel];
                }
                [allDataArray addObject:blModel];
                
                //无第三方险
                PriceInfoModel *wfModel = [[PriceInfoModel alloc] init];
                wfModel.name = @"无第三方险";
                NSNumber *wfzddsfIsSelect = [data objectForKey:@"wfzddsfIsSelect"];
                if (![wfzddsfIsSelect isKindOfClass:[NSNull class]]) {
                    wfModel.isToubao = [data objectForKey:@"wfzddsfIsSelect"];
                }
                NSNumber *wfzddsfBaoFei = [data objectForKey:@"wfzddsfBaoFei"];
                if (![wfzddsfBaoFei isKindOfClass:[NSNull class]]) {
                    wfModel.number = [wfzddsfBaoFei doubleValue];
                }
                if ([wfModel.isToubao isEqualToString:@"Y"]) {
                    [dataArray addObject:wfModel];
                }
                [allDataArray addObject:wfModel];
               
                //                NSNumber *bussice = [data objectForKey:@"syBaoFei"];
                //                if (![bussice isKindOfClass:[NSNull class]]) {
                //                    _syBaoFei = [bussice doubleValue];
                //                }
                PriceRecodeModel *recodeModel = [[PriceRecodeModel alloc] init];
                recodeModel.offerName = [data objectForKey:@"offerName"];
                recodeModel.offerTime = [data objectForKey:@"offerTime"];
                NSNumber *offerTotalPrice = [data objectForKey:@"offerTotalPrice"];
                if (![offerTotalPrice isKindOfClass:[NSNull class]]) {
                    recodeModel.offerTotalPrice = [offerTotalPrice doubleValue];
                }
                NSNumber *offerVciPrice = [data objectForKey:@"offerVciPrice"];
                if (![offerVciPrice isKindOfClass:[NSNull class]]) {
                    recodeModel.offerVciPrice = [offerVciPrice doubleValue];
                }
                NSNumber *poSource = [data objectForKey:@"poSource"];
                if (![poSource isKindOfClass:[NSNull class]]) {
                    recodeModel.quoteGroup = [data objectForKey:@"poSource"];
                }
            
                if (![blValue isKindOfClass:[NSNull class]]) {
                    recodeModel.blType = [data objectForKey:@"blpsValue"];;
                }
                
                NSNumber *priceRecodeID = [data objectForKey:@"id"];
                if (![priceRecodeID isKindOfClass:[NSNull class]]) {
                    recodeModel.priceRecodeID = [NSString stringWithFormat:@"%ld",[priceRecodeID longValue]] ;
                }
                
                [self.arrayRecodeData addObject:recodeModel];
                [self.arrayPriceRecodeData addObject:dataArray];
                [self.arrayAllRecodeData addObject:allDataArray];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.arrayRecodeData.count == 0) {
                    _viewDataEmpty.hidden = NO;
                    self.myTableView.backgroundColor = [UIColor clearColor];
                } else {
                  self.myTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
                }
               [self.myTableView reloadData];
                
            });
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                _viewDataEmpty.hidden = NO;
                self.myTableView.backgroundColor = [UIColor clearColor];
        
            });
        }
    } fail:^(id error) {
        NSLog(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.arrayRecodeData.count == 0) {
                _viewDataEmpty.hidden = NO;
                self.myTableView.backgroundColor = [UIColor clearColor];
            }
            [self.myTableView reloadData];
        });
    }];
}

#pragma mark - function
//调整报价
- (void)touchButtonRevisePrice:(UIButton *)button{
    PriceAdjustViewController *priceAdjuestVC = [[PriceAdjustViewController alloc]init];
    priceAdjuestVC.passArray = self.arrayLasetData;
    [self.navigationController pushViewController:priceAdjuestVC animated:YES];
}

//报价
- (void)touchButtonPrice:(UIButton *)button{
    PriceInspectViewController *priceInsVC = [[PriceInspectViewController alloc] init];
    priceInsVC.route = @"1";
    [self.navigationController pushViewController:priceInsVC animated:YES];
}

- (void)refresh{
    _isFirstRequestPriceRecode = YES;
    [self.arrayRecodeData removeAllObjects];
    [self.arrayPriceRecodeData removeAllObjects];
    [self.arrayAllRecodeData removeAllObjects];
    [self requestPriceRecode];
    [self.myTableView.mj_header endRefreshing];
    
}
#pragma  mark - view delegate
- (void)changeModel:(BOOL)isLaseY{
    if (isLaseY) {
        self.viewLastY.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
         self.viewBear.frame = CGRectMake(0, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
        }];
        
        
    } else {
        self.viewLastY.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.viewBear.frame = CGRectMake(-SCREEN_WIDTH, 180 * ViewRateBaseOnIP6, 2 * SCREEN_WIDTH, SCREEN_HEIGHT - 180);
        }];
        if (!_isFirstRequestPriceRecode) {
            _isFirstRequestPriceRecode = YES;
            [self.arrayRecodeData removeAllObjects];
            [self.arrayPriceRecodeData removeAllObjects];
            [self.arrayAllRecodeData removeAllObjects];
            [self requestPriceRecode];
        }
        
    }
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableViewlast) {
        return self.arrayLasetData.count;
    } else {
        return self.arrayRecodeData.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.myTableView) {
        static NSString *identifier = @"identifier";
        PriceCarRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCarRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        PriceRecodeModel *recodeModel = [self.arrayRecodeData objectAtIndex:indexPath.row];
        cell.labelName.text = recodeModel.offerName;
        cell.labelTime.text = recodeModel.offerTime;
        cell.labelNum.text = [NSString stringWithFormat:@"报价¥%f",recodeModel.offerTotalPrice] ;
        
        return cell;
    } else {
        static NSString *identifier = @"identifierInfo";
        PriceCRQLastYInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCRQLastYInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        PriceInfoModel *lastModel = [self.arrayLasetData objectAtIndex:indexPath.row];
        
        cell.labelName.text = lastModel.name;
        if ([lastModel.name isEqualToString:@"玻璃破碎险"]) {
            if ([lastModel.isToubao isEqualToString:@"0"]) {
                cell.labelNum.text = @"不投保";
            } else if ([lastModel.isToubao isEqualToString:@"1"]){
                cell.labelNum.text = @"国产";
            } else {
                cell.labelNum.text = @"进口";
            }
        } else{
            if ([lastModel.isToubao isEqualToString:@"N"]) {
                cell.labelNum.text = @"不投保";
            } else if ([lastModel.isToubao isEqualToString:@"Y"]){
                cell.labelNum.text = @"投保";
            } else {
                cell.labelNum.text = [NSString stringWithFormat:@"%@",lastModel.isToubao];
            }
        }
        if ([lastModel.isMianpei isEqualToString:@"Y"]) {
            [cell setCellMianPei:YES];
        } else {
            [cell setCellMianPei:NO];
        }
        return cell;
    }
 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.myTableView) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10 * ViewRateBaseOnIP6)];
        view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        return view;
    } else {
        return nil;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.myTableView) {
        return 120 * ViewRateBaseOnIP6;
    } else {
        return 60 * ViewRateBaseOnIP6;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.myTableView) {
        return 10 * ViewRateBaseOnIP6;
    } else {
        return 0;
    }
}

// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    if (tableView == self.myTableView) {
        PriceInfoViewController *priceInfoVC = [[PriceInfoViewController alloc] init];
        PriceRecodeModel *recodeModel = [self.arrayRecodeData objectAtIndex:indexPath.row];
        priceInfoVC.quoteGroup = recodeModel.quoteGroup;
        priceInfoVC.blType = recodeModel.blType;
        priceInfoVC.syBaoFei = recodeModel.offerTotalPrice;
        NSMutableArray *dataArray = [self.arrayPriceRecodeData objectAtIndex:indexPath.row];
        NSMutableArray *copyDataArray = [NSMutableArray array];
        [copyDataArray addObjectsFromArray:dataArray];
        priceInfoVC.arrayRecodeData = copyDataArray;
        NSMutableArray *allDataArray = [self.arrayAllRecodeData objectAtIndex:indexPath.row];
        NSMutableArray *copyAllDataArray = [NSMutableArray array];
        [copyAllDataArray addObjectsFromArray:allDataArray];
        priceInfoVC.arrayAllRecodeData = copyAllDataArray;
        [self.navigationController pushViewController:priceInfoVC animated:YES];
    }
}


//
// =================== modify by Liangyz 删除功能03
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myTableView) {
        return YES;
    } else{
      return NO;
    }
}

//控制编辑模式 (控制删除啊 还是插入)
-(UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//控制删除  插入
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断当前是什么模式
    //如果是删除模式
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self showAlertViewWithIndepthPathCell:indexPath];
        

    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = nil;
}

- (void)viewDidLayoutSubviews{
    
    if (self.editingIndexPath)
    {
        [self configSwipeButtons];
    }


}
- (void)configSwipeButtons{
    UIButton *deleteButton = nil;
    // 获取选项按钮的reference
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0"))
    {
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.myTableView.subviews)
        {

            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")])
            {
                // 和iOS 10的按钮顺序相反
                [subview setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
                deleteButton = subview.subviews[0];
                [deleteButton setBackgroundColor:COLOR_RGB_255(0, 77, 162)];

                [self configDeleteButton:deleteButton];
            }
        }
    }
    else
    {
//         iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        PriceCarRecordTableViewCell *tableCell = [self.myTableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
            {
                deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
                [subview setBackgroundColor:COLOR_RGB_255(0, 77, 162)];

            }
        }
    }

}


- (void)configDeleteButton:(UIButton*)deleteButton
{
    if (deleteButton)
    {
        [deleteButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:COLOR_RGB_255(0, 77, 162)];

    }
}

// ===================
// =================== modify by Liangyz 删除功能 05
- (void)showAlertViewWithIndepthPathCell:(NSIndexPath*)indexpath
{
    __weak typeof (self)weakSelf = self;
    LYZAlertView *alertView = [LYZAlertView alterViewWithTitle:@"是否删除" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
        //(TODO)删除数据
        [weakSelf removeAlertView:alertView cellIndexpath:indexpath];
    }];
    [self.view addSubview:alertView];
}

- (void)removeAlertView:(LYZAlertView *)alertView cellIndexpath:(NSIndexPath *)indexpath
{
    __weak typeof (self)weakSelf = self;
    PriceRecodeModel *model = [self.arrayRecodeData objectAtIndex:indexpath.row];
    [RequestAPI getDeletePrice:@{@"id":model.priceRecodeID} header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"result"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.arrayRecodeData removeObjectAtIndex:indexpath.row];
                [weakSelf.arrayPriceRecodeData removeObjectAtIndex:indexpath.row];
                [weakSelf.arrayAllRecodeData removeObjectAtIndex:indexpath.row];
                
                //1删数组种的数据 2.在删掉cell
                [weakSelf.myTableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationRight];
                if ([alertView superview]) {
                    [alertView removeFromSuperview];
                }
                if (self.arrayRecodeData.count == 0) {
                    weakSelf.viewDataEmpty.hidden = NO;
                }
            });
        }
    } fail:^(id error) {
        
    }];
    
}


#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.contenView];
    [self.contenView addSubview:self.viewBear];
    [self.contenView addSubview:self.CIQChangeView];
    [self.viewBear addSubview:self.viewLastY];
    [self.viewBear addSubview:self.viewPriceRecord];
    [self.viewLastY addSubview:self.tableViewlast];
    [self.viewLastY addSubview:self.viewRequestFailed];
    [self.viewPriceRecord addSubview:self.viewDataEmpty];
    [self.viewPriceRecord addSubview:self.myTableView];
    [self.viewLastY addSubview:self.buttonPrice];
    [self.viewLastY addSubview:self.buttonRevisePrice];
    [self.viewLastY addSubview:self.viewSegmentation];
    [self.contenView addSubview:self.viewSegment];
}

- (UIView *)contenView{
    if (!_contenView) {
        _contenView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _contenView;
}

- (priceCIQChangeView *)CIQChangeView{
    if (!_CIQChangeView) {
        _CIQChangeView = [[priceCIQChangeView alloc] initWithFrame:CGRectMake(0, 20 * ViewRateBaseOnIP6, SCREEN_WIDTH, 160 * ViewRateBaseOnIP6)];
        _CIQChangeView.delegate = self;
    }
    return _CIQChangeView;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 268 * ViewRateBaseOnIP6) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorColor = [UIColor purpleColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    return _myTableView;
}

- (UITableView *)tableViewlast{
    if (!_tableViewlast) {
        _tableViewlast = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 800 * ViewRateBaseOnIP6 - 64 ) style:UITableViewStylePlain];
        _tableViewlast.delegate = self;
        _tableViewlast.dataSource = self;
        _tableViewlast.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _tableViewlast.showsVerticalScrollIndicator = NO;
        _tableViewlast.bounces = NO;
        _tableViewlast.separatorColor = [UIColor purpleColor];
        _tableViewlast.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableViewlast;
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
- (UIView *)viewSegmentation{
    if (!_viewSegmentation) {
        _viewSegmentation = [[UIView alloc] initWithFrame:CGRectMake(0, 757 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
        _viewSegmentation.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    }
    return _viewSegmentation;
}

- (UIButton *)buttonRevisePrice{
    if (!_buttonRevisePrice) {
        _buttonRevisePrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonRevisePrice.frame = CGRectMake(0 , 757 * ViewRateBaseOnIP6, SCREEN_WIDTH, 100 * ViewRateBaseOnIP6);
        [_buttonRevisePrice setTitle:@"修改报价方案" forState:UIControlStateNormal];
        [_buttonRevisePrice setTitleColor:[UIColor colorWithHexString:@"#6899e8"] forState:UIControlStateNormal];
        _buttonRevisePrice.titleLabel.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
        [_buttonRevisePrice addTarget:self action:@selector(touchButtonRevisePrice:) forControlEvents:UIControlEventTouchDown];
        _buttonRevisePrice.backgroundColor = [UIColor whiteColor];
    }
    return _buttonRevisePrice;
}

- (UIButton *)buttonPrice{
    if (!_buttonPrice) {
        _buttonPrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonPrice.frame = CGRectMake(30 * ViewRateBaseOnIP6, 856 * ViewRateBaseOnIP6, SCREEN_WIDTH - 60 * ViewRateBaseOnIP6, 90 * ViewRateBaseOnIP6);
        [_buttonPrice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonPrice setTitle:@"报价" forState:UIControlStateNormal];
        _buttonPrice.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
        _buttonPrice.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        _buttonPrice.layer.masksToBounds = YES;
        [_buttonPrice addTarget:self action:@selector(touchButtonPrice:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _buttonPrice;
}


- (UIView *)viewRequestFailed{
    if (!_viewRequestFailed) {
        _viewRequestFailed = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 777 * ViewRateBaseOnIP6)];
        _viewRequestFailed.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 112 * ViewRateBaseOnIP6, 112 * ViewRateBaseOnIP6)];
        imageView.center = _viewRequestFailed.center;
        imageView.image = [UIImage imageNamed:@"cry"];
        [_viewRequestFailed addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 20 * ViewRateBaseOnIP6, SCREEN_WIDTH, 24 * ViewRateBaseOnIP6)];
        label.text = @"数据加载失败, 请稍后再试";
        label.font = [UIFont systemFontOfSize:24 * ViewRateBaseOnIP6];
        label.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [_viewRequestFailed addSubview:label];
        _viewRequestFailed.hidden = YES;
    }
    
    return _viewRequestFailed;
}

- (UIView *)viewDataEmpty{
    if (!_viewDataEmpty) {
        _viewDataEmpty = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 180 * ViewRateBaseOnIP6)];
        _viewDataEmpty.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(285 * ViewRateBaseOnIP6, 270 * ViewRateBaseOnIP6, 218 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6)];
        imageView.image = [UIImage imageNamed:@"dataEmpty"];
        [_viewDataEmpty addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 40 * ViewRateBaseOnIP6, SCREEN_WIDTH, 24 * ViewRateBaseOnIP6)];
        label.text = @"暂时没查到任何数据";
        label.font = [UIFont systemFontOfSize:24 * ViewRateBaseOnIP6];
        label.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [_viewDataEmpty addSubview:label];
        _viewDataEmpty.hidden = YES;
    }
    
    return _viewDataEmpty;
}

- (NSMutableDictionary *)networkDic{
    if (!_networkDic) {
        _networkDic = [NSMutableDictionary dictionary];
    }
    return _networkDic;
}

- (NSMutableArray *)arrayLasetData{
    if (!_arrayLasetData) {
        _arrayLasetData = [NSMutableArray array];
    }
    return _arrayLasetData;
}

-(NSMutableArray *)arrayPriceRecodeData{
    if (!_arrayPriceRecodeData) {
        _arrayPriceRecodeData = [NSMutableArray array];
    }
    return _arrayPriceRecodeData;
}

- (NSMutableArray *)arrayRecodeData{
    if (!_arrayRecodeData) {
        _arrayRecodeData = [NSMutableArray array];
    }
    return _arrayRecodeData;
}

- (NSMutableArray *)arrayAllRecodeData{
    if (!_arrayAllRecodeData) {
        _arrayAllRecodeData = [NSMutableArray array];
    }
    return _arrayAllRecodeData;
}
@end
