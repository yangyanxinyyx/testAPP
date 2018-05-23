//
//  GetCarModel.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCarModel : NSObject

@property (nonatomic,strong) NSNumber *orderID;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *customerName;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *appointmentTime;
@property (nonatomic,strong) NSString *finishTime;
@property (nonatomic,strong) NSString *receptionTime;

@property (nonatomic,strong) NSString *useStatus;
@property (nonatomic,strong) NSString *plateNo;

@property (nonatomic,strong) NSNumber *customerId;
@property (nonatomic,strong) NSNumber *carId;
@property (nonatomic,strong) NSString *orderCategory;

@end
