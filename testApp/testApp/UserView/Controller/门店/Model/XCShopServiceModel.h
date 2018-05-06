//
//  XCShopServiceModel.h
//  testApp
//
//  Created by Melody on 2018/4/13.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCShopServiceModel : NSObject
/** 门店服务关联id long*/
@property (nonatomic, strong) NSNumber * storeID;
/** 服务id long*/
@property (nonatomic, strong) NSNumber * serviceId;
/** 服务名称 */
@property (nonatomic, copy) NSString * serviceName;
/** 服务类型 */
@property (nonatomic, copy) NSString * category;
/** 服务原价 double */
@property (nonatomic, strong) NSNumber * servicePrice ;
/** 服务会员价 double */
@property (nonatomic, strong) NSNumber * serviceVipPrice ;
/** 门店服务状态 待审核、审核通过、审核不通过，下架 */
@property (nonatomic, copy) NSString * status;
/** 门店服务普通价 double*/
@property (nonatomic, copy) NSNumber * price;
/** 门店服务会员价 double*/
@property (nonatomic, copy) NSNumber * vipPrice;
/** 图片 */
@property (nonatomic, copy) NSString * url1;
/** 修改时间(提交时间，下架时间) */
@property (nonatomic, copy) NSString * updateTime;
/** 审核时间 */
@property (nonatomic, copy) NSString * auditingTime;
/** 服务介绍 */
@property (nonatomic, copy) NSString * introduction;
/** 拒绝备注 */
@property (nonatomic, copy) NSString * repulseRemark;

/** 添加服务用 默认NO*/
/** 上传服务name  */
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) BOOL  isSelect;
@end
