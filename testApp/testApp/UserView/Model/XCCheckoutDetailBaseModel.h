//
//  XCCheckoutDetailBaseModel.h
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

//待核保详细Model
@interface XCCheckoutDetailBaseModel : NSObject

/** 保单id */
@property (nonatomic, assign) long BillID;

//基本信息
/** 投保人 */
@property (nonatomic, copy) NSString * onwerName;

/** 身份证 */
@property (nonatomic, copy) NSString * onwerIdentify;

/** 车牌号 */
@property (nonatomic, copy) NSString * plateNo;

/** 车架号 */
@property (nonatomic, copy) NSString * vinNo;

/** 初登日期 */
@property (nonatomic, copy) NSString * recordDate;

/** 发动机号 */
@property (nonatomic, copy) NSString * engineNo;

/** 车型名称 */
@property (nonatomic, copy) NSString * model;

/** 车型代码 */
@property (nonatomic, copy) NSString * model2;

/** (商业)起保日期 */
@property (nonatomic, copy) NSString * syEffectDate;

/** (交强)起保日期 */
@property (nonatomic, copy) NSString * jqEffectDate;

/** 保险公司 */
@property (nonatomic, copy) NSString * insurerName;

/** 缴费通知单号 */
@property (nonatomic, copy) NSString * payNoticeNo;

/** 交强险(业务员)金额 */
@property (nonatomic, copy) NSString * jqMoney;

/** 商业险(业务员)金额 */
@property (nonatomic, copy) NSString * syMoney;

/** 交强险(出单员)金额 */
@property (nonatomic, copy) NSString * jqMoneyExport;

/** 商业险(出单员)金额 */
@property (nonatomic, copy) NSString * syMoneyExport;

/** 出单员名称 */
@property (nonatomic, copy) NSString * exportmanName;

/** 是否续保 Y N */
@property (nonatomic, copy) NSString * isContinue ;

// 保单信息
/** 交强险 */
@property (nonatomic, copy) NSString * jqValue;

/** 机动车损险 */
@property (nonatomic, copy) NSString * csValue;

/** 第三责任损险 */
@property (nonatomic, copy) NSString * szValue;

/** 车上(司机)险 */
@property (nonatomic, copy) NSString * cssjValue;

/** 车上(乘客)险 */
@property (nonatomic, copy) NSString * csckValue;


@end
