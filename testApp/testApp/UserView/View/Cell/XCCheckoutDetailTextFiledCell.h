//
//  XCCheckoutDetailTextFiledCell.h
//  testApp
//
//  Created by Melody on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCShopModel.h"
#import "XCCheckoutDetailBaseModel.h"
@protocol XCCheckoutDetailTextFiledCellDelegate <NSObject>

- (void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title;

- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title;

- (void)XCCheckoutDetailTextFiledClickBtn:(UITextField *)textField title:(NSString *)title;

- (BOOL)XCCheckoutDetailTextFiledShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string title:(NSString *)title textFiled:(UITextField *)textFiled;


@end

@interface XCCheckoutDetailTextFiledCell : UITableViewCell

@property (nonatomic, weak) id<XCCheckoutDetailTextFiledCellDelegate> delegate;

@property (nonatomic, copy) NSString * title ;
@property (nonatomic, strong) UITextField * textField ;
@property (nonatomic, copy) NSString * titlePlaceholder ;
@property (nonatomic, strong) UILabel * titleLabel ;

@property (nonatomic, copy) NSString * secondTitle ;
@property (nonatomic, strong) UITextField * secondTextField ;
@property (nonatomic, copy) NSString * secondTitlePlaceholder ;

/// 显示分割线 默认为NO
@property (nonatomic, assign) BOOL shouldShowSeparator ;
/** 上下分割线 默认NO*/
@property (nonatomic, assign) BOOL  isTopShowSeparator ;
/** 居中的分割线 默认NO */
@property (nonatomic, assign) BOOL  isCenterSeparator ;
/** 点击类型TextFiled 默认NO*/
@property (nonatomic, assign) BOOL  shouldShowClickView ;

/** 设置TextFiled背景颜色 默认为灰色 */
@property (nonatomic, strong) UIColor * textFiledBGColor ;
/** 两个输入Title方法样式 */
@property (nonatomic, assign) BOOL isTwoInputType ;
/** 是否限制输入数字 默认NO*/
@property (nonatomic, assign) BOOL  isNumField ;

+(CGFloat)getCellHeight;

//- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model;
- (void)setupCellWithDistributionBillModel:(XCCheckoutDetailBaseModel *)model;
- (void)setupCellWithShopModel:(XCShopModel *)model;
@end
