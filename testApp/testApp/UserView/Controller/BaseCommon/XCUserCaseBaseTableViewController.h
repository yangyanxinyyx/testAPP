//
//  XCUserCaseBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
#import "XCUserCaseListCell.h"
#import <YYModel/YYModel.h>
#import <MJRefresh/MJRefresh.h>
#define kCaseListCellID @"caseListCellID"
#define kHeaderViewID @"headerViewID"
@interface XCUserCaseBaseTableViewController :BaseViewController1 <UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate>

/**
 自定义导航栏
 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;

@property (nonatomic, strong) UITableView * tableView ;
@property (nonatomic, strong) NSMutableArray * dataArr ;

/** 记录加载index */
@property (nonatomic, assign) int  pageIndex;
//下拉刷新获取总页数
@property (nonatomic, assign) int pageCount ;
- (instancetype)initWithTitle:(NSString *)title;

@end
