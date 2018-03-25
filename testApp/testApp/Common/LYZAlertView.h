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
@property (nonatomic, copy) NSString * comfirmStr;
@property (nonatomic, copy) NSString * cancelStr;
typedef void (^cancelBlock)(LYZAlertView *alertView);
typedef void (^comfirmBlock)(LYZAlertView *alertView);

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                       comfirmStr:(NSString *)comfirmString
                        cancelStr:(NSString *)cancelString
                     comfirmClick:(comfirmBlock)comfirmblock
                      cancelClick:(cancelBlock)cancelblock;

@end
