//
//  XCDistributionPolicyViewController.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCDistributionPolicyViewController.h"
#import "XCDistributionPicketCell.h"
#import "XCDistributionFooterView.h"
#import "XCDistributionInputCell.h"
#import "LYZSelectView.h"

#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom)
@interface XCDistributionPolicyViewController ()<UITableViewDelegate,UITableViewDataSource,
XCDistributionFooterViewDelegate,XCDistributionInputCellDelegate>

@property (nonatomic, assign) BOOL isSelectDistribution ;
@property (nonatomic, strong) NSArray * titleArr ;


//@property (nonatomic, strong) UIButton * confirmBtn ;
///** 商业险金额 */
//@property (nonatomic, strong) UILabel * bussinessLabel ;
///** 交强险金额 */
//@property (nonatomic, strong) UILabel * commonLabel ;
///** 保单金额 */
//@property (nonatomic, strong) UITextField * ploicyBillTextField ;
///** 刷卡日期 */
//@property (nonatomic, strong) UILabel * dateOfPayByCardLabel ;
///** 礼包（购买/赠送） */
//@property (nonatomic, strong) UILabel * giftTypeLabel ;
///** 购买金额 */
//@property (nonatomic, strong) UITextField * purchaseValueLabel ;
///** 是否配送打钩 */
//@property (nonatomic, strong) UIImageView * tickDistributionImageView ;
///** 客户名称 */
//@property (nonatomic, strong) UITextField * customerNameTextFiled ;
///** 联系电话 */
//@property (nonatomic, strong) UITextField * customerPhoneTextFiled ;
///** 配送地址 */
//@property (nonatomic, strong) UITextField * customerAddressTextFiled ;
///** 配送备注 */
//@property (nonatomic, strong) UITextField * customerCommentTextFiled ;

@end

@implementation XCDistributionPolicyViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isSelectDistribution = NO;
    [self addObserverKeyboard];
    [self configureData];
    [self createUI];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
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
    self.dataArrM = [[NSMutableArray alloc] init];
    //index 为4、5、6、10 为选择框;2、6、8、9、11、12、13为输入框 7 勾选框
    self.titleArr = @[@"商业险金额:",@"交强险金额:",@"保单金额:",
                      @"刷卡日期:",@"礼包(购买/赠送)",@"礼包选择",
                      @"购买金额",@"是否配送"];
 
    [self.dataArrM addObject:self.titleArr];
    
//    self.titleArr = @[@"商业险金额:",@"交强险金额:",@"保单金额:",
//                      @"刷卡日期:",@"礼包(购买/赠送)",@"礼包选择",
//                      @"购买金额",@"是否配送",@"客户名称:",
//                      @"联系电话:",@"配送时间",@"收款金额:",@"配送地址:",@"配送备注:"];
}

- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCDistributionPicketCell class] forCellReuseIdentifier:kPicketCellID];
    [self.tableView registerClass:[XCDistributionInputCell class] forCellReuseIdentifier:kInputCellID];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([NSStringFromClass([cell class]) isEqualToString:NSStringFromClass([XCDistributionPicketCell class])]) {
        if ((indexPath.section == 0 && indexPath.row == 3)||(indexPath.section == 1 && indexPath.row == 2)) {
            
        }else {
            NSArray * arr = @[@"礼包一",@"礼包二",@"礼包三"];
            LYZSelectView *alterView = [LYZSelectView alterViewWithArray:arr confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                NSLog(@"选中%@",selectStr);
                
            }];
            [self.view addSubview:alterView];
        }
    }
}

#pragma mark - Delegates & Notifications

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArrM.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArr = self.dataArrM[section];
    
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *titleArr;
    NSString *titleName;
    if (self.dataArrM.count > indexPath.section) {
        titleArr = self.dataArrM[indexPath.section];
        if (titleArr.count > indexPath.row) {
           titleName = titleArr[indexPath.row];
        }
    }

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
    }else if([self isInputCellTypeWithIndex:indexPath]){
            XCDistributionInputCell *inputCell = (XCDistributionInputCell *)[tableView dequeueReusableCellWithIdentifier:kInputCellID];
            inputCell.title = titleName;
            inputCell.userInteractionEnabled = YES;
            inputCell.delegate =self;
            inputCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return inputCell;
    }
    
    XCCheckoutDetailTextFiledCell *textFiledCell =(XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID];
    textFiledCell.title = titleName;
    textFiledCell.shouldShowSeparator = YES;
    textFiledCell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([titleName isEqualToString:@"保单金额:"]||[titleName isEqualToString:@"购买金额:"]||[titleName isEqualToString:@"收款金额:"]) {
        textFiledCell.titlePlaceholder = @"请输入金额";
    }else if([titleName isEqualToString:@"客户名称:"] ) {
        textFiledCell.titlePlaceholder = @"输入客户名称";
    }else if([titleName isEqualToString:@"联系电话:"]) {
        textFiledCell.titlePlaceholder = @"输入联系电话";
    }else if([titleName isEqualToString:@"配送地址:"]) {
        textFiledCell.titlePlaceholder = @"填写地址";
    }else if([titleName isEqualToString:@"配送备注:"])  {
        textFiledCell.titlePlaceholder = @"输入备注信息";
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
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isInputCellTypeWithIndex:indexPath]) {
        return 70 * ViewRateBaseOnIP6;
    }
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerViewHeigth;
    headerViewHeigth = 20 * ViewRateBaseOnIP6;
    if (_isSelectDistribution) {
        if (section == 1) {
         headerViewHeigth = 0.0;
        }
    }
    return headerViewHeigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerViewHeigth;
    footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
    if (_isSelectDistribution) {
        if (section != 3) {
            footerViewHeigth = 0.0;
        }
    }
    return footerViewHeigth;
}

#pragma  mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    NSLog(@"点击确认提交");
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"修改成功" complete:nil];
    [self.view addSubview:tipsView];
    
}
#pragma  mark - XCDistributionInputCellDelegate

-(void)XCDistributionInputCellClickSelectView:(BOOL)isselected
{
    NSLog(@"选中");
    _isSelectDistribution = isselected;
    [self.dataArrM removeAllObjects];
    NSArray *customerArr = @[@"客户名称:",@"联系电话:",@"配送时间"];
    NSArray *moneyArr = @[@"收款金额:"];
    NSArray *addressArr = @[@"配送地址:",@"配送备注:"];
    [self.dataArrM addObject:self.titleArr];
    if (_isSelectDistribution) {
        [self.dataArrM addObject:customerArr];
        [self.dataArrM addObject:moneyArr];
        [self.dataArrM addObject:addressArr];
    }
    [self.tableView reloadData];
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
    if (indexPath.section == 0 && (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)) {
        return YES;
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        return YES;
    }
    return NO;
}

- (BOOL)isInputCellTypeWithIndex:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (indexPath.row == 7)) {
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
