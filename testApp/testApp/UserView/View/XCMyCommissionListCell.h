//
//  XCMyCommissionListCell.h
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCMyCommissionListModel.h"
#define kcellForTimeViewH 80 * ViewRateBaseOnIP6
#define kcellForCarListViewH (216 + 20) * ViewRateBaseOnIP6
#define kcellForServiceListViewH (144 + 20) * ViewRateBaseOnIP6
#define kcellForMedalViewH 88 * ViewRateBaseOnIP6
@interface XCMyCommissionListCell : UITableViewCell

- (void)setupCellDataWithModel:(XCMyCommissionListModel *)model;

@end
