//
//  XCCheckoutTableViewCell.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCCheckoutDetailBaseModel;
@class XCCustomerListModel;
@class XCCarTransactionModel;
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

/** 自定义时间wei'zhi标题 */
@property (nonatomic, copy) NSString * timeTitleStr ;

@property (nonatomic, weak) id <XCCheckoutTableViewCellDelegate> delegate;
/** 车险客户列表Model */
@property (nonatomic, strong) XCCheckoutDetailBaseModel * baseModel ;

/** 我的客户Cell  默认NO*/
@property (nonatomic, assign) BOOL  isCustomerCell;


- (void)setupCellWithMYCustomerListModel:(XCCustomerListModel *)model;

- (void)setupCellWithCarTransactionListModel:(XCCarTransactionModel *)model;

@end
