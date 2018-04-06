//
//  XCCheckoutDetailBaseTableViewController.h
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
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
#define kFooterViewID @"footerViewID"

@interface XCCheckoutDetailBaseTableViewController : BaseViewController1 <UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate>
/**
 自定义导航栏
 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic, strong) UITableView * tableView ;

@property (nonatomic, assign) CGFloat bottomHeight ;

- (instancetype)initWithTitle:(NSString *)title;

@end
