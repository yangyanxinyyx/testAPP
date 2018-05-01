//
//  XCCustomerShopListView.h
//  testApp
//
//  Created by Melody on 2018/4/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "XCCustomerShopModel.h"
typedef void (^confirmBlock)(XCCustomerShopModel *model);

@interface XCCustomerShopListView : UIView

/** <# 注释 #> */
@property (nonatomic, strong) NSArray<XCCustomerShopModel *> * dataArr ;

- (instancetype)initWithDataArr:(NSArray *)dataArr confirmBlock:(confirmBlock)confirmBlock;

@end
