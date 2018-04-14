//
//  XCCheckoutDetailTextFiledCell.h
//  testApp
//
//  Created by Melody on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCShopModel.h"
//#import "XCCheckoutDetailBaseModel.h"
@protocol XCCheckoutDetailTextFiledCellDelegate <NSObject>
- (void)XCCheckoutDetailTextFiledSubmitTextField:(NSString *)textFiledString title:(NSString *)title;
@end

@interface XCCheckoutDetailTextFiledCell : UITableViewCell

@property (nonatomic, weak) id<XCCheckoutDetailTextFiledCellDelegate> delegate;

@property (nonatomic, copy) NSString * title ;
@property (nonatomic, copy) NSString * titlePlaceholder ;

@property (nonatomic, copy) NSString * secondTitle ;
@property (nonatomic, copy) NSString * secondTitlePlaceholder ;

/** 默认为NO */
@property (nonatomic, assign) BOOL  isCenterSeparator ;
//显示分割线 默认为NO
@property (nonatomic, assign) BOOL shouldShowSeparator ;
/** 设置TextFiled背景颜色 默认为灰色 */
@property (nonatomic, strong) UIColor * textFiledBGColor ;
/** <# 注释 #> */
@property (nonatomic, assign) BOOL isTwoInputType ;
+(CGFloat)getCellHeight;

//- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model;

- (void)setupCellWithShopModel:(XCShopModel *)model;
@end
