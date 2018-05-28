//
//  XCShopLabelChildView.h
//  testApp
//
//  Created by Melody on 2018/5/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCShopLabelChildView : UIView
/** <# 注释 #> */
@property (nonatomic, assign) BOOL isSelected ;
/** <# 注释 #> */
@property (nonatomic, copy) NSString * title ;

+(CGFloat)getViewHeight;
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Selected:(BOOL)isSelected;
@end
