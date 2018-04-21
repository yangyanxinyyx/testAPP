//
//  XCUserViolationDetailClickCell.h
//  testApp
//
//  Created by Melody on 2018/4/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCUserViolationDetailModel.h"
@protocol XCUserViolationDetailClickCellDelegate <NSObject>
- (void)XCUserViolationDetailClickCellClickButton:(UIButton *)button statusLabel:(UILabel *)statusLabel;

@end


@interface XCUserViolationDetailClickCell : UITableViewCell
/** <# 注释 #> */
@property (nonatomic, strong) XCUserViolationDetailModel * detailModel ;
/** <# 注释 #> */
@property (nonatomic, weak) id<XCUserViolationDetailClickCellDelegate> delegate ;
+ (CGFloat)getCellHeight;


@end
