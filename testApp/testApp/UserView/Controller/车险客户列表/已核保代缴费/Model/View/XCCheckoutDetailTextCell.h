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
@interface XCCheckoutDetailTextCell : UITableViewCell

@property (nonatomic, strong) NSString * title ;

@property (nonatomic, strong) NSString * titlePlaceholder ;

//显示分割线 默认为NO
@property (nonatomic, assign) BOOL shouldShowSeparator ;

- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model;
- (void)setupCellWithCustomerDetailModel:(XCCustomerDetailModel *)model;
@end
