//
//  XCFinanicalAuditListCell.h
//  testApp
//
//  Created by Melody on 2018/4/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCheckoutDetailBaseModel.h"
#import "XCCarTransactionModel.h"
@interface XCFinanicalAuditListCell : UITableViewCell

/** 判断是会计审核还是配送 */
@property (nonatomic, copy) NSString * typeStr;

- (void)setupCellWithCaseListModel:(XCCheckoutDetailBaseModel *)model;

//车务客户列表
- (void)setupCellWithCarTransactionModel:(XCCarTransactionModel *)model;

@end
