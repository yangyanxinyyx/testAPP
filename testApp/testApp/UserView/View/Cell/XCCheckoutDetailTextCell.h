//
//  XCCheckoutDetailTextCell.h
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCCheckoutDetailBaseModel;
@class XCCustomerDetailModel;
@class XCShopServiceModel;
@interface XCCheckoutDetailTextCell : UITableViewCell

@property (nonatomic, strong) NSString * title ;
@property (nonatomic, strong) UILabel * titleLabel ;

@property (nonatomic, strong) NSString * titlePlaceholder ;

/// 显示分割线 默认为NO
@property (nonatomic, assign) BOOL shouldShowSeparator ;
/** placeholder 置右  默认NO*/
@property (nonatomic, assign) BOOL shouldTPRightMargin ;
- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model;
- (void)setupCellWithCustomerDetailModel:(XCCustomerDetailModel *)model;
- (void)setupCellWithChargeBackModel:(XCCheckoutDetailBaseModel *)model;
- (void)setupCellWithShopServiceModel:(XCShopServiceModel *)model;

@end
