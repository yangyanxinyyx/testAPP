//
//  XCShopLabelAlertView.h
//  testApp
//
//  Created by Melody on 2018/5/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCShopLabelAlertView : UIView
typedef void (^confirmLabelBlock)(XCShopLabelAlertView *alertView,NSArray *selectArr);
@property (nonatomic, copy) confirmLabelBlock confirmblock;

+(instancetype)alterViewWithDataArr:(NSArray *)dataArr
                          selectArr:(NSMutableArray *)selectedArr
                       confirmClick:(confirmLabelBlock)confirmblock;

@end
