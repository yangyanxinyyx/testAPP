//
//  GetCarModel.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarModel.h"

@implementation GetCarModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if (key) {
        if([key isEqualToString:@"id"]) {
            _orderID = value;
        }
    }

} 

@end
