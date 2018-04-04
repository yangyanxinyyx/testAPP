//
//  XCCheckoutDetailBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCheckoutDetailTextCell.h"
#import "XCCheckoutDetailTextFiledCell.h"
#import "XCCheckoutDetailInputCell.h"
#import "XCCheckoutDetailHeaderView.h"
#import "FinishTipsView.h"
#define ktableCellID @"myCellID"
#define kTextCellID @"textCellID"
#define kTextFiledCellID @"textFiledCellID"
#define kTextInputCellID @"inpuitCellID"
#define kHeaderViewID @"headerViewID"

@interface XCCheckoutDetailBaseTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView ;

@property (nonatomic, assign) CGFloat bottomHeight ;

@end
