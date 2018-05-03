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

+ (NSMutableAttributedString *)stringWithImportentValue:(NSString *)text
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",text]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,1)];
    [str addAttribute:NSForegroundColorAttributeName value:COLOR_RGB_255(68, 68, 68) range:NSMakeRange(1,text.length - 1)];
    [str addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"PingFang-SC-Medium" size:28 * ViewRateBaseOnIP6]
                          range:NSMakeRange(1,text.length - 1)];
    

    
    return str;
}

+ (NSMutableAttributedString *)stringWithImportentValue:(NSString *)text fontSize:(CGFloat)size
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",text]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,1)];
    [str addAttribute:NSForegroundColorAttributeName value:COLOR_RGB_255(68, 68, 68) range:NSMakeRange(1,text.length - 1)];
    [str addAttribute:NSFontAttributeName
                value:[UIFont fontWithName:@"PingFang-SC-Medium" size:size * ViewRateBaseOnIP6]
                range:NSMakeRange(1,text.length - 1)];
    
    
    
    return str;
}

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}


@end


@implementation NSString (Validate)

/**
 *    @brief    固定电话区号格式化（将形如 01085792889 格式化为 010-85792889）
 *
 *    @return    返回格式化后的号码（形如 010-85792889）
 */
- (NSString*)areaCodeFormat
{
    // 先去掉两边空格
    NSMutableString *value = [NSMutableString stringWithString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    // 先匹配是否有连字符/空格，如果有则直接返回
    NSString *regex = @"^0\\d{2,3}[- ]\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if([predicate evaluateWithObject:value]){
        // 替换掉中间的空格
        return [value stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    }
    
    // 格式化号码 三位区号
    regex = [NSString stringWithFormat:@"^(%@)\\d{7,8}$",[self regex_areaCode_threeDigit]];
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:value]){
        // 插入连字符 "-"
        [value insertString:@"-" atIndex:3];
        return value;
    }
    
    
    // 格式化号码 四位区号
    regex = [NSString stringWithFormat:@"^(%@)\\d{7,8}$",[self regex_areaCode_fourDigit]];
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:value]){
        // 插入连字符 "-"
        [value insertString:@"-" atIndex:4];
        return value;
    }
    
    return nil;
}



/**
 *    @brief    获取三位数区号的正则表达式（三位数区号形如 010）
 */
- (NSString*)regex_areaCode_threeDigit
{
    return @"010|02[0-57-9]";
}
/**
 *    @brief    获取四位数区号的正则表达式（四位数区号形如 0311）
 */
- (NSString*)regex_areaCode_fourDigit
{
    // 03xx
    NSString *fourDigit03 = @"03([157]\\d|35|49|9[1-68])";
    // 04xx
    NSString *fourDigit04 = @"04([17]\\d|2[179]|[3,5][1-9]|4[08]|6[4789]|8[23])";
    // 05xx
    NSString *fourDigit05 = @"05([1357]\\d|2[37]|4[36]|6[1-6]|80|9[1-9])";
    // 06xx
    NSString *fourDigit06 = @"06(3[1-5]|6[0238]|9[12])";
    // 07xx
    NSString *fourDigit07 = @"07(01|[13579]\\d|2[248]|4[3-6]|6[023689])";
    // 08xx
    NSString *fourDigit08 = @"08(1[23678]|2[567]|[37]\\d|5[1-9]|8[3678]|9[1-8])";
    // 09xx
    NSString *fourDigit09 = @"09(0[123689]|[17][0-79]|[39]\\d|4[13]|5[1-5])";
    
    return [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@",fourDigit03,fourDigit04,fourDigit05,fourDigit06,fourDigit07,fourDigit08,fourDigit09];
    
}

+ (NSString*)getTheCorrectMoneyNum:(NSString*)tempString{
    if ([tempString isEqualToString:@"0"]) {
        return tempString;
        
    }
    if ([tempString hasPrefix:@"."]) {
        tempString = [NSString stringWithFormat:@"0%@",tempString];

    }
    NSUInteger endLength = tempString.length;
    if ([tempString containsString:@"."]){
        NSRange pointRange = [tempString rangeOfString:@"."]; NSLog(@"%lu",pointRange.location);
        NSUInteger f = tempString.length - 1 - pointRange.location;
        if (f > 2) {
            endLength = pointRange.location + 2 + 1;
        }
    }
    NSUInteger start = 0;
    const char *tempChar = [tempString UTF8String];
    for (int i = 0; i < tempString.length; i++) {
        if (tempChar[i] == '0') {
            start++;
        }else{
        break;
        }
    }
    if (tempChar[start] == '.') {
        start--;
    }
    //根据最终的开始位置,计算长度,并截取
    NSRange range = {start,endLength-start};
    tempString = [tempString substringWithRange:range];
    return tempString;

}
@end
