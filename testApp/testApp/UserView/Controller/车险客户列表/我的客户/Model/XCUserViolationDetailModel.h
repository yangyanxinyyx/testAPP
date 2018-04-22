//
//  XCUserViolationDetailModel.h
//  testApp
//
//  Created by Melody on 2018/4/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUserViolationDetailModel : NSObject
/** 客户id */
@property (nonatomic, strong) NSNumber * customerId ;
/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;
/** 联系方式 */
@property (nonatomic, copy) NSString * phone;
/** 联系人 */
@property (nonatomic, copy) NSString * contacts;
/** 车辆id */
@property (nonatomic, strong) NSNumber * carId ;
/** 车牌号 */
@property (nonatomic, copy) NSString * plateNo;
/** 描述 */
@property (nonatomic, copy) NSString * remark;
/** 违章扣分 */
@property (nonatomic, strong) NSNumber * buckleScores ;
/** 违章时间 */
@property (nonatomic, copy) NSString * weizhangDate;
/** 违章地点 */
@property (nonatomic, copy) NSString * weizhangArea;
/** 违章城市 */
@property (nonatomic, copy) NSString * weizhangCity;
/** 违章条款 */
@property (nonatomic, copy) NSString * weizhangClause;

//查询违章
/** 状态 */
@property (nonatomic, strong) NSString * handled ;

@end
