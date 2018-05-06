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
#import "XCDistributionBillModel.h"
#import "XCUserPackageModel.h"
#import "SelectTimeView.h"
#import "NSString+MoneyString.h"
#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom)
@interface XCDistributionPolicyViewController ()<UITableViewDelegate,UITableViewDataSource,
XCDistributionFooterViewDelegate,XCDistributionInputCellDelegate,XCCheckoutDetailTextFiledCellDelegate>

@property (nonatomic, assign) BOOL isSelectDistribution ;
@property (nonatomic, strong) NSArray * titleArr ;
/** <# 注释 #> */
@property (nonatomic, strong) XCDistributionBillModel * billModel ;

/** 标记当前选择的Cell */
@property (nonatomic, strong) NSString * selectedTitle;

@end

@implementation XCDistributionPolicyViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isSelectDistribution = NO;
    _billModel = [[XCDistributionBillModel alloc] init];
    _billModel.isShipmentBaodan = @"N";
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
                      @"购买金额:",@"是否配送"];
 
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
    __weak __typeof(self) weakSelf = self;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
    if ([NSStringFromClass([cell class]) isEqualToString:NSStringFromClass([XCDistributionPicketCell class])]) {
        if ((indexPath.section == 0 && indexPath.row == 3)) {
            //刷卡日期
            [weakSelf.tableView endEditing:YES];
            SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            selectView.block = ^(NSString *string) {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;
                strongSelf.billModel.payDate = string;
                [(XCDistributionPicketCell *)cell setTitleValue:string];
            };
           [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        }
        else if ((indexPath.section == 1 && indexPath.row == 2)) {
            //配送时间
            [weakSelf.tableView endEditing:YES];
            SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            selectView.block = ^(NSString *string) {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;
                strongSelf.billModel.shipmentTime = string;
                [(XCDistributionPicketCell *)cell setTitleValue:string];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        }
        else if(indexPath.section == 0 && indexPath.row == 4){
            NSArray * arr = @[@"赠送",@"购买",@"无"];
            LYZSelectView *alterView = [LYZSelectView alterViewWithArray:arr confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;

                strongSelf.billModel.packageGiveOrBuy = selectStr;
                [(XCDistributionPicketCell *)cell setTitleValue:selectStr];
            }];
            [weakSelf.view addSubview:alterView];
        }
        else if (indexPath.section == 0 && indexPath.row == 5) {
            NSMutableArray *arrM = [[NSMutableArray alloc] init];
            if (_packageArr) {
                for (XCUserPackageModel *model in _packageArr) {
                    [arrM addObject:model.name];
                }
            }else {
                [arrM addObject:@""];
            }
            LYZSelectView *alterView = [LYZSelectView alterViewWithArray:arrM confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;
                NSNumber *selectID = [NSNumber numberWithLong:999999];
                NSNumber *packageBuy = [NSNumber numberWithLong:999999];

                for (XCUserPackageModel *model in strongSelf.packageArr) {
                    if ([model.name isEqualToString:selectStr]) {
                        selectID = model.packageID;
                        packageBuy = [NSNumber numberWithDouble:[model.price doubleValue]];
                    }
                }
                if (!isUsable(selectID, [NSNumber class])) {
                    selectID = [NSNumber numberWithLong:999999];
                }
                strongSelf.billModel.packageId = selectID;
                strongSelf.billModel.packageBuyPrice = packageBuy;
                [(XCDistributionPicketCell *)cell setTitleValue:selectStr];
            }];
            [weakSelf.view addSubview:alterView];
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
        if (indexPath.row == 0) {
            [textCell setTitlePlaceholder:self.syMoney];
        }else {
            [textCell setTitlePlaceholder:self.jqMoney];
        }
        return textCell;
    }else if([self isPicketCellTypeWithIndex:indexPath]) {
        XCDistributionPicketCell *picketCell =(XCDistributionPicketCell *)[tableView dequeueReusableCellWithIdentifier:kPicketCellID];
        picketCell.title = titleName;
        [picketCell setShouldShowSeparator:YES];
        if (indexPath.section == 1 && indexPath.row == 2) {
            [picketCell setShouldShowSeparator:NO];
        }
        return picketCell;
    }else if([self isInputCellTypeWithIndex:indexPath]){
            XCDistributionInputCell *inputCell = (XCDistributionInputCell *)[tableView dequeueReusableCellWithIdentifier:kInputCellID];
            inputCell.title = titleName;
            inputCell.userInteractionEnabled = YES;
            inputCell.delegate =self;
        return inputCell;
    }
    
    XCCheckoutDetailTextFiledCell *textFiledCell =(XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID];
    textFiledCell.title = titleName;
    textFiledCell.shouldShowSeparator = YES;
    textFiledCell.delegate = self;
    textFiledCell.isNumField = NO;
    if ([titleName isEqualToString:@"保单金额:"]||[titleName isEqualToString:@"购买金额:"]||[titleName isEqualToString:@"收款金额:"]) {
        textFiledCell.shouldShowSeparator = NO;
        if([titleName isEqualToString:@"保单金额:"]) {
            textFiledCell.shouldShowSeparator = YES;
        }
        textFiledCell.titlePlaceholder = @"请输入金额";
        textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        textFiledCell.isNumField = YES;
    }else if([titleName isEqualToString:@"客户名称:"] ) {
        textFiledCell.titlePlaceholder = @"输入客户名称";
    }else if([titleName isEqualToString:@"联系电话:"]) {
        textFiledCell.titlePlaceholder = @"输入联系电话";
        textFiledCell.isNumField = YES;
        textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
    }else if([titleName isEqualToString:@"配送地址:"]) {
        textFiledCell.titlePlaceholder = @"填写地址";
    }else if([titleName isEqualToString:@"配送备注:"])  {
        textFiledCell.shouldShowSeparator = NO;
        textFiledCell.titlePlaceholder = @"输入备注信息";
    }
    _billModel.receiverName = self.model.customerName;
    _billModel.phone = self.model.phoneNo;
#warning 缺少客户地址
//    _payModel.address = self.model
    [textFiledCell setupCellWithDistributionBillModel:self.model];
    
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
    
    BOOL configureSuccess = YES;
    NSString *errString = @"保单信息错误";
    if (!isUsable(_billModel.policyId, [NSNumber class])) {
        errString = @"保单信息错误";
        configureSuccess = NO;
    }
    if (_isSelectDistribution) {
        if (!isUsableNSString(_billModel.receiverName,@"")) {
            errString = @"收件客户名称为空";
            configureSuccess = NO;
        }
        if (!isUsableNSString(_billModel.phone,@"")) {
            errString = @"联系电话为空";
            configureSuccess = NO;
        }
        if (!isUsableNSString(_billModel.shipmentTime,@"")) {
            errString = @"预约配送时间为空";
            configureSuccess = NO;
        }
        if (!isUsable(_billModel.receiveMoney,[NSNumber class])) {
            _billModel.receiveMoney = [NSNumber numberWithDouble:0];
        }
        if (!isUsableNSString(_billModel.remark, @"")) {
            _billModel.remark = @"";
        }
        if (!isUsableNSString(_billModel.address, @"")) {
            errString = @"配送地址为空";
            configureSuccess = NO;
        }
    }
    if (!isUsable(_billModel.policyTotalAmount,[NSNumber class])) {
        _billModel.policyTotalAmount = [NSNumber numberWithDouble:0];
    }
    if (!isUsableNSString(_billModel.payDate,@"")) {
        errString = @"刷卡日期为空";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_billModel.packageGiveOrBuy,@"")) {
        errString = @"请选择礼包";
        configureSuccess = NO;
    }
    if (!isUsable(_billModel.packageBuyPrice,[NSNumber class])) {
        errString = @"礼包数据错误";
        configureSuccess = NO;
    }
    if (!isUsable(_billModel.packageId, [NSNumber class])) {
        errString = @"礼包数据错误";
        configureSuccess = NO;
    }
    if (configureSuccess) {
        NSLog(@"点击确认提交");
        __weak __typeof(self) weakSelf = self;
        NSDictionary *param = [_billModel yy_modelToJSONObject];
        [RequestAPI postSubmitPolicyPaymentList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1) {
                [strongSelf showAlterInfoWithNetWork:@"提交成功" complete:^{
                    [strongSelf.navigationController popViewControllerAnimated:YES];

                }];
            }else {
                [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"预约失败" complete:nil];
            [weakSelf.view addSubview:tipsView];
        }];
    }else {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }
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
    _billModel.isShipmentBaodan = @"N";
    if (_isSelectDistribution) {
        [self.dataArrM addObject:customerArr];
        [self.dataArrM addObject:moneyArr];
        [self.dataArrM addObject:addressArr];
        _billModel.isShipmentBaodan = @"Y";
    }
    [self.tableView reloadData];
    
}



#pragma mark - XCCheckoutDetailTextFiledCellDelegate

- (void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title
{
    self.selectedTitle = title;
    
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    if ([title isEqualToString:@"保单金额:"]) {
        if (isUsable(_billModel.policyTotalAmount, [NSNumber class])) {
            [textField setText:[_billModel.policyTotalAmount stringValue]];
        }
    }
    else if ([title isEqualToString:@"购买金额:"]) {
        if (isUsable(_billModel.packageBuyPrice, [NSNumber class])) {
            [textField setText:[_billModel.packageBuyPrice  stringValue]];
        }
    }
    else if ([title isEqualToString:@"收款金额:"]) {
        if (isUsable(_billModel.receiveMoney, [NSNumber class])) {
            [textField setText:[_billModel.receiveMoney stringValue]];
        }
    }
}

- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    
    if ([title isEqualToString:@"保单金额:"]) {
        double price = [textField.text doubleValue];
        _billModel.policyTotalAmount = [NSNumber numberWithDouble:price];
        [textField setText:[NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"购买金额:"]) {
        double price = [textField.text doubleValue];
        _billModel.packageBuyPrice = [NSNumber numberWithDouble:price];
        [textField setText:[NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"收款金额:"]) {
        double price = [textField.text doubleValue];
        _billModel.receiveMoney = [NSNumber numberWithDouble:price];
        [textField setText:[NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"客户名称:"]) {
        _billModel.receiverName = textField.text;
    }
    else if ([title isEqualToString:@"联系电话:"]) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        _billModel.phone = textField.text;
    }
    else if ([title isEqualToString:@"配送地址:"]) {
        _billModel.address = textField.text;
    }
    else if ([title isEqualToString:@"配送备注:"]) {
        _billModel.remark = textField.text;
    }
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
    
    if (isUsableNSString(self.selectedTitle, @"")) {
        if (![self shouldSetTableViewOffsetWithTitle:self.selectedTitle]) {
            return;
        }
    }
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
        [weakSelf scrollViewToBottom:YES];
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
- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}
            
- (BOOL)shouldSetTableViewOffsetWithTitle:(NSString *)title {
    
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    
    if ([title isEqualToString:@"联系电话:"]) {
        return YES;
    }
    else if ([title isEqualToString:@"收款金额:"]) {
        return YES;
    }
    else if ([title isEqualToString:@"配送地址:"]) {
        return YES;
    }
    else if ([title isEqualToString:@"配送备注:"]) {
        return YES;
    }
    return NO;
}

#pragma mark - Setter&Getter

- (void)setPolicyId:(NSNumber *)policyId
{
    if (isUsable(policyId, [NSNumber class])) {
        if (!_billModel) {
            _billModel = [[XCDistributionBillModel alloc] init];
        }
        _billModel.policyId = policyId;
    }
}


@end
