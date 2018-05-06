//
//  XCShopServiceEditedServiceViewController.h
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"
#import "XCShopServiceModel.h"

@interface XCShopServiceEditedServiceViewController : XCUserBaseViewController
/** 判断是添加服务还是编辑服务 默认编辑服务 */
@property (nonatomic, assign) BOOL  isNewService ;
/** <# 注释 #> */
@property (nonatomic, strong) XCShopServiceModel * model;

//@property (nonatomic, strong) NSNumber * storeID ;

@end
