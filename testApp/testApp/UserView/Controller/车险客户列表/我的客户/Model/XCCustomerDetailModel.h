//
//  XCCustomerDetailModel.h
//  testApp
//
//  Created by Melody on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCustomerDetailModel : NSObject

/** 客户详情 */
@property (nonatomic, copy) NSString * customerName;

/** 客户来源 */
@property (nonatomic, copy) NSString * source;

/** 性别 */
@property (nonatomic, copy) NSString * sex;

/** 生日 */
@property (nonatomic, copy) NSString * birthday;

/** 区域 */
@property (nonatomic, copy) NSString * area;

/** 地址 */
@property (nonatomic, copy) NSString * address;

/** 身份证 */
@property (nonatomic, copy) NSString * identity;

/** 车牌号 */
@property (nonatomic, copy) NSString * plateNo;

/** 车品牌 */
@property (nonatomic, copy) NSString * brand;

/** 初登日期 */
@property (nonatomic, copy) NSString * recordDate;

/** 车架号 */
@property (nonatomic, copy) NSString * vinNo;

/** 发动机号 */
@property (nonatomic, copy) NSString * engineNo;

/** 车型代码 */
@property (nonatomic, copy) NSString * model;

/** 车id long*/
@property (nonatomic, strong) NSNumber * carId ;

/** 联系方式 */
@property (nonatomic, copy) NSString * phoneNo;

@end
