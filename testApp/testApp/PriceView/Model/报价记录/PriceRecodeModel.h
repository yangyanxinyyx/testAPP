//
//  PriceRecodeModel.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceRecodeModel : NSObject
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *offerName;
@property (nonatomic, strong) NSString *offerTime;
@property (nonatomic, strong) NSString *quoteGroup;
@property (nonatomic, strong) NSString *blType;
@property (nonatomic, assign) NSString *priceRecodeID;

@property (nonatomic, assign) double offerVciPrice; //商业险金额
@property (nonatomic, assign) double offerTotalPrice; //总金额
@end
