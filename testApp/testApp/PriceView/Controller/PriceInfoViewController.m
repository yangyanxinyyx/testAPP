//
//  PriceInfoViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInfoViewController.h"
#import "PriceInfolabelTableViewCell.h"
#import "PriceCommerceInsTableViewCell.h"
#import "PriceInfoAddTableViewCell.h"
#import "PriceUnderwritingViewController.h"
#import "PriceAdjustViewController.h"
#import "PriceInfoModel.h"
#import "InputTextView.h"
@interface PriceInfoViewController ()<UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate,InputTextViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *viewDataEmpty;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) NSString *offerName;
@property (nonatomic, strong) UIView *viewBase;

@end

@implementation PriceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"报价详情";
    [self.view addSubview:topBar];
    [self createUI];
    if (self.arrayRecodeData.count > 0) {
        [self.dataArray addObjectsFromArray:self.arrayRecodeData];
        [self.arrayRecodeData removeAllObjects];
        [self.allDataArray addObjectsFromArray:self.arrayAllRecodeData];
        [self.arrayAllRecodeData removeAllObjects];
        [self.myTableView reloadData];
        
        self.route = @"1";
        _viewBase.hidden = NO;
        _viewDataEmpty.hidden = YES;
    } else {
      [self requestPrecisePrice];
    }
    
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Network
- (void)requestPrecisePrice{
    __weak typeof (self)weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.quoteGroup forKey:@"quoteGroup"];
    [dic setObject:[UserInfoManager shareInstance].code forKey:@"CustKey"];
    [dic setObject:[UserInfoManager shareInstance].carID forKey:@"carId"];
    [dic setObject:self.blType forKey:@"blType"];
    [RequestAPI getPrecisePrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = response[@"data"];
            PriceInfoModel *jqModel = [[PriceInfoModel alloc] init];
            jqModel.name = @"交强险";
            NSNumber *jqIsSelect = [data objectForKey:@"jqIsSelect"];
            if (![jqIsSelect isKindOfClass:[NSNull class]]) {
                jqModel.isToubao = [data objectForKey:@"jqIsSelect"];
            }
            NSNumber *jqBaoFei = [data objectForKey:@"jqBaoFei"];
            if (![jqBaoFei isKindOfClass:[NSNull class]]) {
                jqModel.number = [jqBaoFei doubleValue];
            }
            [weakSelf.dataArray addObject:jqModel];
            [weakSelf.allDataArray addObject:jqModel];
            
            
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
                [weakSelf.dataArray addObject:csModel];
            }
            [weakSelf.allDataArray addObject:csModel];
            
            
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
               [weakSelf.dataArray addObject:szModel];
            }
            
            [weakSelf.allDataArray addObject:szModel];
            
            
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
                [weakSelf.dataArray addObject:cssjModel];
            }
            [weakSelf.allDataArray addObject:cssjModel];
            
            
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
               [weakSelf.dataArray addObject:csckModel];
            }
            [weakSelf.allDataArray addObject:csckModel];
            
            
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
                [weakSelf.dataArray addObject:cshhModel];
            }
            [weakSelf.allDataArray addObject:cshhModel];
            
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
                [weakSelf.dataArray addObject:dqModel];
            }
            [weakSelf.allDataArray addObject:dqModel];
           
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
                [weakSelf.dataArray addObject:fdjsModel];
            }
            [weakSelf.allDataArray addObject:fdjsModel];
            
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
                [weakSelf.dataArray addObject:zrModel];
            }
            [weakSelf.allDataArray addObject:zrModel];
            
            
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
            NSNumber *blValue = [data objectForKey:@"blValue"];
            if (![blValue isKindOfClass:[NSNull class]]) {
                blModel.priceValue = [blValue doubleValue];
            }
            if ([blModel.isToubao isEqualToString:@"Y"]) {
                [weakSelf.dataArray addObject:blModel];
            }
            [weakSelf.allDataArray addObject:blModel];
            
            
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
                [weakSelf.dataArray addObject:wfModel];
            }
            [weakSelf.allDataArray addObject:wfModel];
            
            
            
            
            NSNumber *bussice = [data objectForKey:@"syBaoFei"];
            if (![bussice isKindOfClass:[NSNull class]]) {
                _syBaoFei = [bussice doubleValue];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _viewDataEmpty.hidden = YES;
                _viewBase.hidden = NO;
                [weakSelf.myTableView reloadData];
            });
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                _viewDataEmpty.hidden = NO;
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"%@",response[@"errormsg"]] complete:^{
                    [weakSelf baseNavigationDidPressCancelBtn:YES];
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            });
            
            
        }
    } fail:^(id error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            _viewDataEmpty.hidden = NO;
            [weakSelf baseNavigationDidPressCancelBtn:YES];
        });
        NSLog(@"%@",error);
    }];
}

- (void)requestSavePrice{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.quoteGroup forKey:@"poSource"];
    [dic setObject:[UserInfoManager shareInstance].customerId forKey:@"customerId"];
    [dic setObject: [NSString stringWithCString:[[UserInfoManager shareInstance].customerName UTF8String] encoding:NSUTF8StringEncoding] forKey:@"customerName"];
    [dic setObject:[UserInfoManager shareInstance].carID forKey:@"carId"];
    [dic setObject:_offerName forKey:@"offerName"];
    [dic setObject:[NSString stringWithFormat:@"%f",_syBaoFei] forKey:@"offerTciPrice"];
    
    
    //交强险
    PriceInfoModel *jqModel = [self.allDataArray firstObject];
    [dic setObject:[NSString stringWithFormat:@"%f",jqModel.number] forKey:@"offerVciPrice"];
    [dic setObject:jqModel.isToubao forKey:@"jqIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",jqModel.number + _syBaoFei] forKey:@"offerTotalPrice"]; //总金额
    //车损
    PriceInfoModel *csModel = [self.allDataArray objectAtIndex:1];
    [dic setObject:csModel.isToubao forKey:@"csIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",csModel.priceValue] forKey:@"csValue"];
    [dic setObject:csModel.isMianpei forKey:@"csWithout"];
    
    
    //第三者
    PriceInfoModel *szModel = [self.allDataArray objectAtIndex:2];
    [dic setObject:szModel.isToubao forKey:@"szIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",szModel.priceValue] forKey:@"szValue"];
    [dic setObject:szModel.isMianpei forKey:@"szWithout"];
    
    //车上司机
    PriceInfoModel *sjModel = [self.allDataArray objectAtIndex:3];
    [dic setObject:sjModel.isToubao forKey:@"cssjIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",sjModel.priceValue] forKey:@"cssjValue"];
    [dic setObject:sjModel.isMianpei forKey:@"cssjWithout"];
    
    //车上乘客
    PriceInfoModel *ckModel = [self.allDataArray objectAtIndex:4];
    [dic setObject:ckModel.isToubao forKey:@"csckIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",ckModel.priceValue] forKey:@"csckValue"];
    [dic setObject:ckModel.isMianpei forKey:@"csckWithout"];
    
    //车身划痕
    PriceInfoModel *hhModel = [self.allDataArray objectAtIndex:5];
    [dic setObject:hhModel.isToubao forKey:@"cshhIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",hhModel.priceValue] forKey:@"cshhValue"];
    [dic setObject:hhModel.isMianpei forKey:@"cshhWithout"];
    
    //盗抢
    PriceInfoModel *dqModel = [self.allDataArray objectAtIndex:6];
    [dic setObject:dqModel.isToubao forKey:@"dqIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",dqModel.priceValue] forKey:@"dqValue"];
    [dic setObject:dqModel.isMianpei forKey:@"dqWithout"];
    
    //发动机涉水险
    PriceInfoModel *fdjssModel = [self.allDataArray objectAtIndex:7];
    [dic setObject:fdjssModel.isToubao forKey:@"fdjssIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",fdjssModel.priceValue] forKey:@"fdjssValue"];
    [dic setObject:fdjssModel.isMianpei forKey:@"fdjssWithout"];
    
    //自燃险
    PriceInfoModel *zrModel = [self.allDataArray objectAtIndex:8];
    [dic setObject:zrModel.isToubao forKey:@"zrxIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",zrModel.priceValue] forKey:@"zrxValue"];
    [dic setObject:zrModel.isMianpei forKey:@"zrxWithout"];

    //玻璃
    PriceInfoModel *blModel = [self.allDataArray objectAtIndex:9];
    [dic setObject:blModel.isToubao forKey:@"blpsIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f", blModel.priceValue] forKey:@"blpsValue"];
    
    //无法找到第三方
    PriceInfoModel *wsModel = [self.allDataArray objectAtIndex:10];
    [dic setObject:wsModel.isToubao forKey:@"wfzddsfIsSelect"];
    
  

    [RequestAPI getSavePrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response[@"result"]) {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"保存成功" complete:nil];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            } else {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"保存失败:%@",response[@"errormsg"]] complete:nil];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            }
        });
        
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"保存失败:%@",error] complete:nil];
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        });
        
    }];
}
#pragma mark - UITableView delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *priceInforLabel = @"infoLabel";
    static NSString *priceCommerceIns = @"commerceIns";
    static NSString * priceInfoAdd = @"infoAdd";
    if (indexPath.section == 0) {
        PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
        if (!infoLableCell) {
            infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
        }
        PriceInfoModel *model = [self.dataArray objectAtIndex:0];
        if (indexPath.row == 0) {
            infoLableCell.labelTag.text = @"交强险";
            infoLableCell.labelNumber.text = @"投保";
        } else{
            infoLableCell.labelTag.text = @"保费";
            infoLableCell.labelNumber.text = [NSString stringWithFormat:@"¥ %.2f",model.number];
        }
        
        return infoLableCell;
    } else if (indexPath.section == 1) {
        if (self.dataArray.count <= 1) {
            if (indexPath.row == 0){
                PriceInfoAddTableViewCell *infoAddCell = [tableView dequeueReusableCellWithIdentifier:priceInfoAdd];
                if (!infoAddCell) {
                    infoAddCell = [[PriceInfoAddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInfoAdd];
                }
                return infoAddCell;
            } else {
                PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
                if (!infoLableCell) {
                    infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
                }
                infoLableCell.labelTag.text = @"合计";
                infoLableCell.labelNumber.text = @"¥ 0";
                return infoLableCell;
            }
        } else {
            if (indexPath.row < self.dataArray.count - 1){
                PriceCommerceInsTableViewCell *commerceInsCell = [tableView dequeueReusableCellWithIdentifier:priceCommerceIns];
                if (!commerceInsCell) {
                    commerceInsCell = [[PriceCommerceInsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCommerceIns];
                }
                PriceInfoModel *model = [self.dataArray objectAtIndex:indexPath.row + 1];
                commerceInsCell.labelTag.text = model.name;
                if ([model.isMianpei isEqualToString:@"Y"]) {
                    commerceInsCell.labelInsure.text = @"不计免赔";
                    [commerceInsCell hiddenFranchise:NO];
                } else {
                    [commerceInsCell hiddenFranchise:YES];
                }
                if ([model.name isEqualToString:@"玻璃险"]) {
                    if (model.priceValue == 1) {
                        commerceInsCell.labelNumber.text = @"国产玻璃";
                    } else {
                        commerceInsCell.labelNumber.text = @"进口玻璃";
                    }
                    
                } else {
                   commerceInsCell.labelNumber.text = [NSString stringWithFormat:@"%.0f",model.priceValue];;
                }
                commerceInsCell.labelAnnotate.text = @"投保";
                
                return commerceInsCell;
            } else if (indexPath.row == self.dataArray.count-1 ){
                PriceInfoAddTableViewCell *infoAddCell = [tableView dequeueReusableCellWithIdentifier:priceInfoAdd];
                if (!infoAddCell) {
                    infoAddCell = [[PriceInfoAddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInfoAdd];
                }
                return infoAddCell;
            } else {
                PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
                if (!infoLableCell) {
                    infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
                }
                double totality = 0;
                for (int i = 1; i < self.dataArray.count; i++) {
                    PriceInfoModel *inforModel = [self.dataArray objectAtIndex:i];
                    totality = totality + inforModel.priceValue ;
                }
                if (indexPath.row == self.dataArray.count) {
                    infoLableCell.labelTag.text = @"合计";
                    infoLableCell.labelNumber.text = [NSString stringWithFormat:@"¥ %.2f",totality];
                } else {
                    infoLableCell.labelTag.text = @"保费";
                    infoLableCell.labelNumber.text = [NSString stringWithFormat:@"¥ %.2f",_syBaoFei];
                }
                
                return infoLableCell;
            }
        }
    
        
    } else {
        PriceInfolabelTableViewCell *infoLableCell = [tableView dequeueReusableCellWithIdentifier:priceInforLabel];
        if (!infoLableCell) {
            infoLableCell = [[PriceInfolabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceInforLabel];
        }
        PriceInfoModel *infoModel = [self.dataArray objectAtIndex:0];
        double totality = infoModel.number + _syBaoFei;
        infoLableCell.labelTag.text = @"合计";
        infoLableCell.labelNumber.text = [NSString stringWithFormat:@"¥ %2f",totality];
        infoLableCell.labelNumber.textColor = [UIColor colorWithHexString:@"#838383"];
        return infoLableCell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70 * ViewRateBaseOnIP6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(31 * ViewRateBaseOnIP6 , 22 * ViewRateBaseOnIP6, 200, 26 * ViewRateBaseOnIP6)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"交强险";
        return view;
    } else if (section == 1) {
        label.text = @"商业险";
        return view;
    } else {
        return nil;
    }
    
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        return 0;
    }
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return self.dataArray.count + 2;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count == 0) {
        return 0;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 252 * ViewRateBaseOnIP6;
    } else {
        if (self.dataArray.count == 1) {
            return 88 * ViewRateBaseOnIP6;
        } else {
            if (indexPath.section == 1 && indexPath.row < self.dataArray.count - 2) {
                return 58 * ViewRateBaseOnIP6;
            }  else {
                return 88 * ViewRateBaseOnIP6;
            }
        }
        
        
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 2) {
      return 70 * ViewRateBaseOnIP6;
    } else if (section == 2){
        return 30 * ViewRateBaseOnIP6;
    } else {
        return 0;
    }
    
}





//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == self.dataArray.count-1) {
        PriceAdjustViewController *adjustVC = [[PriceAdjustViewController alloc] init];
        adjustVC.passArray = self.allDataArray;
        [self.navigationController pushViewController:adjustVC animated:YES];
    }
}

#pragma mark- cell Delegate


#pragma mark - viewDelegate
- (void)inputTextFieldWithText:(NSString *)text{
    if (text) {
        _offerName = text;
       [self requestSavePrice];
    } else {
        FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"请确认输入报价名称" complete:nil];
        [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
    }
    
}

#pragma mark- function
- (void)savePriveInfo:(UIButton *)button{
    InputTextView *inputView = [[InputTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    inputView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:inputView];
}

- (void)submitNuclearIns:(UIButton *)button{
    PriceUnderwritingViewController *priceUnderVC = [[PriceUnderwritingViewController alloc] init];
    priceUnderVC.bussiseNum = [NSString stringWithFormat:@"%0.2f", _syBaoFei];
    priceUnderVC.dataArray = [self.allDataArray copy];
    priceUnderVC.bussiseNum = [NSString stringWithFormat:@"%f",_syBaoFei];
    [self.navigationController pushViewController:priceUnderVC animated:YES];
}

#pragma mark - UI
- (void)createUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.viewBase];
    [self.view addSubview:self.viewDataEmpty];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 98 * ViewRateBaseOnIP6) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _myTableView;
}

- (UIView *)viewBase{
    if (!_viewBase) {
        _viewBase = [[UIView alloc] init];
        _viewBase.hidden = YES;
        UIButton *buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonSave addTarget:self action:@selector(savePriveInfo:) forControlEvents:UIControlEventTouchDown];
        
        UIButton *buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSubmit.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
        [buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonSubmit setTitle:@"提交核保" forState:UIControlStateNormal];
        [buttonSubmit addTarget:self action:@selector(submitNuclearIns:) forControlEvents:UIControlEventTouchDown];
        [_viewBase addSubview:buttonSave];
        [_viewBase addSubview:buttonSubmit];
        
        if ([self.route isEqualToString:@"1"]) {
            _viewBase.frame = CGRectMake(0, SCREEN_HEIGHT - 98 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
            _viewBase.backgroundColor = [UIColor whiteColor];
            buttonSubmit.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
            buttonSave.hidden = YES;
            
            
        } else {
            _viewBase.frame = CGRectMake(0 , SCREEN_HEIGHT - 98 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
            _viewBase.backgroundColor = [UIColor whiteColor];
            
            buttonSave.hidden = NO;
            buttonSave.frame = CGRectMake(55 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6);
            buttonSubmit.frame = CGRectMake(395 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6);
            buttonSave.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
            buttonSave.layer.masksToBounds = YES;
            buttonSave.backgroundColor = [UIColor whiteColor];
            buttonSave.layer.borderColor = [UIColor colorWithHexString:@"#004da2"].CGColor;
            buttonSave.layer.borderWidth = 1 * ViewRateBaseOnIP6;
            [buttonSave setTitleColor:[UIColor colorWithHexString:@"#004da2"] forState:UIControlStateNormal];
            [buttonSave setTitle:@"保存" forState:UIControlStateNormal];
            
            buttonSubmit.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
            buttonSubmit.layer.masksToBounds = YES;
            UIView *viewSegment = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
            viewSegment.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
            [_viewBase addSubview:viewSegment];
            
        }
    }
    return _viewBase;
}

- (UIView *)viewDataEmpty{
    if (!_viewDataEmpty) {
        _viewDataEmpty = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
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
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}



@end
