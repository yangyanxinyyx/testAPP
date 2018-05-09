//
//  XCCustomerListModel.h
//  testApp
//
//  Created by Melody on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCustomerListModel : NSObject

/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;

/** 车牌号 */
@property (nonatomic, copy) NSString * plateNo;

/** 品牌型号 */
@property (nonatomic, copy) NSString * brand;

/** 跟进时间  */
@property (nonatomic, copy) NSString * nextFollowTime;

/** 联系方式 */
@property (nonatomic, copy) NSString * phoneNo;

/** 客户id  long*/
@property (nonatomic, strong) NSNumber * customerId ;

/** 车辆id long */
@property (nonatomic, strong) NSNumber * carId ;

/** 客户跟进状态 状态（新客户、跟进中）*/
@property (nonatomic, copy) NSString * status;
@end
