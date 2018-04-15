//
//  XCCarTransactionModel.h
//  testApp
//
//  Created by Melody on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCarTransactionModel : NSObject
/** 车务ID Long*/
@property (nonatomic, strong) NSNumber * carTransID;

/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;

/** 车牌号 */
@property (nonatomic, copy) NSString * plateOn;

/** 创建时间 */
@property (nonatomic, copy) NSString * createTime;


@end
