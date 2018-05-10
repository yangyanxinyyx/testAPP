//
//  YXTestNumber.m
//  BoleClub
//
//  Created by dt_ios_dev on 16/7/22.
//  Copyright © 2016年 BC. All rights reserved.
//

#import "YXTestNumber.h"

@implementation YXTestNumber
+ (NSString *)testingMobile:(NSString *)mobile{
    YXTestNumber *testNumber = [[YXTestNumber alloc]init];
   return  [testNumber valiMobile:mobile];
}

+ (BOOL)testingIdentutyCard:(NSString *)IDCardNumber{
    YXTestNumber *testNumber = [[YXTestNumber alloc] init];
    return [testNumber checkIDCardNumbe:IDCardNumber];
}

+ (BOOL)testingNumberPlate:(NSString *)numberPlate{
    YXTestNumber *testNumber = [[YXTestNumber alloc] init];
    return [testNumber checkCarID:numberPlate];
}

+ (BOOL)testingBankCard:(NSString *)bankCardID{
    YXTestNumber *testNumber = [[YXTestNumber alloc] init];
    return [testNumber isBankCard:bankCardID];
}

+ (BOOL)testingEmail:(NSString *)emailID{
    YXTestNumber *testNumber = [[YXTestNumber alloc] init];
    return [testNumber isEqual:emailID];
}

+ (BOOL)testingPassword:(NSString *)password count:(NSInteger)count{
    YXTestNumber *testNumber = [[YXTestNumber alloc] init];
    return [testNumber judgePassWordLegal:password count:count];
}

- (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length == 0) {
        return @"手机号码不能为空";
    }
    else if (mobile.length < 11)
    {
        return @"手机号码格式错误,请重新输入";
    }else{
        
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的手机号码";
        }
    }
    return nil;

    
}

// 身份证
-(BOOL)checkIDCardNumbe:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

//车牌号
- (BOOL)checkCarID:(NSString *)carID;
{
    if (carID.length!=7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{4}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carID];
    
    return YES;
}

//银行卡验证
- (BOOL)isBankCard:(NSString *)bankCard
{
    if (bankCard.length < 16) {
        return NO;
    }
    NSInteger oddsum = 0;     //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = (NSInteger)[bankCard length];
    // 取了最后一位数
    NSInteger lastNum = [[bankCard substringFromIndex:cardNoLength-1] intValue];
    //测试的是除了最后一位数外的其他数字
    bankCard = [bankCard substringToIndex:cardNoLength - 1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCard substringWithRange:NSMakeRange(i-1, 1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {//卡号位数为奇数
            if((i % 2) == 0){//偶数位置
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{//奇数位置
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
//验证邮箱地址
- (BOOL)isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于8位
 2. 密码中必须同时包含数字和字母
 */
- (BOOL)judgePassWordLegal:(NSString *)pass count:(NSInteger )count{
    
    if ([pass length] >= count){
//        // 判断长度大于8位后再接着判断是否同时包含数字和字符
//        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        result = [pred evaluateWithObject:pass];
        
        NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
        s = [s invertedSet];
        NSRange r = [pass rangeOfCharacterFromSet:s];
        if (r.location != NSNotFound){
            NSLog(@"the string contains illegal characters");
            return NO;
            
        }else {
            return YES;
        }

    }
    return NO;
}


#pragma mark - TextFiledChange



@end
