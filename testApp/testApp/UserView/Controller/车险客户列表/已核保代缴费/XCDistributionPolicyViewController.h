//
//  XCDistributionPolicyViewController.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"

@interface XCDistributionPolicyViewController : XCUserBaseViewController

/** 商业险金额 */
@property (nonatomic, copy) NSString * syMoney ;

/** 交强险金额 */
@property (nonatomic, copy) NSString * jqMoney ;

/** 保单ID */
@property (nonatomic, strong) NSNumber * policyId ;

/** 礼包数据 */
@property (nonatomic, strong) NSArray * packageArr ;

@property (nonatomic, strong) XCCheckoutDetailBaseModel * model ;


@end
