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
@property (nonatomic, strong) NSNumber * BillID;

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
@property (nonatomic, copy) NSString * brand;

/** 车型代码 */
@property (nonatomic, copy) NSString * model;

/** (商业)起保日期 */
@property (nonatomic, copy) NSString * syEffectDate;

/** (交强)起保日期 */
@property (nonatomic, copy) NSString * jqEffectDate;

/** 保险公司 */
@property (nonatomic, copy) NSString * insurerName;

/** 缴费通知单号 */
@property (nonatomic, copy) NSString * payNoticeNo;

/** 交强险保单金额(业务员) */
@property (nonatomic, strong) NSNumber * jqMoney;

/** 商业险保单金额(业务员) */
@property (nonatomic, strong) NSNumber * syMoney;

/** 交强险(出单员)金额 */
@property (nonatomic, strong) NSNumber * jqMoneyExport;

/** 商业险(出单员)金额 */
@property (nonatomic, strong) NSNumber * syMoneyExport;

/** 交强险保单最终金额（财务） */
@property (nonatomic, strong) NSNumber * jqMoneyFinal;

/** 商业险保单最终金额（财务） */
@property (nonatomic, strong) NSNumber * syMoneyFinal;

/** 交强险保单号 */
@property (nonatomic, copy) NSString * jqNumber;

/** 商业险保单号 */
@property (nonatomic, copy) NSString * syNumber;

/** 是否续保 Y N */
@property (nonatomic, copy) NSString * isContinue ;

/** 交强险佣金 double*/
@property (nonatomic, strong) NSNumber * jqBonus;

/** 商业险佣金 double*/
@property (nonatomic, strong) NSNumber * syBonus;

/** 交强险提成 */
@property (nonatomic, strong) NSNumber * jqCommission ;

/** 商业险提成 */
@property (nonatomic, strong) NSNumber * syCommission ;

/** 出单员名称 */
@property (nonatomic, copy) NSString * exportmanName;

/** 备注 */
@property (nonatomic, copy) NSString * remark;

// 保单信息
/** 交强险 */
@property (nonatomic, copy) NSNumber * jqValue;

/** 机动车损险 */
@property (nonatomic, copy) NSNumber * csValue;

/** 第三责任损险 */
@property (nonatomic, copy) NSNumber * szValue;

/** 车上(司机)险 */
@property (nonatomic, copy) NSNumber * cssjValue;

/** 车上(乘客)险 */
@property (nonatomic, copy) NSNumber * csckValue;


@end
