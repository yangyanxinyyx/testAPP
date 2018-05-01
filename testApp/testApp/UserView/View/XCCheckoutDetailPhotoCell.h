//
//  XCCheckoutDetailPhotoCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCShopModel;
@class XCCheckoutDetailPhotoCell;
@protocol XCCheckoutDetailPhotoCellDelegate <NSObject>
- (void)XCCheckoutDetailPhotoCellClickAddPhotosImageView:(UIImageView *)imageView cell:(XCCheckoutDetailPhotoCell *)cell;
- (void)XCCheckoutDetailPhotoCellClickphotoWithURL:(NSURL  *)photoURL index:(NSInteger)index cell:(XCCheckoutDetailPhotoCell *)cell;
@end

@interface XCCheckoutDetailPhotoCell : UITableViewCell
@property (nonatomic, strong) NSString * title ;
@property (nonatomic, strong) NSArray * photoArr ;
@property (nonatomic, strong) UILabel * titleLabel ;

@property (nonatomic, assign) NSInteger  maxPhoto ;

/** 判断是否年审预约类型 默认NO */
@property (nonatomic, assign) BOOL isAnnualType ;

/** <# 类型描述  #> */
@property (nonatomic, weak) id<XCCheckoutDetailPhotoCellDelegate> delegate ;
+ (CGFloat)getCellHeight;
- (void)setupCellWithShopModel:(XCShopModel *)model;

@end
