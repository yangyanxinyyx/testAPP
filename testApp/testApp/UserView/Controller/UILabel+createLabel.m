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
    [label setFont:[UIFont systemFontOfSize:fontSize * ViewRateBaseOnIP6]];
    [label setTextColor:textColor];
    return label;
}
@end
