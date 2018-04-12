//
//  XCDistributionBillViewController.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCDistributionBillViewController.h"
#import "XCDistributionPicketCell.h"
#import "XCDistributionFooterView.h"

#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom)

@interface XCDistributionBillViewController ()<UITableViewDelegate,UITableViewDataSource,
XCDistributionFooterViewDelegate>
@property (nonatomic, strong) NSArray * titleArr ;

@end

@implementation XCDistributionBillViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addObserverKeyboard];
    [self configureData];
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardDidShowNotification
                                                 object:nil];
}

#pragma mark - Init Method
- (void)configureData
{
    self.titleArr = @[@"商业险金额:",@"交强险金额:",@"保单金额:",
                      @"缴费单通知号:",@"礼包选择",@"配送时间",
                      @"购买金额:",@"客户名称:",@"联系电话:",
                      @"预借款金额:",@"收款金额:",@"配送地址:",@"配送备注:"];
}

- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
 
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, ktableViewH)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *titleName = self.titleArr[indexPath.row];
    
    if ([self isTextCellTypeWithIndex:indexPath]) {
        XCCheckoutDetailTextCell *textCell =(XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID];
        textCell.shouldShowSeparator = YES;
        textCell.title = titleName;
        textCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return textCell;
    }else if([self isPicketCellTypeWithIndex:indexPath]) {
        XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
        picketCell.title = titleName;
        picketCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return picketCell;
    }
    XCCheckoutDetailTextFiledCell *textFiledCell =(XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID];
    textFiledCell.title = titleName;
    textFiledCell.shouldShowSeparator = YES;
    textFiledCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 2:
        case 6:
        case 9:
        case 10: {
            textFiledCell.titlePlaceholder = @"请输入金额";
        }
            break;
        case 3: {
            textFiledCell.titlePlaceholder = @"请输入通知号";
        }
            break;
        case 7: {
            textFiledCell.titlePlaceholder = @"请输入客户名称";
        }
            break;
        case 8: {
            textFiledCell.titlePlaceholder = @"请输入联系电话";
        }
            break;
        case 11:  {
            textFiledCell.titlePlaceholder = @"填写地址";
        }
            break;
        default: {
            textFiledCell.titlePlaceholder = @"输入备注信息";
        }
            break;
    }
    return textFiledCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView setTitle:@"确认提交"];
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  20 * ViewRateBaseOnIP6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (60 + 88 + 60) * ViewRateBaseOnIP6;
}

#pragma  mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    NSLog(@"点击确认提交");
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交成功" complete:nil];
    [self.view addSubview:tipsView];
    
}

#pragma mark - Privacy Method

- (BOOL)isTextCellTypeWithIndex:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1)) {
        return YES;
    }
    return NO;
}

- (BOOL)isPicketCellTypeWithIndex:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (indexPath.row == 4 || indexPath.row == 5)) {
        return YES;
    }
    return NO;
}
#pragma mark -  ========== 添加键盘通知 ==========

- (void)addObserverKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘显示
- (void)keyboardShow:(NSNotification *)notification {
    
    NSValue *keyboardEndFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame;
    [keyboardEndFrameValue getValue:&keyboardEndFrame];
    //    NSLog(@"=====>:%d",(int)keyboardEndFrame.size.height);
    //向上移动
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = weakSelf.tableView.frame;
        frame.size.height = ktableViewH -  keyboardEndFrame.size.height;
        weakSelf.tableView.frame = frame;
    }];
    
}

//键盘隐藏
- (void)keyboardHide:(NSNotification *)notification {
    //往下移动
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = weakSelf.tableView.frame;
        frame.size.height = ktableViewH ;
        weakSelf.tableView.frame = frame;
    }];
    
}
#pragma mark - Setter&Getter



@end
