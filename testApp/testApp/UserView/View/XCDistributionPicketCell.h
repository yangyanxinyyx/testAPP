//
//  XCDistributionPicketCell.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCDistributionPicketCell;
@protocol XCDistributionPicketCellDelegate <NSObject>

- (void)XCDistributionPicketCellClickArrowBtn:(UIButton *)button title:(NSString *)title cell:(XCDistributionPicketCell *)cell;
@end

@class XCShopModel;
@interface XCDistributionPicketCell : UITableViewCell

@property (nonatomic, copy) NSString * title;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;

@property (nonatomic, copy) NSString * titleValue;

/** 默认为NO */
@property (nonatomic, assign) BOOL  isCenterSeparator ;
///显示分割线 默认为YES
@property (nonatomic, assign) BOOL shouldShowSeparator ;
/** 是否显示箭头 默认YES*/
@property (nonatomic, assign) BOOL shouldShowArrow;
/** <# 类型描述  #> */
@property (nonatomic, weak) id<XCDistributionPicketCellDelegate> delegate ;

+(CGFloat)getCellHeight;
- (void)setupCellWithShopModel:(XCShopModel *)model;


@end
