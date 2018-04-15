//
//  XCDistributionBillModel.h
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
//配送保单 Model
@interface XCDistributionBillModel : NSObject

/** 保单ID long */
@property (nonatomic, strong) NSNumber * policyId;

/** 是否配送保单 */
@property (nonatomic, copy) NSString * isShipmentBaodan;

/** 收件客户名称 */
@property (nonatomic, copy) NSString * receiverName;

/** 联系电话 */
@property (nonatomic, copy) NSString * phone;

/** 预约配送时间 */
@property (nonatomic, copy) NSString * shipmentTime;

/** 收款金额 double */
@property (nonatomic, strong) NSNumber * receiveMoney ;

/** 配送地址 */
@property (nonatomic, copy) NSString * address;

/** 配送备注 */
@property (nonatomic, copy) NSString * remark;

/** 保单金额 double */
@property (nonatomic, strong) NSNumber * policyTotalAmount;

/** 刷卡日期 */
@property (nonatomic, copy) NSString * payDate;

/** 礼包行为（赠送、购买、无) */
@property (nonatomic, copy) NSString * packageGiveOrBuy;

/** 礼包购买价格 double */
@property (nonatomic, strong) NSNumber * packageBuyPrice ;

/** 礼包ID long */
@property (nonatomic, strong) NSNumber * packageId;

@end
