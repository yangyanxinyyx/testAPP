//
//  XCUserCaseListCell.h
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCUserCaseListCell;
@protocol XCUserCaseListCellDelegate <NSObject>

- (void)XCUserCaseListCellClickDetailButtonHandler:(UIButton *)button cell:(XCUserCaseListCell *)cell;

@end


@interface XCUserCaseListCell : UITableViewCell

@property (nonatomic, weak) id<XCUserCaseListCellDelegate> delegate ;

@end
