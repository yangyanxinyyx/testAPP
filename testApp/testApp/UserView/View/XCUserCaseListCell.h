//
//  XCUserCaseListCell.h
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCUserCaseListModel.h"
@interface XCUserCaseListCell : UITableViewCell

- (void)setupCellWithCaseListModel:(XCUserCaseListModel *)model caseTypeStr:(NSString *)caseTypeStr;

@end
