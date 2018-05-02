//
//  NSString+MoneyString.h
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MoneyString)

+ (NSString *)stringWithMoneyNumber:(double)money;

+ (NSMutableAttributedString *)stringWithImportentValue:(NSString *)text;
+ (NSMutableAttributedString *)stringWithImportentValue:(NSString *)text fontSize:(CGFloat)size;

+ (NSString *)getNowTimeTimestamp;

+ (NSString*)getTheCorrectMoneyNum:(NSString*)tempString;

@end

@interface NSString (Validate)

/**
 *    @brief    固定电话区号格式化（将形如 01085792889 格式化为 010-85792889）
 *
 *    @return    返回格式化后的号码（形如 010-85792889）
 */
- (NSString*)areaCodeFormat;


@end
