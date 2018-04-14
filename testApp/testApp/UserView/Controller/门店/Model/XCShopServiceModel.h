//
//  XCShopServiceModel.h
//  testApp
//
//  Created by Melody on 2018/4/13.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCShopServiceModel : NSObject
/** 门店id */
@property (nonatomic, copy) NSString * storeID;
/** 服务id */
@property (nonatomic, copy) NSString * serviceId;
/** 服务名称 */
@property (nonatomic, copy) NSString * serviceName;
/** 服务类型 */
@property (nonatomic, copy) NSString * category;
/** 门店服务状态 */
@property (nonatomic, copy) NSString * status;
/** 普通价 */
@property (nonatomic, copy) NSString * price;
/** 会员价 */
@property (nonatomic, copy) NSString * vipPrice;
/** 图片 */
@property (nonatomic, copy) NSString * url1;
@end
