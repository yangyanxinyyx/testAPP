//
//  XCCheckoutDetailBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ktableCellID @"myCellID"
@interface XCCheckoutDetailBaseTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView ;

@end
