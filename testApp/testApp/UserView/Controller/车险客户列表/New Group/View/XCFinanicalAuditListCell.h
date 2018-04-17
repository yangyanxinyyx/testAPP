//
//  XCFinanicalAuditListCell.h
//  testApp
//
//  Created by Melody on 2018/4/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCheckoutDetailBaseModel.h"

@interface XCFinanicalAuditListCell : UITableViewCell
/** <# 注释 #> */
@property (nonatomic, copy) NSString * timeTitleStr ;
- (void)setupCellWithCaseListModel:(XCCheckoutDetailBaseModel *)model;

@end
