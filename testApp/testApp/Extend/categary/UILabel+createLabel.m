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
@end
