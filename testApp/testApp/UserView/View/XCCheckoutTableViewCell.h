//
//  XCCheckoutTableViewCell.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCCheckoutTableViewCell;
@protocol XCCheckoutTableViewCellDelegate <NSObject>

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell;
- (void)XCCheckoutCellClickUnderWritingButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell;
@end

@interface XCCheckoutTableViewCell : UITableViewCell

/** 标记车牌号 */
@property (nonatomic, copy) NSString * carNumber;
/** 标记车主 */
@property (nonatomic, copy) NSString * userName;
/** 标记出单时间 */
@property (nonatomic, copy) NSString * issureTime;

@property (nonatomic, weak) id <XCCheckoutTableViewCellDelegate> delegate;

/** 我的客户Cell */
@property (nonatomic, assign) BOOL  isCustomerCell;

@end
