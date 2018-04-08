//
//  PriceRecodeModel.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceRecodeModel : NSObject
@property (nonatomic, strong) NSNumber *creatorId; //long
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSNumber *updaterId;
@property (nonatomic, strong) NSString *updaterName;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSNumber *recodeID; //记录ID
@property (nonatomic, strong) NSNumber *customerId;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSNumber *carId;
@property (nonatomic, strong) NSString *offerName;
@property (nonatomic, strong) NSString *offerTime;
@property (nonatomic, strong) NSNumber *offerVciPrice;
@property (nonatomic, strong) NSNumber *offerTciPrice;
@property (nonatomic, strong) NSNumber *offerTotalPrice;
@property (nonatomic, strong) NSString *offerDiscountPrice;
@property (nonatomic, strong) NSString *offerPictureUrl;
@property (nonatomic, strong) NSString *disable;
@property (nonatomic, strong) NSString *poSource;
@property (nonatomic, strong) NSString *jqIsSelect;
@property (nonatomic, strong) NSString *csIsSelect;
@property (nonatomic, strong) NSNumber *csValue;
@property (nonatomic, strong) NSString *csWithout;
@property (nonatomic, strong) NSString *dqIsSelect;
@property (nonatomic, strong) NSNumber *dqValue;
@property (nonatomic, strong) NSString *dqWithout;
@property (nonatomic, strong) NSString *szIsSelect;
@property (nonatomic, strong) NSNumber *szValue;
@property (nonatomic, strong) NSString *szWithout;
@property (nonatomic, strong) NSString *cssjIsSelect;
@property (nonatomic, strong) NSNumber *cssjValue;
@property (nonatomic, strong) NSString *cssjWithout;
@property (nonatomic, strong) NSString *csckIsSelect;
@property (nonatomic, strong) NSNumber *csckValue;
@property (nonatomic, strong) NSString *csckWithout;
@property (nonatomic, strong) NSString *cshhIsSelect;
@property (nonatomic, strong) NSNumber *cshhWithout;
@property (nonatomic, strong) NSString *cshhValue;
@property (nonatomic, strong) NSString *blpsIsSelect;
@property (nonatomic, strong) NSString *blpsValue;
@property (nonatomic, strong) NSString *fdjssIsSelect;
@property (nonatomic, strong) NSNumber *fdjssValue;
@property (nonatomic, strong) NSString *fdjssWithout;
@property (nonatomic, strong) NSString *wfzddsfIsSelect;
@property (nonatomic, strong) NSString *zrxIsSelect;
@property (nonatomic, strong) NSNumber *zrxValue;
@property (nonatomic, strong) NSString *zrxWithout;

@end
