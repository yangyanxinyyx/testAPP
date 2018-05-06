//
//  XCShopDetailListCell.h
//  testApp
//
//  Created by Melody on 2018/4/10.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCShopServiceModel;
@protocol XCShopDetailListCellDelegate <NSObject>
- (void)XCShopDetailListCellClickEditedButton:(UIButton *)button serviceModel:(XCShopServiceModel *)serviceModel;
- (void)XCShopDetailListCellClickDeleteButton:(UIButton *)button serviceModel:(XCShopServiceModel *)serviceModel;
- (void)XCShopDetailListCellClickDetailButton:(UIButton *)button serviceModel:(XCShopServiceModel *)serviceModel;

@end

@interface XCShopDetailListCell : UICollectionViewCell
/** <# 注释 #> */
@property (nonatomic, weak) id<XCShopDetailListCellDelegate> delegate ;
- (void)setupCellWithModel:(XCShopServiceModel *)model;

@end
