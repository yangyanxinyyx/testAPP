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
#define COVERWEB_API [NSString stringWithFormat:@"%@/api/web/notice/getNotice",API_PREFIX]

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

//获取门店内服务
#define GETCARSERVICE_API [NSString stringWithFormat:@"%@/api/web/service/getServiceByStoreId",API_PREFIX]

//新增维修
#define GETCARADDORDER_API [NSString stringWithFormat:@"%@/api/web/order/insertOrder",API_PREFIX]

//车牌号查询
#define GETCARSELECTPLATENO_API [NSString stringWithFormat:@"%@//api/web/car/selectPlateNoList",API_PREFIX]


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
//查询礼包(没有用)
#define FINDVALIDPACKAGE_API [NSString stringWithFormat:@"%@/api/web/package/findValidPackage",API_PREFIX]
//获取客户列表
#define SELECTCUSTOMERLIST_API [NSString stringWithFormat:@"%@/api/web/customers/selectCustomerList",API_PREFIX]
//获取客户详情列表
#define SELECTCUSTOMERPARTICULARS_API [NSString stringWithFormat:@"%@/api/web/customers/selectCustomerParticulars",API_PREFIX]
//获取客户跟进--获取操作类型
#define SELECTLINESBYDICTCODE_API [NSString stringWithFormat:@"%@/api/web/dict/selectLinesByDictCode",API_PREFIX]
//提交客户跟进-提交
#define INSERTCUSTOMERFOLLOWREC_API [NSString stringWithFormat:@"%@/api/web/customers/insertCustomerFollowRec",API_PREFIX]
//退单-修改核保
#define SUBMITPOLICYAFTERREVOKE_API [NSString stringWithFormat:@"%@/api/web/policy/submitPolicyAfterRevoke",API_PREFIX]


//预约维修
#define ADDORDERBYMAINTAIN_API [NSString stringWithFormat:@"%@/api/web/order/addOrderByMaintain",API_PREFIX]
//查询违章
#define GETWZMESSAGEBYCARID_API [NSString stringWithFormat:@"%@/api/web/weizhang/getWZMessageByCarId",API_PREFIX]
//预约违章/预约年审
#define ADDORDERBYAUDITANDRULES_API [NSString stringWithFormat:@"%@/api/web/order/addOrderByAuditAndRules",API_PREFIX]
//获取年审类型和费用
#define GETCARVERIFICATIONMONEY_API [NSString stringWithFormat:@"%@/api/web/order/getCarVerificationMoney",API_PREFIX]
//查询门店列表
#define APPFINDSTORE_API [NSString stringWithFormat:@"%@/api/web/store/appFindStore",API_PREFIX]

//获取车务客户详情列表
#define SELECTCARTRANSACTIONLIST_API [NSString stringWithFormat:@"%@/api/web/carTransaction/selectCarTransactionList",API_PREFIX]
//获取车务详情
#define GETCARTRANSACTION_API [NSString stringWithFormat:@"%@/api/web/carTransaction/getCarTransaction",API_PREFIX]

//获取三大案件列表
#define SELECTTHREECASEAPPLYLIST_API [NSString stringWithFormat:@"%@/api/web/threeCaseApply/selectThreeCaseApplyList",API_PREFIX]
//获取三大案件详情
#define GETTHREECASEAPPLY_API [NSString stringWithFormat:@"%@/api/web/threeCaseApply/getThreeCaseApply",API_PREFIX]

//====门店====
//图片上传
#define APPUPLOADPICTURE_API [NSString stringWithFormat:@"%@/api/web/pictrue/appUploadPicture",API_PREFIX]
//图片删除
#define DELETEPICTUREBYURL_API [NSString stringWithFormat:@"%@/api/web/pictrue/deletePictureByUrl",API_PREFIX]
//门店信息
#define SHOPSDETAIL_API [NSString stringWithFormat:@"%@/api/web/store/getStore",API_PREFIX]
//门店服务
#define SHOPSSERVICE_API [NSString stringWithFormat:@"%@/api/web/store/findStoreServiceTwo",API_PREFIX]
//修改门店详情
#define SHOPUPDATESTORE_API [NSString stringWithFormat:@"%@/api/web/store/updateStore",API_PREFIX]
//编辑服务
#define UPDATESERVICE_API [NSString stringWithFormat:@"%@/api/web/store/updateService",API_PREFIX]
//查询可添加服务
#define QUERYSERVICEBYSTOREID_API [NSString stringWithFormat:@"%@/api/web/service/queryServiceByStoreId",API_PREFIX]
//添加服务
#define INSERTSERVICE_API [NSString stringWithFormat:@"%@/api/web/store/insertService",API_PREFIX]
//删除服务
#define DELETESTORESERVICE_API [NSString stringWithFormat:@"%@/api/web/store/deleteStoreService",API_PREFIX]
// ===================

// === 报价 ====
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

//删除报价
#define DELETEPRICE_API [NSString stringWithFormat:@"%@/api/web/offer/deleteOffer",API_PREFIX]
//核保 api/web/policy/insertPolicy
#define UNDERWRITING_API [NSString stringWithFormat:@"%@/api/web/policy/insertPolicy",API_PREFIX]

// 客户信息录入搜索客户信息接口
#define USERINFOBYLICENSENO_API [NSString stringWithFormat:@"%@/api/web/bihu/getUserInfoByLicenseNo",API_PREFIX]

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
                if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"The Internet connection appears to be offline."]) {
                    fail(@"网络出错");
                } else {
                   fail(error);
                }
            } else {
              fail(error);
            }
            
            [ProgressControll dismissProgress];
            
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

+(void)getGetCarService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCARSERVICE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getGetCarAddOrder:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCARADDORDER_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

+(void)getGetCarSelectPlateNO:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{

    [self getRequest:GETCARSELECTPLATENO_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
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

// 客户信息录入搜索客户信息接口
+ (void)getCustomerInforSearchInfor:(NSDictionary *)parmenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    [self getRequest:USERINFOBYLICENSENO_API isPOST:YES paramenter:parmenter header:header success:^(id response) {
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

//删除报价
+(void)getDeletePrice:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{
    [self getRequest:DELETEPRICE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

// 核保
+ (void)getUnderwriting:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail{
    [self getRequest:UNDERWRITING_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

#pragma mark - 个人中心
//我的佣金
+(void)getMyCommission:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail{
    
    [self getRequest:MYCOMISSION_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

#pragma mark 车险客户列表
//获取车险列表
+(void)getMyPolicyInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:MYPOLICYBYCONDINATION_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//撤销核保
+(void)postPolicyRevokeBySaleMan:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:MYPOLICYREVOKBYSALEMAN_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//提交配送保单
+ (void)postSubmitPolicyPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SUBMITPOLICYPAYMENTLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//提交配送缴费单
+(void)postSubmitPaymentList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SUBMITPAYMENTLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//已核保代缴费-配送保单-查询礼包
+(void)getValidPackage:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:FINDVALIDPACKAGE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取客户列表
+(void)getCustomerList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCUSTOMERLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取客户详细信息
+(void)getCustomerParticularsList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCUSTOMERPARTICULARS_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//客户跟进--获取选择操作类型
+(void)getSelectLinesByDictCode:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTLINESBYDICTCODE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//客户跟进--提交
+(void)postCustomerFollowRec:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:INSERTCUSTOMERFOLLOWREC_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//退单-修改核保
+(void)submitPolicyAfterRevoke:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SUBMITPOLICYAFTERREVOKE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//预约维修
+(void)addOrderByMaintain:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:ADDORDERBYMAINTAIN_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//违章查询
+(void)getWZMessageByCarId:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:GETWZMESSAGEBYCARID_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//预约违章接口 \预约年审接口
+(void)addOrderByAuditAndRules:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:ADDORDERBYAUDITANDRULES_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取年审类型和费用
+(void)getCarVerificationMoney:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:GETCARVERIFICATIONMONEY_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//查询门店列表
+(void)appFindStore:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:APPFINDSTORE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//获取车务（年审，违章，维修）客户列表
+(void)getelectCarTransactionList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTCARTRANSACTIONLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取车务详情
+(void)getCarTransaction:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:GETCARTRANSACTION_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取三大案件列表
+(void)getThreeCaseApplyList:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SELECTTHREECASEAPPLYLIST_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取三大案件详情
+(void)getThreeCaseApply:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:GETTHREECASEAPPLY_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

#pragma mark 门店

//上传图片
+(void)appUploadPicture:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
//    [self getRequest:APPUPLOADPICTURE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
//        success(response);
//    } fail:^(id error) {
//        fail(error);
//    }];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (header) {
        [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer.timeoutInterval = 180.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:APPUPLOADPICTURE_API parameters:nil  constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSArray *filePathArr = paramenter[@"file"];
        
        for (int i = 0; i < filePathArr.count; i++) {
            NSData *imageData = filePathArr[i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressControll showProgressWithText:[NSString stringWithFormat:@"上传图片 "]];
        });
        NSLog(@"downloadProgress-->%@",uploadProgress);
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        NSLog(@"responseObject-->%@",responseObject);
        success(responseObject);
        [ProgressControll dismissProgress];
        //上传成功
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        NSLog(@"error-->%@",error);
        fail(error);
        [ProgressControll dismissProgress];

    }];
    
    [task resume];

    
}
//删除上传图片
+(void)deletePictureByUrl:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:DELETEPICTUREBYURL_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//获取门店详情
+(void)getShopsInfo:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    [self getRequest:SHOPSDETAIL_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//修改门店详情
+(void)postUpdateStore:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:SHOPUPDATESTORE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//获取门店服务信息
+(void)getStoreService:(NSDictionary *)paramenter header:(NSString *)header success:(void (^)(id))success fail:(void (^)(id))fail
{
    
    [self getRequest:SHOPSSERVICE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//编辑服务
+(void)updateService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:UPDATESERVICE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//查询可添加服务
+(void)queryServiceByStoreId:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:QUERYSERVICEBYSTOREID_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}
//添加服务
+(void)insertService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:INSERTSERVICE_API isPOST:YES paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

//删除服务
+(void)deleteStoreService:(NSDictionary *)paramenter header:(NSString *)header success:(void(^)(id response))success fail:(void(^)(id error))fail
{
    [self getRequest:DELETESTORESERVICE_API isPOST:NO paramenter:paramenter header:header success:^(id response) {
        success(response);
    } fail:^(id error) {
        fail(error);
    }];
}

@end
