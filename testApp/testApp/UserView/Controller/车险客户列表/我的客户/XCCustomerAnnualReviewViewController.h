//
//  XCCustomerAnnualReviewViewController.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"
#import "XCCustomerDetailModel.h"
@interface XCCustomerAnnualReviewViewController : XCUserBaseViewController
@property (nonatomic, strong) XCCustomerDetailModel * model ;

/** 车辆类型选择 */
@property (nonatomic, strong) NSArray * dataArr ;
@end
