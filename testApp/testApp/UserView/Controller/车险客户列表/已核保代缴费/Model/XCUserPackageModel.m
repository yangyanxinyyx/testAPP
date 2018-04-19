//
//  XCUserPackageModel.m
//  testApp
//
//  Created by Melody on 2018/4/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserPackageModel.h"

@implementation XCUserPackageModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"packageID" : @"id",
             };
}

@end
