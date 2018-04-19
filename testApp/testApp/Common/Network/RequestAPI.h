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

//首页公告
+(void)getCoverAnnouncement:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//公告详情
+(void)getCoverWeb:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//首页轮播图
+(void)getCoverLoopImage:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//修改密码
+(void)updatePassWord:(NSDictionary *)paramenter  header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//我的勋章
+(void)getMyMedal:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;


//接车列表
+(void)getGetCarList:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//接车
+(void)getGetCar:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//接车完成
+(void)getGetCarFinish:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//获取接车订单详情
+(void)getGetCarDetail:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+(void)getGetCarService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+(void)getGetCarAddOrder:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

+(void)getGetCarSelectPlateNO:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

#pragma mark 报价
//车牌号查询
+ (void)getCustomerVehicleEnquiries:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//客户信息录入
+ (void)getCustomerInformationInput:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//报价记录
+ (void)getPriceRecord:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//报价
+ (void)getPriceOffer:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

// 获取客户上年报价
+ (void)getLastYearPriceRecord:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//获取投保价格
+ (void)getInsuredrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//获取一家保险公司的报价详情
+ (void)getPrecisePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

// 核保
+ (void)getUnderwriting:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//保存报价
+(void)getSavePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//删除报价
+(void)getDeletePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;
@end

#pragma mark - 个人中心
@interface RequestAPI (UserCenter_API)
//我的佣金
+(void)getMyCommission:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//获取车险列表
+(void)getMyPolicyInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//撤销核保
+(void)postPolicyRevokeBySaleMan:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//提交配送保单
+(void)postSubmitPolicyPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//提交配送缴费单
+(void)postSubmitPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//已核保代缴费-配送保单-查询礼包
+(void)getValidPackage:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//获取客户列表
+(void)getCustomerList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//获取客户详细信息
+(void)getCustomerParticularsList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//客户跟进--获取选择操作类型
+(void)getSelectLinesByDictCode:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//客户跟进--提交
+(void)postCustomerFollowRec:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;

//预约维修
+(void)addOrderByMaintain:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//违章查询
+(void)getWZMessageByCarId:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//预约违章接口
+(void)addOrderByAuditAndRules:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//获取年审类型和费用
+(void)getCarVerificationMoney:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
////预约年审接口
//+(void)addOrderByAuditAndRules:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//查询门店列表
+(void)appFindStore:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;

//获取车务（年审，违章，维修）客户列表
+(void)getelectCarTransactionList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//获取车务详情
+(void)getCarTransaction:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;


//获取三大案件列表
+(void)getThreeCaseApplyList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;
//获取三大案件详情
+(void)getThreeCaseApply:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail;


//获取门店详情
+(void)getShopsInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//修改门店详情
+(void)postUpdateStore:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;

//获取门店服务信息
+(void)getStoreService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail;


@end
