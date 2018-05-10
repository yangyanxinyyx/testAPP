//
//  UserInfoManager.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserInfoManager.h"

@implementation CoverMainModel

@end

@implementation UserMedal

@end

@implementation PerformanceMedal

- (void)setLastYearCar:(NSString *)lastYearCar{
    _lastYearCar = lastYearCar;
    if([_lastYearCar isEqualToString:@"<null>"]) {
        _lastYearCar = @"0";
    }
}

- (void)setLastMonthCar:(NSString *)lastMonthCar{
    _lastMonthCar = lastMonthCar;
    if([_lastMonthCar isEqualToString:@"<null>"]) {
        _lastMonthCar = @"0";
    }
}

- (void)setNowMonthCar:(NSString *)nowMonthCar{
    _nowMonthCar = nowMonthCar;
    if([_nowMonthCar isEqualToString:@"<null>"]) {
        _nowMonthCar = @"0";
    }
}

- (void)setLastYearCarRanking:(NSString *)lastYearCarRanking{
    _lastYearCarRanking = lastYearCarRanking;
    if([_lastYearCarRanking isEqualToString:@"<null>"]) {
        _lastYearCarRanking = @"0";
    }
}

- (void)setLastMonthCarRanking:(NSString *)lastMonthCarRanking{
    _lastMonthCarRanking = lastMonthCarRanking;
    if([_lastMonthCarRanking isEqualToString:@"<null>"]) {
        _lastMonthCarRanking = @"0";
    }
}

- (void)setNowMonthCarRanking:(NSString *)nowMonthCarRanking{
    _nowMonthCarRanking = nowMonthCarRanking;
    if([_nowMonthCarRanking isEqualToString:@"<null>"]) {
        _nowMonthCarRanking = @"0";
    }
}

@end

static UserInfoManager *manager = nil;

@implementation UserInfoManager

+ (UserInfoManager *)shareInstance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc] init];
        [manager configureInstance];
    });

    return manager;
}

- (void)configureInstance
{
    manager.performanceMedal = [[PerformanceMedal alloc] init];
    manager.userMedal = [[UserMedal alloc] init];
    manager.coverMainModel = [[CoverMainModel alloc] init];
    manager.coverMainModel.announcementDatas = [NSMutableArray array];
    manager.coverMainModel.loopImageDatas = [NSMutableArray array];
    manager.isStore = NO;
    manager.code = nil;
    manager.employeeId = nil;
    manager.employeeName = nil;
    manager.iconUrl = nil;
    manager.userID = nil;
    manager.isStoreAdministrator = nil;
    manager.name = nil;
    manager.needModifyPwsNextLogin = nil;
    manager.noModifyPsw = nil;
    manager.phone = nil;
    manager.carID = nil;
    manager.customerId = nil;
    manager.customerName = nil;
    manager.identity = nil;
    manager.orgUnitId = nil;
    manager.orgUnitName = nil;
    manager.storeID = nil;
    manager.storeName = nil;
    manager.storeCode = nil;
    manager.tel = nil;
    manager.corporateName = nil;
    manager.corporateCellphone = nil;
    manager.address = nil;
}


+ (void)destroyInstance {    
    [manager configureInstance];
}


@end
