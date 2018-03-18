//
//  RequestAPI.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "RequestAPI.h"

#define LOGIN_API @"115.29.174.77:8081/XC/api/app/userLogin"

@implementation RequestAPI

+(void)getRequest:(NSString *)url paramenter:(NSDictionary *)paramenter success:(void(^)(id response))success fail:(void(^)(id error))fail{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    manager.requestSerializer.timeoutInterval = 30.0f;

//    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];


    [manager POST:url parameters:paramenter progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        NSLog(@"responseObject-->%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
    }];

}

+(void)getUserInfo:(NSDictionary *)paramenter success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:LOGIN_API paramenter:paramenter success:^(id response) {
        success(response);
    } fail:^(id error) {
         fail(error);
    }];
}


@end
