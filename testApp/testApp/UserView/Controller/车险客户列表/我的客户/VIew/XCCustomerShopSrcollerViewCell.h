//
//  XCCustomerShopSrcollerViewCell.h
//  testApp
//
//  Created by Melody on 2018/4/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCustomerShopModel.h"
@protocol XCCustomerShopSrcollerViewCellDelegate <NSObject>
- (void)XCCustomerShopSrcollerViewCellClickWithModel:(XCCustomerShopModel *)model;
@end
@interface XCCustomerShopSrcollerViewCell : UIView
/** <# 注释 #> */
@property (nonatomic, strong) XCCustomerShopModel * model ;

/** <# 注释 #> */
@property (nonatomic, weak) id<XCCustomerShopSrcollerViewCellDelegate>  delegate ;

@end
