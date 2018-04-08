//
//  GetCarDetailModel.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarDetailModel.h"

@implementation GetCarDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if (key) {
        if([key isEqualToString:@"id"]) {
            _orderID = value;
        }
    }

} 

@end
