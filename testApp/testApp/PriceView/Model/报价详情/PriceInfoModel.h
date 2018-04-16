//
//  PriceInfoModel.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/10.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "priceModel.h"
@interface PriceInfoModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isMianpei;
@property (nonatomic, assign) double number;
@property (nonatomic, strong) NSString *isToubao;
@property (nonatomic, strong) priceModel *model;
@property (nonatomic, assign) double priceValue;

@end
