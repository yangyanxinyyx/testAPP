//
//  XCMyCommissionListModel.h
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCMyCommissionListModel : NSObject

/** 创建时间 */
@property (nonatomic, copy) NSString * createTime;

/** 车险业绩 */
@property (nonatomic, strong) NSNumber * carPerformance;
/** 车险佣金 */
@property (nonatomic, strong) NSNumber * carCommission ;
/** 车险提成 */
@property (nonatomic, strong) NSNumber * carRoyalties ;

/** 维修业绩 */
@property (nonatomic, strong) NSNumber * servicePerformance ;
/** 维修佣金 */
@property (nonatomic, strong) NSNumber * serviceCommission ;

/** 勋章奖励 */
@property (nonatomic, strong) NSNumber * medalBonus ;

+(XCMyCommissionListModel *)getMyCommissionListWithDataInfo:(NSDictionary *)data;

@end
