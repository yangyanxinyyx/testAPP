//
//  XCMyCommissionListModel.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionListModel.h"

@implementation XCMyCommissionListModel

+(XCMyCommissionListModel *)getMyCommissionListWithDataInfo:(NSDictionary *)data
{
    if (!data) {
        return nil;
    }
    NSNumber *serviceCommission = data[@"service_commission"];
    NSNumber *carCommission = data[@"car_commission"];
    NSNumber *carRoyalties = data[@"car_royalties"];
    NSNumber *medalBonus = data[@"car_royalties"];
    NSNumber *carPerformance = data[@"car_performance"];
    NSNumber *servicePerformance = data[@"service_performance"];
    NSString *createTime = data[@"creat_time"];
    XCMyCommissionListModel *model = [[XCMyCommissionListModel alloc] init];
    
    model.serviceCommission = serviceCommission;
    model.carCommission = carCommission;
    model.carRoyalties = carRoyalties;
    model.medalBonus = medalBonus;
    model.carPerformance = carPerformance;
    model.servicePerformance = servicePerformance;
    model.createTime = createTime?createTime:@"";
    return model;
}

@end
