//
//  XCCustomerDetailViewController.h
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"
#import "XCCustomerDetailModel.h"
@interface XCCustomerDetailViewController : XCUserBaseViewController
/** <# 注释 #> */
@property (nonatomic, strong) XCCustomerDetailModel * model ;

/** <# 类型描述  #> */
@property (nonatomic, assign) BOOL shouldClickFllowerBtn ;

@end
