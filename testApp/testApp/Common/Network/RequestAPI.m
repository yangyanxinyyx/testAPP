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

/****** 首页 ******/
//登录
#define LOGIN_API [NSString stringWithFormat:@"%@/api/app/userLogin",API_PREFIX]

//修改密码
#define UPDATEPASSWORD_API [NSString stringWithFormat:@"%@/api/web/sysUser/updatePassword",API_PREFIX]

//个人车险
#define PERSONALPOLICY_API [NSString stringWithFormat:@"%@/api/web/medaltable/seletPolicy",API_PREFIX]

//首页公告
#define COVERANNOUNCEMENT_API [NSString stringWithFormat:@"%@/api/web/notice/findNoticeByEmployee",API_PREFIX]

//公告详情
#define COVERWEB_API [NSString stringWithFormat:@"%@/api/web/notice/selectNoticeInfoContent",API_PREFIX]

//首页轮播图
#define COVERLOOPIMAGE_API [NSString stringWithFormat:@"%@/api/web/pictrue/findByType",API_PREFIX]

//我的勋章
#define MYMEDAL_API [NSString stringWithFormat:@"%@/api/web/medaltable/selectMedalTableType",API_PREFIX]

 /****** 接车 ******/
//业务端获取门店订单列表（接车列表）
#define GETCARLIST_API [NSString stringWithFormat:@"%@/api/web/order/findOrderByStoreId",API_PREFIX]

//接车
#define GETCAR_API [NSString stringWithFormat:@"%@/api/web/order/consumingOrder",API_PREFIX]

//接车完成
#define GETCARFiNISH_API [NSString stringWithFormat:@"%@/api/web/order/consumOverOrder",API_PREFIX]

//接车时获取订单详情
#define GETCARDETAILINFORMATION_API [NSString stringWithFormat:@"%@/api/web/order/operationGetOrder",API_PREFIX]


// =================== modify by Liangyz 个人中心
//====个人中心====
//我的佣金
#define MYCOMISSION_API [NSString stringWithFormat:@"%@/api/web/commission/selectCommission",API_PREFIX]

//====车险客户列表====
//获取 待核保、已核保代缴费、已缴费待打单、财务审核、配送、退单、续保列表
#define MYPOLICYBYCONDINATION_API [NSString stringWithFormat:@"%@/api/web/policy/selectMyPolicyByCondiction",API_PREFIX]
//撤销核保
#define MYPOLICYREVOKBYSALEMAN_API [NSString stringWithFormat:@"%@/api/web/policy/updatePolicyRevokeBySalesman",API_PREFIX]
//提交配送保单
#define SUBMITPOLICYPAYMENTLIST_API [NSString stringWithFormat:@"%@/api/web/policy/submitPolicyPaymentList",API_PREFIX]
//提交配送缴费单
#define SUBMITPAYMENTLIST_API [NSString stringWithFormat:@"%@/api/web/policy/submitPaymentList",API_PREFIX]
//获取客户列表
#define SELECTCUSTOMERLIST_API [NSString stringWithFormat:@"%@/api/web/customers/selectCustomerList",API_PREFIX]
//获取客户详情列表
#define SELECTCUSTOMERPARTICULARS_API [NSString stringWithFormat:@"%@/api/web/customers/selectCustomerParticulars",API_PREFIX]
//获取车务客户详情列表
#define SELECTCARTRANSACTIONLIST_API [NSString stringWithFormat:@"%@/api/web/carTransaction/selectCarTransactionList",API_PREFIX]
//获取车务详情
#define GETCARTRANSACTION_API [NSString stringWithFormat:@"%@/api/web/carTransaction/getCarTransaction",API_PREFIX]

//获取三大案件列表
#define SELECTTHREECASEAPPLYLIST_API [NSString stringWithFormat:@"%@/api/web/threeCaseApply/selectThreeCaseApplyList",API_PREFIX]
//获取三大案件详情
#define GETTHREECASEAPPLY_API [NSString stringWithFormat:@"%@/api/web/threeCaseApply/getThreeCaseApply",API_PREFIX]
//====门店====
//门店信息
#define SHOPSDETAIL_API [NSString stringWithFormat:@"%@/api/web/store/getStore",API_PREFIX]
//门店服务
#define SHOPSSERVICE_API [NSString stringWithFormat:@"%@/api/web/store/findStoreService",API_PREFIX]
//修改门店详情
#define SHOPUPDATESTORE_API [NSString stringWithFormat:@"%@/api/web/store/updateStore",API_PREFIX]

// ===================


//客户车辆查询
#define CUSTOMERVEHICLEENQUIRIES_API [NSString stringWithFormat:@"%@/api/web/car/findOrAddCustomerAndCar",API_PREFIX]

//Customer information input. 客户信息录入
#define CustomerInformatioInput_API [NSString stringWithFormat:@"%@/api/web/customers/insertCustomerAndCar",API_PREFIX]

// 获取报价记录
#define PRICERECORD_API [NSString stringWithFormat:@"%@/api/web/offer/queryOffer",API_PREFIX]

//报价
#define PRICEOFFER_API [NSString stringWithFormat:@"%@/api/web/bihu/appPrecisePrice",API_PREFIX]

//获取上年报价记录
#define LASTYEARPRICERECORD_API [NSString stringWithFormat:@"%@/api/web/bihu/getLastYearQuotation",API_PREFIX]

//获取投保价格
#define INSUREDPRICE_API [NSString stringWithFormat:@"%@/api/web/dict/selectLinesByDictCode",API_PREFIX]

//获取一家保险公司的报价详情
#define PRECISEPRICE_API [NSString stringWithFormat:@"%@/api/web/bihu/getPrecisePrice",API_PREFIX]

//保存报价
#define SAVEPRICE_API [NSString stringWithFormat:@"%@/api/web/offer/addOffer",API_PREFIX]
@implementation RequestAPI

+(void)getRequest:(NSString *)url isPOST:(BOOL)isPOST paramenter:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{
    [ProgressControll showProgressNormal];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (header) {
         [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer.timeoutInterval = 30.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if (isPOST) {
        [manager POST:url parameters:paramenter progress:^(NSProgress * _Nonnull uploadProgress) {
            //返回请求返回进度
            NSLog(@"downloadProgress-->%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功返回数据 根据responseSerializer 返回不同的数据格式
            NSLog(@"responseObject-->%@",responseObject);
            if (success) {
                success(responseObject);
                [ProgressControll dismissProgress];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            NSLog(@"error-->%@",error);
            if (fail) {
                fail(error);
                [ProgressControll dismissProgress];
            }
        }];
    }else{
        [manager GET:url parameters:paramenter progress:^(NSProgress * _Nonnull downloadProgress) {
            //返回请求返回进度
            NSLog(@"downloadProgress-->%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功返回数据 根据responseSerializer 返回不同的数据格式
            NSLog(@"responseObject-->%@",responseObject);
            if (success) {
                success(responseObject);
                [ProgressControll dismissProgress];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            NSLog(@"error-->%@",error);
            if (fail) {
                fail(error);
                [ProgressControll dismissProgress];
            }
        }];
    }
}



+(void)getUserInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:LOGIN_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
         fail(error);
    }];
}

+(void)getPersonalPolicy:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{
//@"http://result.eolinker.com/qF97Lij3d32eb485319da0d5792df72fa4b2b1fabecfefb?uri=/api/app/medaltable/seletPol
    [self getRequest:PERSONALPOLICY_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getMyMedal:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:MYMEDAL_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getCoverAnnouncement:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:COVERANNOUNCEMENT_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getCoverWeb:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:COVERWEB_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getCoverLoopImage:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:COVERLOOPIMAGE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getGetCarList:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCARLIST_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getGetCar:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCAR_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getGetCarFinish:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCARFiNISH_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getGetCarDetail:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCARDETAILINFORMATION_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)updatePassWord:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:UPDATEPASSWORD_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}


#pragma mark 报价
//车牌号查询
+ (void)getCustomerVehicleEnquiries:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:CUSTOMERVEHICLEENQUIRIES_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//客户信息录入
+ (void)getCustomerInformationInput:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:CustomerInformatioInput_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//报价记录
+ (void)getPriceRecord:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:PRICERECORD_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//报价
+ (void)getPriceOffer:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:PRICEOFFER_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

// 获取客户上年报价
+ (void)getLastYearPriceRecord:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:LASTYEARPRICERECORD_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
 
}

//获取投保价格
+ (void)getInsuredrice:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:INSUREDPRICE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//获取一家保险公司的报价详情
+ (void)getPrecisePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:PRECISEPRICE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//保存报价
+ (void)getSavePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{
    [self getRequest:SAVEPRICE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

#pragma mark - 个人中心
+(void)getMyCommission:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    
    //    NSString *str= @"http://result.eolinker.com/qF97Lij3d32eb485319da0d5792df72fa4b2b1fabecfefb?uri=/api/web/commission/selectCommission";
    [self getRequest:MYCOMISSION_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

#pragma mark 车险客户列表

+(void)getMyPolicyInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:MYPOLICYBYCONDINATION_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)postPolicyRevokeBySaleMan:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:MYPOLICYREVOKBYSALEMAN_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+ (void)postSubmitPolicyPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SUBMITPOLICYPAYMENTLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)postSubmitPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCUSTOMERLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getCustomerList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCUSTOMERLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getCustomerParticularsList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCUSTOMERPARTICULARS_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getelectCarTransactionList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCARTRANSACTIONLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getCarTransaction:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:GETCARTRANSACTION_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getThreeCaseApplyList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTTHREECASEAPPLYLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getThreeCaseApply:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:GETTHREECASEAPPLY_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

#pragma mark 门店

+(void)getShopsInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SHOPSDETAIL_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)postUpdateStore:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:SHOPUPDATESTORE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getStoreService:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    
    [self getRequest:SHOPSSERVICE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}


@end
