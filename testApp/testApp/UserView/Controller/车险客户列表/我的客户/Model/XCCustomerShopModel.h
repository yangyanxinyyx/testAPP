//
//  XCCustomerShopModel.h
//  testApp
//
//  Created by Melody on 2018/4/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCustomerShopModel : NSObject

/** 门店ID */
@property (nonatomic, strong)  NSNumber* shopID ;
/** 门店名称 */
@property (nonatomic, copy) NSString * name;
/** 门店编号 */
@property (nonatomic, copy) NSString * code;
/** 电话 */
@property (nonatomic, copy) NSString * tel;
/** 地址 */
@property (nonatomic, copy) NSString * address;
/** 经度 */
@property (nonatomic, copy) NSString * longitude;
/** 纬度 */
@property (nonatomic, copy) NSString * latitude;
/** 距离 */
@property (nonatomic, strong) NSNumber * distance ;

@end
