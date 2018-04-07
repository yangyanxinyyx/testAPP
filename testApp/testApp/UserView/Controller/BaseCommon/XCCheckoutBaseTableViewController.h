//
//  XCCheckoutBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
#import "XCCheckoutTableViewCell.h"
#import "LYZAlertView.h"
#import "XCCheckoutBaseFooterView.h"
#define kcheckCellID @"checkCell"
#define kheaderViewID @"headerViewID"
#define kfooterViewID @"basefooterViewID"
@interface XCCheckoutBaseTableViewController : BaseViewController1<UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate>
/**
 自定义导航栏
 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;

@property (nonatomic, strong) UITableView * tableView ;
@property (nonatomic, strong) NSMutableArray * dataArr ;

- (instancetype)initWithTitle:(NSString *)title;


@end
