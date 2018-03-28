//
//  RequestAPI.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "RequestAPI.h"

#define API_PREFIX @"http://115.29.174.77:8081/XC"
//#define API_PREFIX @"http://result.eolinker.com/qF97Lij3d32eb485319da0d5792df72fa4b2b1fabecfefb?uri="

//登录
#define LOGIN_API [NSString stringWithFormat:@"%@/api/app/userLogin",API_PREFIX]

//修改密码
#define UPDATEPASSWORD_API [NSString stringWithFormat:@"%@/api/web/sysUser/updatePassword",API_PREFIX]

//个人车险
#define PERSONALPOLICY_API [NSString stringWithFormat:@"%@/api/web/medaltable/seletPolicy",API_PREFIX]

//我的勋章
#define MYMEDAL_API [NSString stringWithFormat:@"%@/api/web/medaltable/selectMedalTableType",API_PREFIX]



@implementation RequestAPI

+(void)getRequest:(NSString *)url paramenter:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (header) {
         [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    }

    manager.requestSerializer.timeoutInterval = 30.0f;


    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager POST:url parameters:paramenter progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        NSLog(@"responseObject-->%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
        if (fail) {
            fail(error);
        }
    }];

}

+(void)getUserInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:LOGIN_API paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
         fail(error);
    }];
}

+(void)getPersonalPolicy:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{
//@"http://result.eolinker.com/qF97Lij3d32eb485319da0d5792df72fa4b2b1fabecfefb?uri=/api/app/medaltable/seletPolicy"
    [self getRequest:PERSONALPOLICY_API paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getMyMedal:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:MYMEDAL_API paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)updatePassWord:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:UPDATEPASSWORD_API paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

@end
