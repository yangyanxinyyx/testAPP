//
//  XCUserCaseDetailTextCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCarTransactioDetailModel.h"
@interface XCUserCaseDetailTextCell : UITableViewCell
/** <# 注释 #> */
@property (nonatomic, copy) NSString * titleStr ;
/** 动态内容数组 */
@property (nonatomic, strong) NSMutableArray * labelArrM ;
/** 第二种类型 */
@property (nonatomic, assign) BOOL isMutableTextType ;


/**
 年审初配置
 */
- (void)setupCellWithCarTransactionDetailModel:(XCCarTransactioDetailModel *)model;
/**
 违章初配置
 */
- (void)setupCellWithViolationCarTranDetailModel:(XCCarTransactioDetailModel *)model;
/**
 维修初配置
 */
- (void)setupCellWithRepairCarTranDetailModel:(XCCarTransactioDetailModel *)model;

+ (CGFloat)getCellHeight;
@end
