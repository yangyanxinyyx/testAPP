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
    NSNumber *medalBonus = data[@"medal_bonus"];
    NSNumber *carPerformance = data[@"car_performance"];
    NSNumber *servicePerformance = data[@"service_performance"];
    NSString *createTime = data[@"creat_time"];
    XCMyCommissionListModel *model = [[XCMyCommissionListModel alloc] init];
    
    if (isUsable(serviceCommission, [NSNumber class])) {
        model.serviceCommission = serviceCommission;
    }
    if (isUsable(carCommission, [NSNumber class])) {
        model.carCommission = carCommission;
    }
    if (isUsable(carRoyalties, [NSNumber class])) {
        model.carRoyalties = carRoyalties;
    }
    if (isUsable(medalBonus, [NSNumber class])) {
        model.medalBonus = medalBonus;
    }
    if (isUsable(carPerformance, [NSNumber class])) {
        model.carPerformance = carPerformance;
    }
    if (isUsable(servicePerformance, [NSNumber class])) {
        model.servicePerformance = servicePerformance;
    }
    model.createTime = createTime?createTime:@"";
    return model;
}

@end
