//
//  XCShopRejectView.h
//  testApp
//
//  Created by Melody on 2018/5/3.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCShopRejectView : UIView

@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, copy) NSString * contentStr;
typedef void (^callBackBlock)(XCShopRejectView *alertView);

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                     confirmClick:(callBackBlock)confirmblock;

@end
