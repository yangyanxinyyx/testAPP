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
- (void)XCCheckoutDetailPhotoCellChangePhotoArr:(NSArray *)photoArr cell:(XCCheckoutDetailPhotoCell *)cell;
@end

@interface XCCheckoutDetailPhotoCell : UITableViewCell
@property (nonatomic, strong) NSString * title ;
@property (nonatomic, strong) NSMutableArray * photoArr ;
@property (nonatomic, strong) UILabel * titleLabel ;

@property (nonatomic, assign) NSInteger  maxPhoto ;

/** 置顶功能(门店图片使用)  默认为NO*/
@property (nonatomic, assign) BOOL  isShowTopTag ;

/** <# 类型描述  #> */
@property (nonatomic, weak) id<XCCheckoutDetailPhotoCellDelegate> delegate ;
+ (CGFloat)getCellHeight;

@end
