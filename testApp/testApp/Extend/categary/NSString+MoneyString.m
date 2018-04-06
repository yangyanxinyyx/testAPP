//
//  NSString+MoneyString.m
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "NSString+MoneyString.h"

@implementation NSString (MoneyString)

+ (NSString *)stringWithMoneyNumber:(double)money{
    NSLocale* current = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    NSNumberFormatter*formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle=NSNumberFormatterCurrencyStyle;
    formatter.locale = current;
    NSString*newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:money]];
    return newAmount;
}

@end
