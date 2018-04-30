//
//  XCUserBaseViewController.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"

#import "XCCheckoutDetailTextCell.h"
#import "XCCheckoutDetailTextFiledCell.h"
#import "XCCheckoutDetailInputCell.h"
#import "XCCheckoutDetailHeaderView.h"
#import "XCDistributionPicketCell.h"
#import "XCDistributionFooterView.h"
#import "FinishTipsView.h"
#import "SelectTimeView.h"
#import "LYZSelectView.h"
#define ktableCellID @"myCellID"
#define kTextCellID @"textCellID"
#define kTextFiledCellID @"textFiledCellID"
#define kPicketCellID @"picketCellID"
#define kInputCellID @"inpuitCellID"
#define kHeaderViewID @"headerViewID"
#define kFooterViewID @"footerViewID"

@interface XCUserBaseViewController : BaseViewController1 <UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate,UIScrollViewDelegate>

/** 自定义导航栏 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;

@property (nonatomic, strong) NSMutableArray *dataArrM ;
@property (nonatomic, strong) UITableView *tableView ;

- (instancetype)initWithTitle:(NSString *)title;

//手机验证
- (BOOL)valiMobile:(NSString *)mobile;
//提示框
- (void)showAlterInfoWithNetWork:(NSString *)titleStr complete:(void (^)(void))complete;

@end
