//
//  XCCustomerRepairViewController.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"
#import "XCCustomerDetailModel.h"
#import <AMapLocationKit/AMapLocationKit.h>
@interface XCCustomerRepairViewController : XCUserBaseViewController

@property (nonatomic, strong) XCCustomerDetailModel * model ;
/** <# 注释 #> */
@property (nonatomic, assign) CLLocation * location ;

@end
