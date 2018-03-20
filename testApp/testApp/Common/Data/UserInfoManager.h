//
//  UserInfoManager.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

@property (nonatomic,strong) NSString *ticketID;     //每次调接口都要刷新

@property (nonatomic,strong) NSString *code;
@property (nonatomic,assign) NSInteger employeeId;
@property (nonatomic,strong) NSString *employeeName;
@property (nonatomic,strong) NSString *iconUrl;
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *isStoreAdministrator;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *needModifyPwsNextLogin;
@property (nonatomic,strong) NSString *noModifyPsw;
@property (nonatomic,strong) NSString *phone;

@property (nonatomic,assign) BOOL isStore;         //是否是门店 下面的属性是门店才有的

@property (nonatomic,strong) NSString *storeID;
@property (nonatomic,strong) NSString *storeName;
@property (nonatomic,strong) NSString *storeCode;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *corporateName;
@property (nonatomic,strong) NSString *corporateCellphone;
@property (nonatomic,strong) NSString *address;











+ (UserInfoManager *)shareInstance;

@end
