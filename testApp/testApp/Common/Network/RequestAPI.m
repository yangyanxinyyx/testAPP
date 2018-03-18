//
//  RequestAPI.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "RequestAPI.h"

@implementation RequestAPI

+(void)getRequest:(NSString *)url paramenter:(NSDictionary *)paramenter success:(void(^)(id response))success failuer:(void(^)(id error))failuer{



//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager setResponseSerializer:[AFXMLParserResponseSerializer new]];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回类型位
//    [manager GET:url parameters:paramenter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failuer(error);
//    }];


}

@end
