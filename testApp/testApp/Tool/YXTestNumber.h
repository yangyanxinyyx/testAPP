//
//  YXTestNumber.h
//  BoleClub
//
//  Created by dt_ios_dev on 16/7/22.
//  Copyright © 2016年 BC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXTestNumber : NSObject

/**
 手机号码格式

 @param mobile 手机号码
 @return 字符串
 */
+ (NSString *)testingMobile:(NSString *)mobile;

/**
 身份证格式

 @param IDCardNumber 身份证号码
 @return BOOL YES 格式正确
 */
+ (BOOL)testingIdentutyCard:(NSString *)IDCardNumber;

/**
 车牌号格式

 @param numberPlate 车牌号号码
 @return BOOL YES 格式正确
 */
+ (BOOL)testingNumberPlate:(NSString *)numberPlate;

/**
 银行卡格式

 @param bankCardID 银行卡号码
 @return BOOL YES 格式正确
 */
+ (BOOL)testingBankCard:(NSString *)bankCardID;

/**
 邮件格式

 @param emailID 邮件号码
 @return BOOL YES 格式正确
 */
+ (BOOL)testingEmail:(NSString *)emailID;


/**
 密码格式 是否是有英文和 数字结合的

 @param password 密码
 @param count 最大长度
 @return BOOL
 */
+ (BOOL)testingPassword:(NSString *)password count:(NSInteger )count;

@end
