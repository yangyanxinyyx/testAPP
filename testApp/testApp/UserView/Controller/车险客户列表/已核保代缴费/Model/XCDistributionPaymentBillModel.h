//
//  XCDistributionPaymentBillModel.h
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDistributionPaymentBillModel : NSObject

/** 保单ID long */
@property (nonatomic, strong) NSNumber * policyId ;

/** 预借款金额 double*/
@property (nonatomic, strong) NSNumber * borrowMoney ;

/** 保单金额 double */
@property (nonatomic, strong) NSNumber * policyTotalAmount ;

/** 缴费通知单号 */
@property (nonatomic, copy) NSString * payNoticeNo;

// =================== modify by Liangyz 非必填
/** 礼包行为(赠送、购买、无) */
@property (nonatomic, copy) NSString * packageGiveOrBuy;

/** 礼包购买价格 double */
@property (nonatomic, strong) NSNumber * packageBuyPrice ;

/** 礼包ID long */
@property (nonatomic, strong) NSNumber * packageId ;
// ===================

/** 收件客户名称 */
@property (nonatomic, copy) NSString * receiverName;

/** 联系电话 */
@property (nonatomic, copy) NSString * phone;

/** 预约配送时间 */
@property (nonatomic, copy) NSString * shipmentTime;

///** 预借款金额 double 已存在*/
//@property (nonatomic, strong) NSNumber * borrowMoney ;

/** 收款金额 double */
@property (nonatomic, strong) NSNumber * receiveMoney ;

// =================== modify by Liangyz 非必填
/** 配送地址 */
@property (nonatomic, copy) NSString * address;

/** 配送备注 */
@property (nonatomic, copy) NSString * remark;

/** 预借款审核备注 */
@property (nonatomic, copy) NSString * borrowRemark;
// ===================

@end
