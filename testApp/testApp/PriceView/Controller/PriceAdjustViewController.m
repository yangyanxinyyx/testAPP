//
//  PriceAdjustViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//  调整报价

#import "PriceAdjustViewController.h"
#import "PriceInspectViewController.h"
#import "PriceAdjustTableViewCell.h"
#import "PriceAdjustSureTableViewCell.h"
#import "SelectStateView.h"
#import "PriceInfoModel.h"
#import "priceModel.h"
@interface PriceAdjustViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,PriceAdjustSureTableViewCellDelegate,PriceAdjustTableViewCellDeleagte,SelectStateViewDelegate>
{
    BOOL isRequstsz;
    BOOL isRequstsj;
    BOOL isRequstck;
    BOOL isRequsthh;
    BOOL isChange;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *arraysz;
@property (nonatomic, strong) NSMutableArray *arraysj;
@property (nonatomic, strong) NSMutableArray *arrayck;
@property (nonatomic, strong) NSMutableArray *arrayhh;

@end

@implementation PriceAdjustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"调整报价";
    [self.view addSubview:topBar];
    [self createUI];

    
    isRequstsz = NO;
    isRequstsj = NO;
    isRequstck = NO;
    isRequsthh = NO;
    isChange = YES;
    [self requestPriceContentPolicyck];
    [self requestPriceContentPolicyhh];
    [self requestPriceContentPolicysj];
    [self requestPriceContentPolicysz];

}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -data
- (void)setData{
    
    if (!self.passArray || self.passArray.count == 0) {
        PriceInfoModel *jqModel = [[PriceInfoModel alloc] init];
        jqModel.name = @"交强险";
        jqModel.isToubao = @"Y";
        [self.dataArray addObject:jqModel];
        
        PriceInfoModel *csModel = [[PriceInfoModel alloc] init];
        csModel.name = @"机动车损险";
        csModel.isToubao = @"Y";
        csModel.isMianpei = @"N";
        [self.dataArray addObject:csModel];
    
        
        PriceInfoModel *szModel = [[PriceInfoModel alloc] init];
        szModel.name = @"第三责任险";
        szModel.isToubao = @"Y";
        szModel.isMianpei = @"N";
        szModel.model = [self.arraysz firstObject];
        [self.dataArray addObject:szModel];
        
        PriceInfoModel *sjModel = [[PriceInfoModel alloc] init];
        sjModel.name = @"司机责任险";
        sjModel.isToubao = @"Y";
        sjModel.isMianpei = @"N";
        sjModel.model = [self.arraysj firstObject];
        [self.dataArray addObject:sjModel];
        
        PriceInfoModel *ckModel = [[PriceInfoModel alloc] init];
        ckModel.name = @"乘客责任险";
        ckModel.isToubao = @"Y";
        ckModel.isMianpei = @"N";
        ckModel.model = [self.arrayck firstObject];
        [self.dataArray addObject:ckModel];
        
        PriceInfoModel *hhModel = [[PriceInfoModel alloc] init];
        hhModel.name = @"划痕险";
        hhModel.isToubao = @"Y";
        hhModel.isMianpei = @"N";
        hhModel.model = [self.arrayhh firstObject];
        [self.dataArray addObject:hhModel];
        
        PriceInfoModel *dqModel = [[PriceInfoModel alloc] init];
        dqModel.name = @"盗抢险";
        dqModel.isToubao = @"N";
        dqModel.isMianpei = @"N";
        [self.dataArray addObject:dqModel];
        
        PriceInfoModel *ssModel = [[PriceInfoModel alloc] init];
        ssModel.name = @"涉水险";
        ssModel.isToubao = @"N";
        ssModel.isMianpei = @"N";
        [self.dataArray addObject:ssModel];
    
    
        
        PriceInfoModel *zrModel = [[PriceInfoModel alloc] init];
        zrModel.name = @"自燃损失险";
        zrModel.isToubao = @"N";
        zrModel.isMianpei = @"N";
        [self.dataArray addObject:zrModel];
        
        PriceInfoModel *blModel = [[PriceInfoModel alloc] init];
        blModel.name = @"玻璃险";
        blModel.isToubao = @"N";
        blModel.isMianpei = @"N";
        priceModel *modelBL = [[priceModel alloc] init];
        modelBL.content = @"不投保";
        modelBL.value = @"0";
        blModel.model = modelBL;
        [self.dataArray addObject:blModel];
        
        PriceInfoModel *wsModel = [[PriceInfoModel alloc] init];
        wsModel.name = @"无法找到第三方";
        wsModel.isToubao = @"N";
        wsModel.isMianpei = @"N";
        [self.dataArray addObject:wsModel];
    } else {
        
        
        //    PriceInfoModel *jqModel = [self.passArray objectAtIndex:0];
        //    if ([jqModel.isMianpei isEqualToString:@"Y"]) {
        //        jqModel.isMianpei = @"1";
        //    } else {
        //        jqModel.isMianpei = @"0";
        //    }
#pragma mark 数据转化
        PriceInfoModel *szModel = [self.passArray objectAtIndex:2];
        if (![szModel.isToubao isEqualToString:@"N"] && ![szModel.isToubao isEqualToString:@"Y"]) {
            for (priceModel *priceM in self.arraysz) {
                if ([priceM.value doubleValue] == [szModel.isToubao doubleValue]) {
                    szModel.model = priceM;
                }
               
                
            }
        } else if ([szModel.isToubao isEqualToString:@"Y"] && szModel.priceValue){
            for (priceModel *priceM in self.arraysz) {
                if ([priceM.value doubleValue] == szModel.priceValue) {
                    szModel.model = priceM;
                }
            }
        } else {
            szModel.model = [self.arraysz firstObject];
        }
        
        
        PriceInfoModel *sjModel = [self.passArray objectAtIndex:3];
        if (![sjModel.isToubao isEqualToString:@"N"] && ![sjModel.isToubao isEqualToString:@"Y"]) {
            for (priceModel *priceM in self.arraysj) {
                if ([priceM.value doubleValue] == [sjModel.isToubao doubleValue]) {
                    sjModel.model = priceM;
                }
            }
            
        } else if ([sjModel.isToubao isEqualToString:@"Y"] && sjModel.priceValue){
            for (priceModel *priceM in self.arraysj) {
                if ([priceM.value doubleValue] == sjModel.priceValue) {
                    sjModel.model = priceM;
                }
            }
        } else {
            sjModel.model = [self.arraysj firstObject];
        }
        
        
        PriceInfoModel *ckModel = [self.passArray objectAtIndex:4];
        if (![ckModel.isToubao isEqualToString:@"N"] && ![ckModel.isToubao isEqualToString:@"Y"]) {
            for (priceModel *priceM in self.arrayck) {
                if ([priceM.value doubleValue] == [ckModel.isToubao doubleValue]) {
                    ckModel.model = priceM;
                }
            }
        } else if ([ckModel.isToubao isEqualToString:@"Y"] && ckModel.priceValue){
            for (priceModel *priceM in self.arrayck) {
                if ([priceM.value doubleValue] == ckModel.priceValue) {
                    ckModel.model = priceM;
                }
            }
        } else {
            ckModel.model = [self.arrayck firstObject];
        }
        
        PriceInfoModel *hhModel = [self.passArray objectAtIndex:5];
        if (![hhModel.isToubao isEqualToString:@"N"] && ![hhModel.isToubao isEqualToString:@"Y"]) {
            for (priceModel *priceM in self.arrayhh) {
                if ([priceM.value doubleValue] == [hhModel.isToubao doubleValue]) {
                    hhModel.model = priceM;
                }
            }
        } else if ([hhModel.isToubao isEqualToString:@"Y"] && hhModel.priceValue){
            for (priceModel *priceM in self.arrayhh) {
                if ([priceM.value doubleValue] == hhModel.priceValue) {
                    hhModel.model = priceM;
                }
            }
        } else {
            hhModel.model = [self.arrayhh firstObject];
        }
        
        PriceInfoModel *blModel = [self.passArray objectAtIndex:9];
        priceModel *blPriceModel = [[priceModel alloc] init];
        if ([blModel.isToubao isEqualToString:@"0"]) {
            blPriceModel.content = @"不投保";
        } else if ([blModel.isToubao isEqualToString:@"1"]) {
            blPriceModel.content = @"国产玻璃";
        } else {
            blPriceModel.content = @"进口玻璃";
        }
        blPriceModel.value = blModel.isToubao;
        blModel.model = blPriceModel;
        [self.dataArray addObjectsFromArray:self.passArray];
    }
    
}

- (void)requestPriceContentPolicysz{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"policy_sz_value",@"dictCode", nil];
    [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = response[@"data"];
            for (NSDictionary *dic in data) {
                priceModel *model = [[priceModel alloc] init];
                model.content = [dic objectForKey:@"content"];
                model.value = [dic objectForKey:@"value"];
                [self.arraysz addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isRequstsz = YES;
                [self reloadTableView];
            });
        }
    } fail:^(id error) {
        
    }];
}

- (void)requestPriceContentPolicysj{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"policy_sj_value",@"dictCode", nil];
    [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = response[@"data"];
            for (NSDictionary *dic in data) {
                priceModel *model = [[priceModel alloc] init];
                model.content = [dic objectForKey:@"content"];
                model.value = [dic objectForKey:@"value"];
                [self.arraysj addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isRequstsj = YES;
                [self reloadTableView];
            });
        }
    } fail:^(id error) {
        
    }];
}

- (void)requestPriceContentPolicyck{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"policy_ck_value",@"dictCode", nil];
    [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = response[@"data"];
            for (NSDictionary *dic in data) {
                priceModel *model = [[priceModel alloc] init];
                model.content = [dic objectForKey:@"content"];
                model.value = [dic objectForKey:@"value"];
                [self.arrayck addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isRequstck = YES;
                [self reloadTableView];
            });
        }
    } fail:^(id error) {
        
    }];
}

- (void)requestPriceContentPolicyhh{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"policy_hh_value",@"dictCode", nil];
    [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = response[@"data"];
            for (NSDictionary *dic in data) {
                priceModel *model = [[priceModel alloc] init];
                model.content = [dic objectForKey:@"content"];
                model.value = [dic objectForKey:@"value"];
                [self.arrayhh addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isRequsthh = YES;
                [self reloadTableView];
            });
        }
    } fail:^(id error) {
        
    }];
}


- (void)reloadTableView{
    if (isRequsthh && isRequstsj && isRequstck && isRequstsz) {
        [self setData];
        
        [self.myTableView reloadData];
    }
}

#pragma mark - 报价
- (void)requesetPrice{
    if (!isChange) {
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"6" forKey:@"quoteGroup"];
    [dic setObject:[UserInfoManager shareInstance].code forKey:@"CustKey"];
    [dic setObject:[UserInfoManager shareInstance].carID forKey:@"carId"];
    PriceInfoModel *csModel = [self.dataArray objectAtIndex:1];
    if ([csModel.isMianpei isEqualToString:@"Y"]) {
      [dic setObject:@"1" forKey:@"bujimianChesun"];
    } else {
      [dic setObject:@"0" forKey:@"bujimianChesun"];
    }
    if ([csModel.isToubao isEqualToString:@"投保"]) {
        [dic setObject:@"1" forKey:@"chesun"];
    } else {
        [dic setObject:@"0" forKey:@"chesun"];
    }
    
    PriceInfoModel *szModel = [self.dataArray objectAtIndex:2];
    if ([szModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianSanzhe"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianSanzhe"];
    }
//    if ([szModel.isToubao isEqualToString:@"投保"]) {
//        [dic setObject:@"1" forKey:@"sanzhe"];
//    } else {
//        [dic setObject:@"0" forKey:@"sanzhe"];
//    }
    [dic setObject:szModel.model.value forKey:@"sanzhe"];
    
    PriceInfoModel *sjModel = [self.dataArray objectAtIndex:3];
    if ([sjModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianSiji"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianSiji"];
    }
//    if ([sjModel.isToubao isEqualToString:@"投保"]) {
//        [dic setObject:@"1" forKey:@"siji"];
//    } else {
//        [dic setObject:@"0" forKey:@"siji"];
//    }
    [dic setObject:sjModel.model.value forKey:@"siji"];
    
    PriceInfoModel *ckModel = [self.dataArray objectAtIndex:4];
    if ([ckModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianChengke"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianChengke"];
    }
    //    if ([ckModel.isToubao isEqualToString:@"投保"]) {
    //        [dic setObject:@"1" forKey:@"chengke"];
    //    } else {
    //        [dic setObject:@"0" forKey:@"chengke"];
    //    }
    [dic setObject:ckModel.model.value forKey:@"chengke"];

    
    PriceInfoModel *hhModel = [self.dataArray objectAtIndex:5];
    if ([hhModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianHuahen"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianHuahen"];
    }
//    if ([hhModel.isToubao isEqualToString:@"投保"]) {
//        [dic setObject:@"1" forKey:@"sheshui"];
//    } else {
//        [dic setObject:@"0" forKey:@"sheshui"];
//    }
    [dic setObject:hhModel.model.value forKey:@"huahen"];
    

    
    PriceInfoModel *ssModel = [self.dataArray objectAtIndex:6];
    if ([ssModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianSheshui"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianSheshui"];
    }
    if ([ssModel.isToubao isEqualToString:@"投保"]) {
        [dic setObject:@"1" forKey:@"sheshui"];
    } else {
        [dic setObject:@"0" forKey:@"sheshui"];
    }
    //    [dic setObject:ssModel.model.value forKey:@"sheshui"];
    
    PriceInfoModel *dqModel = [self.dataArray objectAtIndex:7];
    if ([dqModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianDaoqiang"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianDaoqiang"];
    }
    if ([dqModel.isToubao isEqualToString:@"投保"]) {
        [dic setObject:@"1" forKey:@"daoqiang"];
    } else {
        [dic setObject:@"0" forKey:@"daoqiang"];
    }
    //    [dic setObject:dqModel.model.value forKey:@"daoqiang"];
    
    PriceInfoModel *zrModel = [self.dataArray objectAtIndex:8];
    if ([zrModel.isMianpei isEqualToString:@"Y"]) {
        [dic setObject:@"1" forKey:@"bujimianZiran"];
    } else {
        [dic setObject:@"0" forKey:@"bujimianZiran"];
    }
    if ([zrModel.isToubao isEqualToString:@"投保"]) {
        [dic setObject:@"1" forKey:@"ziran"];
    } else {
        [dic setObject:@"0" forKey:@"ziran"];
    }
    //    [dic setObject:ssModel.model.value forKey:@"sheshui"];
    
    PriceInfoModel *blModel = [self.dataArray objectAtIndex:9];
    //    if ([blModel.isMianpei isEqualToString:@"Y"]) {
    //        [dic setObject:@"1" forKey:@"bujimianSheshui"];
    //    } else {
    //        [dic setObject:@"0" forKey:@"bujimianSheshui"];
    //    }
    
    if ([blModel.isToubao isEqualToString:@"投保"]) {
        [dic setObject:@"1" forKey:@"boli"];
    } else  {
        [dic setObject:@"0" forKey:@"boli"];
    }
    if ([blModel.isToubao isEqualToString:@"Y"]){
        [dic setObject:[NSString stringWithFormat:@"%f",blModel.priceValue] forKey:@"boli"];

        
    } else {
       [dic setObject:blModel.model.value forKey:@"boli"];
    }
    
    
    PriceInfoModel *wsModel = [self.dataArray objectAtIndex:10];
    if ([wsModel.isToubao isEqualToString:@"投保"]) {
        [dic setObject:@"1" forKey:@"hcsanfang"];
    } else {
        [dic setObject:@"0" forKey:@"hcsanfang"];
    }
    //    [dic setObject:wsModel.model.value forKey:@"sheshui"];
    
    
    [RequestAPI getPriceOffer:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"]) {
            isChange = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                PriceInspectViewController *insVC = [[PriceInspectViewController alloc] init];
                PriceInfoModel *blModel = [self.dataArray objectAtIndex:9];
                if (blModel.priceValue) {
                    insVC.blType = [NSString stringWithFormat:@"%d",(int)blModel.priceValue];
                } else {
                  insVC.blType = blModel.model.value;
                }
                insVC.route = @"0";
                [self.navigationController pushViewController:insVC animated:YES];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"报价失败%@",response[@"erromsg"]] complete:^{
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
                
            });
            
        }
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"报价失败%@",error] complete:^{
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            
        });
    }];
}
#pragma mark - view delegate
- (void)didSelectCell:(NSString *)data count:(NSInteger)count priceCount:(NSInteger)priceCount{
    if (count >= 2 && count <= 5){
        PriceInfoModel *modle = [self.dataArray objectAtIndex:count];
        priceModel *priceM;
        if (count == 2) {
            priceM = [self.arraysz objectAtIndex:priceCount];
        } else if (count == 3) {
            priceM = [self.arraysj objectAtIndex:priceCount];
        } else if (count == 4) {
            priceM = [self.arrayck objectAtIndex:priceCount];
        } else {
            priceM = [self.arrayhh objectAtIndex:priceCount];
        }
        if (![modle.model.content isEqualToString:priceM.content]) {
            isChange = YES;
        }
        if (priceCount == 0) {
            modle.isToubao = @"N";
            modle.isMianpei = @"N";
        } else {
            modle.isToubao = @"Y";
        }
        modle.model = priceM;
        [self.myTableView reloadData];
    } else {
        if (count == 9) {
            PriceInfoModel *modle = [self.dataArray objectAtIndex:count];
            if (![modle.model.content isEqualToString:data]) {
                isChange = YES;
            }
            modle.model.content = data;
            if ([data isEqualToString:@"不投保"]) {
                modle.model.value = @"0";
                modle.isToubao = @"N";
                modle.isMianpei = @"N";
            } else if ([data isEqualToString:@"国产玻璃"]){
                modle.model.value = @"1";
                modle.isToubao = @"Y";
            } else {
                modle.model.value = @"2";
                modle.isToubao = @"Y";
            }
            
            [self.myTableView reloadData];
            return;
        }
        PriceInfoModel *model = [self.dataArray objectAtIndex:count];
        if ([data isEqualToString:@"投保"]) {
            if ([model.isToubao isEqualToString:@"N"]) {
                isChange = YES;
            }
            model.isToubao = @"Y";
        } else {
            if ([model.isToubao isEqualToString:@"Y"]) {
                isChange = YES;
            }
            model.isToubao = @"N";
        }
        if ([data isEqualToString:@"不投保"]) {
            model.isMianpei = @"N";
        }
        [self.myTableView reloadData];
    }
    
}

#pragma mark - cell delegate
- (void)confirmAdjustmentPrice{
    NSLog(@"确认");
    [self requesetPrice];
}

- (void)getFranchiseState:(BOOL)state count:(NSInteger)count{
    
    PriceInfoModel *modle = [self.dataArray objectAtIndex:count];
    if ([modle.isToubao isEqualToString:@"Y"]) {
        if ((count >= 2 && count <= 5) || count == 9){
            if ([modle.model.content isEqualToString:@"不投保"]) {
                return;
            }
        } else {
            if ([modle.isToubao isEqualToString:@"N"]) {
                return;
            }
        }
        
        isChange = YES;
        if (state) {
            modle.isMianpei = @"Y";
        } else {
            modle.isMianpei = @"N";
        }
    } else {
        modle.isMianpei = @"N";
    }
    [self.myTableView reloadData];
}

- (void)openToubao:(BOOL)state count:(NSInteger)count{
    if (count >= 2 && count <= 5){
        if (count == 2) {
            NSMutableArray *array = [NSMutableArray array];
            for (priceModel *model in self.arraysz) {
                [array addObject:model.content];
            }
            SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:array];
            selectView.tag = count;
            selectView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        } else if (count == 3) {
            NSMutableArray *array = [NSMutableArray array];
            for (priceModel *model in self.arraysj) {
                [array addObject:model.content];
            }
            SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:array];
            selectView.tag = count;
            selectView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        } else if (count == 4) {
            NSMutableArray *array = [NSMutableArray array];
            for (priceModel *model in self.arrayck) {
                [array addObject:model.content];
            }
            SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:array];
            selectView.tag = count;
            selectView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        } else {
   
            NSMutableArray *array = [NSMutableArray array];
            for (priceModel *model in self.arrayhh) {
                [array addObject:model.content];
            }
            SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:array];
            selectView.tag = count;
            selectView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        }
    } else {
        if (count == 9) {
            SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:@[@"不投保",@"国产玻璃",@"进口玻璃"]];
            selectView.tag = count;
            selectView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
            return;
        } else if (count == 10){
            PriceInfoModel *model = [self.dataArray objectAtIndex:1];
            if ([model.isToubao isEqualToString:@"不投保"]) {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"请先投保车损险" complete:nil];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            } else {
                SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:@[@"不投保",@"投保"]];
                selectView.tag = count;
                selectView.delegate = self;
                [[UIApplication sharedApplication].keyWindow addSubview:selectView];
            }
        } else {
            SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:@[@"不投保",@"投保"]];
            selectView.tag = count;
            selectView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
            
        }
        
    }
    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArray.count > 0 ? 1 : 0;
    }
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count > 0 ? 2 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.row < 10) {
        static NSString *identifer = @"identifier";
        PriceAdjustTableViewCell *cell = [[PriceAdjustTableViewCell alloc] init];
        if (!cell) {
            cell = [[PriceAdjustTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.delegate = self;
        
        if (indexPath.section == 0 ) {
            PriceInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
            cell.labelName.text = model.name;
            if ([model.isToubao isEqualToString:@"Y"]) {
                cell.labelTag.text = @"投保";
            }else {
                cell.labelTag.text = @"不投保";
            }
            [cell hiddenFranchiseView:YES];
            cell.tag = indexPath.row;
            [cell selectToubaoState:NO];
        }
        if (indexPath.section == 1) {
            [cell selectToubaoState:YES];
            cell.tag = indexPath.row + 1;
            PriceInfoModel *model = [self.dataArray objectAtIndex:indexPath.row + 1];
            cell.labelName.text = model.name;
            if (indexPath.row >= 1 && indexPath.row < 5) {
                cell.labelTag.text = model.model.content;
            } else {
                if (indexPath.row == 8) {
                    cell.labelTag.text = model.model.content;
                } else {
                    if ([model.isToubao isEqualToString:@"Y"]) {
                        cell.labelTag.text = @"投保";
                    }else {
                        cell.labelTag.text = @"不投保";
                    }
                }
            }
            
            if (indexPath.row == 8 || indexPath.row == 9) {
                [cell hiddenFranchiseView:YES];
            } else{
                [cell hiddenFranchiseView:NO];
                if ([model.isMianpei isEqualToString:@"Y"]) {
                    [cell franchiseIsSelect:YES];
                } else {
                    [cell franchiseIsSelect:NO];
                }
            }
        }
        return cell;
    } else {
        static NSString *identife = @"identifierSure";
        PriceAdjustSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identife];
        if (!cell) {
            cell = [[PriceAdjustSureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identife];
        }
        cell.delegate = self;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 10) {
          return  186 * ViewRateBaseOnIP6;
        }
    }
    return 88 * ViewRateBaseOnIP6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70 * ViewRateBaseOnIP6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30  * ViewRateBaseOnIP6, 0, 200 * ViewRateBaseOnIP6, 70 * ViewRateBaseOnIP6)];
    label.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
    label.textColor = [ UIColor colorWithHexString:@"#838383"];
    if (section == 0) {
        label.text = @"交强险";
    } else {
        label.text = @"商业险调整";
    }
    
    [view addSubview:label];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70 * ViewRateBaseOnIP6;
}

#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.separatorColor = [UIColor clearColor];
    }
    return _myTableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)arraysz{
    if (!_arraysz) {
        _arraysz = [NSMutableArray array];
        priceModel *model = [[priceModel alloc] init];
        model.content = @"不投保";
        model.value = @"0";
        [_arraysz addObject:model];
    }
    return _arraysz;
}
- (NSMutableArray *)arraysj{
    if (!_arraysj) {
        _arraysj = [NSMutableArray array];
        priceModel *model = [[priceModel alloc] init];
        model.content = @"不投保";
        model.value = @"0";
        [_arraysj addObject:model];
    }
    return _arraysj;
}
- (NSMutableArray *)arrayck{
    if (!_arrayck) {
        _arrayck = [NSMutableArray array];
        priceModel *model = [[priceModel alloc] init];
        model.content = @"不投保";
        model.value = @"0";
        [_arrayck addObject:model];
    }
    return _arrayck;
}
- (NSMutableArray *)arrayhh{
    if (!_arrayhh) {
        _arrayhh = [NSMutableArray array];
        priceModel *model = [[priceModel alloc] init];
        model.content = @"不投保";
        model.value = @"0";
        [_arrayhh addObject:model];
    }
    return _arrayhh;
}

@end
