//
//  XCCarTransactioDetailModel.h
//  testApp
//
//  Created by Melody on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCarTransactioDetailModel : NSObject
/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;

/** 车牌号 */
@property (nonatomic, copy) NSString * plateNo;

/** 车品牌 */
@property (nonatomic, copy) NSString * brand;

/** 车架号 */
@property (nonatomic, copy) NSString * vinNo;

/** 发动机号 */
@property (nonatomic, copy) NSString * engineNo;

/** 车型代码 */
@property (nonatomic, copy) NSString * model;

/** 联系电话 */
@property (nonatomic, copy) NSString * phone;

/** 年审到期时间 */
@property (nonatomic, copy) NSString * motTestTime;

/** 备注 */
@property (nonatomic, copy) NSString * remark;

/** 图片1 */
@property (nonatomic, copy) NSString * url1;

/** 图片2 */
@property (nonatomic, copy) NSString * url2;

/** 图片3 */
@property (nonatomic, copy) NSString * url3;

/** 图片4 */
@property (nonatomic, copy) NSString * url4;

/** 状态 */
@property (nonatomic, copy) NSString * status;

/** 违章时间 */
@property (nonatomic, copy) NSString * weizhangDate;

/** 预约时间 */
@property (nonatomic, copy) NSString * appointmentTime;

/** 违章地点 */
@property (nonatomic, copy) NSString * weizhangArea;

/** 总费用 long*/
@property (nonatomic, strong) NSNumber * orderPrice;

/** 门店名称 */
@property (nonatomic, copy) NSString * storeName;

/** 违章分数 int*/
@property (nonatomic, strong) NSNumber * buckleScores ;

/** 违章条款 */
@property (nonatomic, copy) NSString * weizhangClause;

/** 违章城市 */
@property (nonatomic, copy) NSString * weizhangCity;

//违章
//缺少违章费用 、 违章条款

//维修
//接车时间、地址、预计完成时间、维修项目
@end
