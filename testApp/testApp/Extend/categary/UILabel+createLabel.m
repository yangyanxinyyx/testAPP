//
//  UILabel+createLabel.m
//  testApp
//
//  Created by Melody on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UILabel+createLabel.h"

@implementation UILabel (createLabel)
+(UILabel *)createLabelWithTextFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize * ViewRateBaseOnIP6]];
//    [UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]
    [label setTextColor:textColor];
    return label;
}

+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}

+ (CGFloat)getXCTextHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFontSize:(CGFloat )fontsize {

    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontsize * ViewRateBaseOnIP6];
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}


@end
