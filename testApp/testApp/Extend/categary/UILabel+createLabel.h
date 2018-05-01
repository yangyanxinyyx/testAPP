//
//  UILabel+createLabel.h
//  testApp
//
//  Created by Melody on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (createLabel)
+(UILabel *)createLabelWithTextFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;

+ (CGFloat)getXCTextHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFontSize:(CGFloat )fontsize;
+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
@end
