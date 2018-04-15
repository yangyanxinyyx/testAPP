//
//  XCCarTransactionModel.m
//  testApp
//
//  Created by Melody on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCarTransactionModel.h"

@implementation XCCarTransactionModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"carTransID" : @"id",
             };
}
@end
