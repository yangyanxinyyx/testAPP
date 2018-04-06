//
//  XCCheckoutDetailPolicyModel.h
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCheckoutDetailPolicyModel : NSObject

/** 交强险 */
@property (nonatomic, copy) NSString * commonPolicy;
/** 机动车损险 */
@property (nonatomic, copy) NSString * enginePolicy;
/** 第三责任险 */
@property (nonatomic, copy) NSString * thridPersonDutyPolicy;
/** 车上(司机)险 */
@property (nonatomic, copy) NSString * dirverPolicy;
/** 车上(乘客)险 */
@property (nonatomic, copy) NSString * comsumerPolicy;

@end
