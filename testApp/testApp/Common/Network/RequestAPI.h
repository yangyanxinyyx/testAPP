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
+(void)getUserInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//个人车险业绩
+(void)getPersonalPolicy:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//修改密码
+(void)updatePassWord:(NSDictionary *)paramenter  header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//我的勋章
+(void)getMyMedal:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//接车列表
+(void)getGetCarList:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

#pragma mark 报价
+ (void)getCustomerVehicleEnquiries:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getCustomerInformationInput:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getPriceRecord:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getPriceOffer:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getLastYearPriceRecord:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getInsuredrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getPrecisePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+ (void)getUnderwriting:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//首页公告
+(void)getCoverAnnouncement:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//首页轮播图
+(void)getCoverLoopImage:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;


+(void)getSavePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;
@end
#pragma mark - 个人中心

@interface RequestAPI (UserCenter_API)
//我的佣金
+(void)getMyCommission:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+(void)getMyPolicyInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;

//撤销核保
+(void)postPolicyRevokeBySaleMan:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;

//提交配送保单
+(void)postSubmitPolicyPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;

//提交配送缴费单
+(void)postSubmitPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;


//获取门店详情
+(void)getShopsInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//修改门店详情
+(void)postUpdateStore:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//获取门店服务信息
+(void)getStoreService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;


@end
