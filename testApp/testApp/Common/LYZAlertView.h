//
//  LYZAlertView.h
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZAlertView : UIView

@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, copy) NSString * contentStr;
@property (nonatomic, copy) NSString * confirmStr;
@property (nonatomic, copy) NSString * cancelStr;
typedef void (^confirmBlock)(LYZAlertView *alertView);

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                       confirmStr:(NSString *)confirmString
                        cancelStr:(NSString *)cancelString
                     confirmClick:(confirmBlock)confirmblock;

@end
