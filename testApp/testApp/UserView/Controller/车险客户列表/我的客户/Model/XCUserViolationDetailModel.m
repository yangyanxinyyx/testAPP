//
//  XCUserViolationDetailModel.m
//  testApp
//
//  Created by Melody on 2018/4/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserViolationDetailModel.h"

@implementation XCUserViolationDetailModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"buckleScores" : @"fen",
             @"weizhangDate" : @"date",
             @"weizhangArea" : @"area",
             @"weizhangCity" : @"wzcity",
             @"weizhangClause" : @"act",


             };
}

@end
