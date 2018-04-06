//
//  XCCheckoutDetailBaseModel.h
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCheckoutDetailBaseModel : NSObject

/** 投保人 */
@property (nonatomic, copy) NSString * userName;

/** 身份证 */
@property (nonatomic, copy) NSString * userIDCard;

/** 车牌号 */
@property (nonatomic, copy) NSString * carNumber;

/** 车架号 */
@property (nonatomic, copy) NSString * carTypeNumber;

/** 初登日期 */
@property (nonatomic, copy) NSString * firstDate;

/** 发动机号 */
@property (nonatomic, copy) NSString * carEngineNumber;

/** 车型名称 */
@property (nonatomic, copy) NSString * carOfType;

/** (商业)起保日期 */
@property (nonatomic, copy) NSString * carBussinessPolicyStartDate;

/** (交强)起保日期 */
@property (nonatomic, copy) NSString * carCommonPolicyStartDate;

/** 保险公司 */
@property (nonatomic, copy) NSString * insuranceCompany;

/** 缴费通知单号 */
@property (nonatomic, copy) NSString * paymentMenu;

/** 交强险金额 */
@property (nonatomic, copy) NSString * carCommonPolicyMoney;

/** 商业险金额 */
@property (nonatomic, copy) NSString * carBunissionPolicyMoney;

/** 是否续保 */
@property (nonatomic, assign) BOOL  isContinue ;


@end
