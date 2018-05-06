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
#import "XCCarTransactionModel.h"
#import "XCUserCaseListCell.h"

@implementation UserViewController (ListCellNetworkHandler)

- (void)clickCellHanderNetWorkDataWithModel:(XCUserListModel *)model
{
    __weak typeof (self)weakSelf = self;
    //车险客户列表
    if ([self isPolicyTypeVCWithModel:model]) {
        NSDictionary *param = @{
                                @"policyStatus":[self changeTitleValueWithTitle:model.title],
                                @"pageSize":@10,
                                @"pageIndex":@1
                                };
        [RequestAPI getMyPolicyInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            if (response[@"data"] && isUsable(response[@"data"],[NSDictionary class])) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCheckoutDetailBaseModel *baseModel = [XCCheckoutDetailBaseModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [dataArrM addObject:baseModel];
                        }
                    }
                    NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                    NSNumber *pageIndexNum = response[@"data"][@"pageIndex"];
                    subVC.pageIndex = [pageIndexNum intValue];
                    subVC.pageCount = [pageCountNum intValue];
                    subVC.dataArr = dataArrM;
                }
            }
            [weakSelf.navigationController pushViewController:subVC animated:YES];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            [strongSelf.navigationController pushViewController:subVC animated:YES];
        }];
    }
    else if ([self isCarTransactionTypeVCWithModel:model]) {
       //车务客户列表
        NSDictionary *param = @{
                                @"type":model.title,
                                };
        [RequestAPI getelectCarTransactionList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            if (response[@"data"] && isUsable(response[@"data"], [NSDictionary class])) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCarTransactionModel *baseModel = [XCCarTransactionModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [dataArrM addObject:baseModel];
                        }
                    }

                    NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                    NSNumber *pageIndexNum = response[@"data"][@"pageIndex"];
                    subVC.pageIndex = [pageIndexNum intValue];
                    subVC.pageCount = [pageCountNum intValue];
                    subVC.dataArr = dataArrM;
                }
            }
            [strongSelf.navigationController pushViewController:subVC animated:YES];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
          XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            [strongSelf.navigationController pushViewController:subVC animated:YES];
        }];
    }
    else if ([model.title isEqualToString:@"我的客户"]) {
        NSDictionary *param = @{
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        [RequestAPI getCustomerList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            if (response[@"data"] && isUsable(response[@"data"], [NSDictionary class])) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCCustomerListModel *baseModel = [XCCustomerListModel yy_modelWithJSON:dataInfo];
                        if (baseModel) {
                            [dataArrM addObject:baseModel];
                        }
                    }
                    NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                    NSNumber *pageIndexNum = response[@"data"][@"pageIndex"];
                    subVC.pageIndex = [pageIndexNum intValue];
                    subVC.pageCount = [pageCountNum intValue];
                    subVC.dataArr = dataArrM;
                }
            }
            [weakSelf.navigationController pushViewController:subVC animated:YES];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
          XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            [weakSelf.navigationController pushViewController:subVC animated:YES];
        }];
    }
    else if ([self isCaseTypeVCWithModel:model]) {
        //三大案件
        NSDictionary *param = @{
                                @"caseType":model.title,
                                @"PageIndex":[NSNumber numberWithInt:1],
                                @"PageSize":[NSNumber numberWithInt:10]
                                };
        [RequestAPI getThreeCaseApplyList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
            if (response[@"data"] && isUsable(response[@"data"], [NSDictionary class])) {
                if (response[@"data"][@"dataSet"]) {
                    NSMutableArray *dataArrM = [[NSMutableArray alloc] init];
                    NSArray *origionDataArr = response[@"data"][@"dataSet"];
                    for (NSDictionary *dataInfo in origionDataArr) {
                        XCUserCaseListModel *caseModel = [XCUserCaseListModel yy_modelWithJSON:dataInfo];
                        if (caseModel) {
                            [dataArrM addObject:caseModel];
                        }
                    }
                    NSNumber *pageCountNum = response[@"data"][@"pageCount"];
                    NSNumber *pageIndexNum = response[@"data"][@"pageIndex"];
                    subVC.pageIndex = [pageIndexNum intValue];
                    subVC.pageCount = [pageCountNum intValue];
                    subVC.dataArr = dataArrM;
                }
            }
            [weakSelf.navigationController pushViewController:subVC animated:YES];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
         XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
         [weakSelf.navigationController pushViewController:subVC animated:YES];
        }];
    }
    else if ([model.title isEqualToString:@"门店"]) {
        NSDictionary *param = @{
                                @"id":[UserInfoManager shareInstance].storeID,
                                };
        XCCheckoutBaseTableViewController *subVC = [(XCCheckoutBaseTableViewController *)[NSClassFromString(model.urlString)alloc] initWithTitle:model.title];
        [RequestAPI getShopsInfo:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if (response[@"data"] && isUsable(response[@"data"], [NSDictionary class])) {
                XCShopModel *shopModel = [XCShopModel yy_modelWithJSON:response[@"data"]];
                subVC.storeModel = shopModel;
            }
            [weakSelf.navigationController pushViewController:subVC animated:YES];
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            [weakSelf.navigationController pushViewController:subVC animated:YES];
        }];
    }
    
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
    else if ([model.title isEqualToString:@"已缴费待出单"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"会计审核中"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"配送"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"修改核保"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"续保列表"]) {
        result = YES;
    }
    return result;
}

- (BOOL)isCarTransactionTypeVCWithModel:(XCUserListModel *)model
{
    BOOL result = NO;
    if ([model.title isEqualToString:@"年审"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"违章"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"维修"]) {
        result = YES;
    }
    return result;
}

- (BOOL)isCaseTypeVCWithModel:(XCUserListModel *)model
{
    BOOL result = NO;
    if ([model.title isEqualToString:@"人伤案件"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"无责事故案件"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"特殊案件"]) {
        result = YES;
    }
    else if ([model.title isEqualToString:@"代垫付案件"]) {
        result = YES;
    }
    return result;
}


- (NSString *)changeTitleValueWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"待核保"]) {
        return @"待核保";
    }
    else if ([title isEqualToString:@"已核保代缴费"]) {
        return @"已核保";
    }
    else if ([title isEqualToString:@"已缴费待出单"]) {
        return @"待出单";
    }
    else if ([title isEqualToString:@"会计审核中"]) {
        return @"会计审核中";
    }
    else if ([title isEqualToString:@"配送"]) {
        return @"配送中";
    }
    else if ([title isEqualToString:@"修改核保"]) {
        return @"修改核保";
    }
    else if ([title isEqualToString:@"续保列表"]) {
        return @"续保";
    }
    return @"";
}

@end
