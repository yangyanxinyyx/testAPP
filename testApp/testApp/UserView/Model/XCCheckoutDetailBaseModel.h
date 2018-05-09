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

/** 创建日期 */
@property (nonatomic, copy) NSString * createTime;

/** 初登日期 */
@property (nonatomic, copy) NSString * recordDate;

/** 发动机号 */
@property (nonatomic, copy) NSString * engineNo;

/** 品牌型号 */
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

/** 保单状态 */
@property (nonatomic, copy) NSString * policyStatus;

/** 财务审核状态 */
@property (nonatomic, copy) NSString * financeRemark;

// 保单信息
/** 交强险 double*/
@property (nonatomic, copy) NSNumber * jqValue;

/** 机动车损险 */
@property (nonatomic, copy) NSNumber * csValue;

/** 第三责任损险 */
@property (nonatomic, copy) NSNumber * szValue;

/** 车上(司机)险 */
@property (nonatomic, copy) NSNumber * cssjValue;

/** 车上(乘客)险 */
@property (nonatomic, copy) NSNumber * csckValue;


//退单添加
/** 客户id long*/
@property (nonatomic, strong) NSNumber * customerId ;
/** 客户手机 */
@property (nonatomic, copy) NSString * phoneNo;
/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;
/** 业务员id long*/
@property (nonatomic, strong) NSNumber * salesmanId ;
/** 业务员名称 */
@property (nonatomic, copy) NSString * salesmanName;
/** 车id long*/
@property (nonatomic, strong) NSNumber * carId ;
/** 分公司ID long*/
@property (nonatomic, strong)  NSNumber* companyId ;
/** 出单日期 */
@property (nonatomic, copy) NSString * exportDate;
/** 出单机构ID */
@property (nonatomic, copy) NSString * exportUnitId;
/** 出单机狗 */
@property (nonatomic, copy) NSString * exportUnitName;
/** 保险公司id long*/
@property (nonatomic, strong) NSNumber * insurerId ;
/** 退回备注 */
@property (nonatomic, copy) NSString * rejectRemark;
/** 是否选择交强险 */
@property (nonatomic, copy) NSString * jqIsSelect;

/** 是否不计免赔(交强险) */
@property (nonatomic, copy) NSString * jqWithout;
/** 是否选择车损险 */
@property (nonatomic, copy) NSString * csIsSelect;
/** 是否不计免赔(车损险) */
@property (nonatomic, copy) NSString * csWithout;
/** 是否选择盗抢险 */
@property (nonatomic, copy) NSString * dqIsSelect;
/** 盗抢险保额 double*/
@property (nonatomic, copy) NSNumber * dqValue;
/** 是否不计免赔(盗抢险) */
@property (nonatomic, copy) NSString * dqWithout;
/** 是否选择三者险 */
@property (nonatomic, copy) NSString * szIsSelect;
/** 是否不计免赔（三者险） */
@property (nonatomic, copy) NSString * szWithout;
/** 是否选择车上司机险 */
@property (nonatomic, copy) NSString * cssjIsSelect;
/** 是否不计免赔（车上司机险）  */
@property (nonatomic, copy) NSString * cssjWithout;
/** 是否选择车上乘客险 */
@property (nonatomic, copy) NSString * csckIsSelect;
/** 是否不计免赔（车上乘客险） */
@property (nonatomic, copy) NSString * csckWithout;
/** 是否选择车身划痕险 */
@property (nonatomic, copy) NSString * cshhIsSelect;
/** 车上划痕险保额 double */
@property (nonatomic, strong) NSNumber * cshhValue ;
/** 是否不计免赔（车身划痕险） */
@property (nonatomic, copy) NSString * cshhWithout;
/** 是否选择玻璃破碎险 */
@property (nonatomic, copy) NSString * blpsIsSelect;
/** 玻璃破碎险保额 */
@property (nonatomic, copy) NSString * blpsValue;
/** 是否不计免赔（玻璃破碎险） */
@property (nonatomic, copy) NSString * blpsWithout;
/** 是否选择发动机涉水险 */
@property (nonatomic, copy) NSString * 是否选择发动机涉水险;
/** 发动机涉水险保额 */
@property (nonatomic, strong) NSNumber * fdjssValue;
/** 是否不计免赔（发动机涉水险） */
@property (nonatomic, copy) NSString * fdjssWithout;
/** 是否选择无法找到第三方险 */
@property (nonatomic, copy) NSString * wfzddsfIsSelect;
/** 无法找到第三方险 double*/
@property (nonatomic, strong) NSNumber * wfzddsfValue ;
/** 是否不计免赔（无法找到第三方险) */
@property (nonatomic, copy) NSString * wfzddsfWithout;
/** 是否选择自燃险 */
@property (nonatomic, copy) NSString * zrxIsSelect;
/** 自燃险保额 double*/
@property (nonatomic, strong) NSNumber * zrxValue ;
/** 是否不计免赔（自燃险） */
@property (nonatomic, copy) NSString * zrxWithout;

@end
