//
//  RequestAPI.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <UIKit/UIKit.h>

@interface RequestAPI : NSObject

//登录后获取用户信息
+(void)getUserInfo:(NSDictionary *)paramenter success:(void(^)(id response))success fail:(void(^)(id error))fail;

//修改密码
+(void)updatePassWord:(NSDictionary *)paramenter success:(void(^)(id response))success fail:(void(^)(id error))fail;

@end
