//
//  GetCarDetailModel.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCarDetailModel : NSObject

@property (nonatomic,strong) NSNumber *orderID;
@property (nonatomic,strong) NSNumber *customerId;
@property (nonatomic,strong) NSNumber *orderPrice;
@property (nonatomic,strong) NSNumber *carId;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *customerName;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *plateNo;
@property (nonatomic,strong) NSString *model;
@property (nonatomic,strong) NSArray *detailList;

@end
