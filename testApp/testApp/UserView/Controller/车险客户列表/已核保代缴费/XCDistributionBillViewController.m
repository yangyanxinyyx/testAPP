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
#import "XCDistributionPaymentBillModel.h"
#import "SelectTimeView.h"
#import "XCUserPackageModel.h"
#import "NSString+MoneyString.h"

#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom)

@interface XCDistributionBillViewController ()<UITableViewDelegate,UITableViewDataSource,
XCDistributionFooterViewDelegate,XCCheckoutDetailTextFiledCellDelegate>
@property (nonatomic, strong) NSArray * titleArr ;
/** <# 注释 #> */
@property (nonatomic, strong) XCDistributionPaymentBillModel * payModel ;
/** 标记当前选择的Cell */
@property (nonatomic, strong) NSString * selectedTitle;

@end

@implementation XCDistributionBillViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _payModel = [[XCDistributionPaymentBillModel alloc] init];

    [self addObserverKeyboard];
    [self configureData];
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeObserverKeyBoard];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof (self)weakSelf = self;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([NSStringFromClass([cell class]) isEqualToString:NSStringFromClass([XCDistributionPicketCell class])]) {
        if ((indexPath.section == 0 && indexPath.row == 5)) {
            //配送时间
            [weakSelf.tableView endEditing:YES];
            SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            selectView.block = ^(NSString *string) {
                __strong __typeof__(weakSelf)strongSelf = weakSelf;
                strongSelf.payModel.shipmentTime = string;
                [(XCDistributionPicketCell *)cell setTitleValue:string];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        }
        else if(indexPath.section == 0 && indexPath.row == 4){
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
                        packageBuy = [NSNumber numberWithDouble:[model.price doubleValue]] ;
                    }
                }
                if (!isUsable(selectID, [NSNumber class])) {
                    selectID = [NSNumber numberWithLong:999999];
                }
                strongSelf.payModel.packageId = selectID;
                strongSelf.payModel.packageBuyPrice = packageBuy;
                [(XCDistributionPicketCell *)cell setTitleValue:selectStr];
            }];
            [weakSelf.view addSubview:alterView];
        }
    }
}

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
        [textCell setTitle:titleName];
        if ([titleName isEqualToString:@"商业险金额:"]) {
            [textCell setTitlePlaceholder:self.syMoney];
        }
        else if ([titleName isEqualToString:@"交强险金额:"]) {
            [textCell setTitlePlaceholder:self.jqMoney];
        }
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
    textFiledCell.delegate = self;
    textFiledCell.isNumField = NO;
    switch (indexPath.row) {
        case 2:
        case 6:
        case 9:
        case 10: {
            textFiledCell.titlePlaceholder = @"请输入金额";
            textFiledCell.isNumField = YES;
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        }
            break;
        case 3: {
            textFiledCell.titlePlaceholder = @"请输入通知号";
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        }
            break;
        case 7: {
            textFiledCell.titlePlaceholder = @"请输入客户名称";
        }
            break;
        case 8: {
            textFiledCell.isNumField = YES;
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
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
    _payModel.receiverName = self.model.customerName;
    _payModel.phone = self.model.phoneNo;
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

#pragma mark - XCCheckoutDetailTextFiledCellDelegate


- (void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title
{
    self.selectedTitle = title;
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
        _payModel.receiveMoney = [NSNumber numberWithDouble:price];
        [textField setText: [NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"缴费单通知号:"]) {
        _payModel.payNoticeNo =  textField.text;
    }
    else if ([title isEqualToString:@"购买金额:"]) {
        double price = [textField.text doubleValue];
        _payModel.packageBuyPrice = [NSNumber numberWithDouble:price];
        [textField setText: [NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"客户名称:"]) {
        _payModel.receiverName =  textField.text;
    }
    else if ([title isEqualToString:@"联系电话:"]) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        _payModel.phone =  textField.text;
    }
    else if ([title isEqualToString:@"预借款金额:"]) {
        double price = [textField.text doubleValue];
        _payModel.borrowMoney = [NSNumber numberWithDouble:price];
        [textField setText: [NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"收款金额:"]) {
        double price = [textField.text doubleValue];
        _payModel.receiveMoney = [NSNumber numberWithDouble:price];
        [textField setText: [NSString stringWithMoneyNumber:price]];
    }
    else if ([title isEqualToString:@"配送地址:"]) {
        _payModel.address =  textField.text;
    }
    else if ([title isEqualToString:@"配送备注:"]) {
        _payModel.remark =  textField.text;
    }
}

#pragma  mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    BOOL configureSuccess = YES;
    NSString *errString = @"保单信息错误";
    if (!isUsable(_payModel.policyId, [NSNumber class])) {
        errString = @"保单信息错误";
        configureSuccess = NO;
    }
    if (!isUsable(_payModel.policyTotalAmount, [NSNumber class])) {
        _payModel.policyTotalAmount = @(0.00);
    }
    if (!isUsableNSString(_payModel.payNoticeNo,@"")) {
        errString = @"缴费通知单号为空";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_payModel.receiverName,@"")) {
        errString = @"收件客户名称为空";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_payModel.phone, @"")) {
        errString = @"联系电话";
        configureSuccess = NO;
    }
    if (!isUsable(_payModel.borrowMoney, [NSNumber class])) {
        _payModel.borrowMoney = @(0.00);
    }
    if (!isUsable(_payModel.receiveMoney, [NSNumber class])) {
        _payModel.receiveMoney = @(0.00);
    }
    if (!isUsableNSString(_payModel.address, @"")) {
        errString = @"配送地址为空";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_payModel.remark, @"")) {
        _payModel.remark = @"";
    }


    if (configureSuccess) {
        NSLog(@"点击确认提交");
        __weak __typeof(self) weakSelf = self;
        NSDictionary *param = [_payModel yy_modelToJSONObject];
        [RequestAPI postSubmitPaymentList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            NSString * respnseStr = response[@"errormsg"];
            if ([response[@"result"] integerValue] == 1) {
                [strongSelf showAlterInfoWithNetWork:@"修改成功" complete:^{
                    [strongSelf resetData];
                }];
            }else {
                [strongSelf showAlterInfoWithNetWork:respnseStr complete:nil];
            }
            
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"修改失败" complete:nil];
            [weakSelf.view addSubview:tipsView];
        }];
    }else {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:errString complete:nil];
        [self.view addSubview:tipsView];
    }
}

#pragma mark - Privacy Method

- (void)resetData
{
//    _payModel = [[XCDistributionPaymentBillModel alloc] init];
//    _payModel.policyId = self.policyId;
//
//    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

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

- (BOOL)shouldSetTableViewOffsetWithTitle:(NSString *)title {
    
    if ([title isEqualToString:@"客户名称:"]) {
        return YES;
    }
    else if ([title isEqualToString:@"联系电话:"]) {
        return YES;
    }
    else if ([title isEqualToString:@"预借款金额:"]) {
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
#pragma mark -  ========== 添加键盘通知 ==========

- (void)addObserverKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeObserverKeyBoard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
#pragma mark - Setter&Getter

- (void)setPolicyId:(NSNumber *)policyId
{
    _policyId = policyId;
    _payModel.policyId = _policyId;
}


@end
