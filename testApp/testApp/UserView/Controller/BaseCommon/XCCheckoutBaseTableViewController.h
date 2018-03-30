//
//  XCCheckoutBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCCheckoutTableViewCell.h"
#import "LYZAlertView.h"
#define kcheckCellID @"checkCell"

@interface XCCheckoutBaseTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView ;

@end
