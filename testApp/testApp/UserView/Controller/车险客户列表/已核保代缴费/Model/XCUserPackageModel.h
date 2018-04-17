//
//  XCUserPackageModel.h
//  testApp
//
//  Created by Melody on 2018/4/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUserPackageModel : NSObject
/** 礼包id */
@property (nonatomic, strong) NSNumber * packageID ;

/** 礼包编号 */
@property (nonatomic, copy) NSString * code;

/** 礼包名称 */
@property (nonatomic, copy) NSString * name;

/** 礼包等级 */
@property (nonatomic, copy) NSString * vipLevel;

/** 礼包价格 */
@property (nonatomic, copy) NSString * price;
@end
