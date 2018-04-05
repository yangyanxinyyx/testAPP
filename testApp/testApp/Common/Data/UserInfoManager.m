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

@end

@implementation UserInfoManager

+ (UserInfoManager *)shareInstance {
    static UserInfoManager *manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc] init];
        manager.performanceMedal = [[PerformanceMedal alloc] init];
        manager.userMedal = [[UserMedal alloc] init];
        manager.coverMainModel = [[CoverMainModel alloc] init];
    });

    return manager;
}

@end
