//
//  XCDistributionPicketCell.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCShopModel;
@interface XCDistributionPicketCell : UITableViewCell

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * titleValue;

/** 默认为NO */
@property (nonatomic, assign) BOOL  isCenterSeparator ;
//显示分割线 默认为YES
@property (nonatomic, assign) BOOL shouldShowSeparator ;

+(CGFloat)getCellHeight;
- (void)setupCellWithShopModel:(XCShopModel *)model;

@end
