//
//  XCUserCaseBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCUserCaseListCell.h"
#define kmyCellID @"myCellID"
#define kcaseListCelID @"myCaseListCellID"

@interface XCUserCaseBaseTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView ;
@end
