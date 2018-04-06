//
//  LYZSelectView.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZSelectView : UIView

typedef void (^confirmBlock)(LYZSelectView *alertView,NSString *selectStr);

+ (instancetype)alterViewWithArray:(NSArray<NSString *>*)dataArr
                      confirmClick:(confirmBlock)confirmblock;


@end
