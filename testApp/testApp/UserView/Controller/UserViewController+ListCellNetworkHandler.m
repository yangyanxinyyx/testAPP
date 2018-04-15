//
//  UserViewController+ListCellNetworkHandler.m
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserViewController+ListCellNetworkHandler.h"
#import "XCShopModel.h"
#import "XCUserListModel.h"
#import "XCCustomerListModel.h"
#import "XCCheckoutDetailBaseModel.h"
#import "XCCheckoutBaseTableViewController.h"

@implementation UserViewController (ListCellNetworkHandler)

- (void)clickCellHanderNetWorkDataWithModel:(XCUserListModel *)model
{
    __weak typeof (self)weakSelf = self;
    
    //车险客户列表
    if ([self isPolicyTypeVCWithModel:model]) {
        NSDictionary *param = @{
                                @"policyStatus":model.title,
                                };

        [RequestAPI getMyPolicyInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            BOOL configureSucess  = NO;
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCheckoutDetailBaseModel *baseModel = [XCCheckoutDetailBaseModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [dataArrM addObject:baseModel];
                        }
                    }
                    XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
                    subVC.dataArr = dataArrM;
                    [weakSelf.navigationController pushViewController:subVC animated:YES];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    configureSucess = YES;
                }
            }
            if (!configureSucess) {
                [weakSelf requestFailureHandler];
            }
        } fail:^(id error) {
            [weakSelf requestFailureHandler];
        }];
    }
    else if ([model.title isEqualToString:@"我的客户"]) {
        NSDictionary *param = @{
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:6]
                                };
        [RequestAPI getCustomerList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            BOOL configureSucess  = NO;
            if (response[@"data"]) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCustomerListModel *baseModel = [XCCustomerListModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [dataArrM addObject:baseModel];
                        }
                    }
                    XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
                    subVC.dataArr = dataArrM;
                    [weakSelf.navigationController pushViewController:subVC animated:YES];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    configureSucess = YES;
                }
            }
            if (!configureSucess) {
                [weakSelf requestFailureHandler];
            }
        } fail:^(id error) {
            [weakSelf requestFailureHandler];
        }];
    }
    else if ([model.title isEqualToString:@"门店"]) {
        NSDictionary *param = @{
                                @"id":[UserInfoManager shareInstance].storeID,
                                };
        [RequestAPI getShopsInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"]) {
                XCShopModel *shopModel = [XCShopModel yy_modelWithJSON:response[@"data"]];
                XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
                subVC.storeModel = shopModel;
                [weakSelf.navigationController pushViewController:subVC animated:YES];
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            }else {
                [weakSelf requestFailureHandler];
            }
        } fail:^(id error) {
            [weakSelf requestFailureHandler];
            
        }];
    }else {
        
    }
    
}

- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}

- (BOOL)isPolicyTypeVCWithModel:(XCUserListModel *)model
{
    BOOL result = NO;
    if ([model.title isEqualToString:@"待核保"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"已核保代缴费"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"已缴费待打单"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"财务审核中"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"配送"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"退单"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"续保列表"]) {
        result = YES;
    }
    return result;
}

@end
