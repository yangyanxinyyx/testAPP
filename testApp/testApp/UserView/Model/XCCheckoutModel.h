//
//  XCCheckoutModel.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCheckoutModel : NSObject

/** 车牌 */
@property (nonatomic, copy) NSString * userCarNumber ;
/** 车主 */
@property (nonatomic, copy) NSString * userName ;
/** 出单时间 */
@property (nonatomic, copy) NSString * issueTime ;


@end
