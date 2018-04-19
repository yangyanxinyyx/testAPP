//
//  XCUserCaseListModel.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUserCaseListModel : NSObject

/** 案件详情id long */
@property (nonatomic, strong) NSNumber * caseID ;

/** 车主ID long */
@property (nonatomic, strong) NSNumber * customerId;

/** 车主姓名 */
@property (nonatomic, copy) NSString * customerName;

/** 案件发生时间 */
@property (nonatomic, copy) NSString * occurTime;

/** 处理状态 */
@property (nonatomic, copy) NSString * status;

@end
