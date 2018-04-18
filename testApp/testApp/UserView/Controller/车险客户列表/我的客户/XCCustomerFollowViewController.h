//
//  XCCustomerFollowViewController.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"

@interface XCCustomerFollowViewController : XCUserBaseViewController

/** 客户id */
@property (nonatomic, strong) NSNumber * customerID ;
/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;

/** 操作类型数据 */
@property (nonatomic, strong) NSArray * selectArr ;

@end
