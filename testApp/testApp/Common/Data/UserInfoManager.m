//
//  UserInfoManager.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserInfoManager.h"

@interface UserInfoManager ()


@end

@implementation UserInfoManager

+ (UserInfoManager *)shareInstance {
    static UserInfoManager *manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc] init];
    });

    return manager;
}

@end
