//
//  XCCustomerViolationPreviewViewController.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"
#import "XCCustomerDetailModel.h"
@interface XCCustomerViolationPreviewViewController : XCUserBaseViewController

/** <# 注释 #> */
@property (nonatomic, strong) XCCustomerDetailModel * model ;

/** 违章地点 */
@property (nonatomic, copy) NSString * area ;
/** 违章城市 */
@property (nonatomic, copy) NSString * wzcity;
/** 违章分数 */
@property (nonatomic, copy) NSString * fen;
/** 违章条款 */
@property (nonatomic, copy) NSString * act;

@end
