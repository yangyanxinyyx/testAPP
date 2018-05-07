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

/** 默认为NO 会计审核中 特殊Cell */
@property (nonatomic, assign) BOOL shoulSecondType ;
/** 判断是年审还是配送 */
@property (nonatomic, copy) NSString * typeStr;

- (void)setupCellWithCaseListModel:(XCCheckoutDetailBaseModel *)model;

@end
