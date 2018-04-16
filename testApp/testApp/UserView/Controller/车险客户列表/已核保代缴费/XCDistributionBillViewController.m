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
#define ktableViewH SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom)

@interface XCDistributionBillViewController ()<UITableViewDelegate,UITableViewDataSource,
XCDistributionFooterViewDelegate,XCCheckoutDetailTextFiledCellDelegate>
@property (nonatomic, strong) NSArray * titleArr ;
/** <# 注释 #> */
@property (nonatomic, strong) XCDistributionPaymentBillModel * payModel ;

@property (nonatomic, strong) SelectTimeView * DistributonSelectTimeV ;

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
    
    __weak typeof (self)weakSelf = self;

    _DistributonSelectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _DistributonSelectTimeV.hidden = YES;
    self.DistributonSelectTimeV.block = ^(NSString *string ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        XCDistributionPicketCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        [cell setTitleValue:string];
        weakSelf.payModel.shipmentTime = string;
    };
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:_DistributonSelectTimeV];

}

#pragma mark - Action Method


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof (self)weakSelf = self;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([NSStringFromClass([cell class]) isEqualToString:NSStringFromClass([XCDistributionPicketCell class])]) {
        if ((indexPath.section == 0 && indexPath.row == 5)) {
            //选择时间
           // [self.DistributonSelectTimeV inputSelectTiemView:YES];

        }
        else if(indexPath.section == 0 && indexPath.row == 4){
            NSArray * arr = @[@"礼包一",@"礼包二",@"礼包三"];
            LYZSelectView *alterView = [LYZSelectView alterViewWithArray:arr confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                weakSelf.payModel.packageId = selectStr;
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
    textFiledCell.delegate = self;
    
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

#pragma mark - XCCheckoutDetailTextFiledCellDelegate

- (void)XCCheckoutDetailTextFiledSubmitTextField:(NSString *)textFiledString title:(NSString *)title
{
    if ([title isEqualToString:@"保单金额:"]) {
        double price = [textFiledString doubleValue];
        _payModel.receiveMoney = [NSNumber numberWithDouble:price];
    }
    else if ([title isEqualToString:@"缴费单通知号:"]) {
        _payModel.payNoticeNo =  textFiledString;
    }
    else if ([title isEqualToString:@"购买金额:"]) {
        double price = [textFiledString doubleValue];
        _payModel.packageBuyPrice = [NSNumber numberWithDouble:price];
    }
    else if ([title isEqualToString:@"客户名称:"]) {
        _payModel.receiverName =  textFiledString;
    }
    else if ([title isEqualToString:@"联系电话:"]) {
        _payModel.phone =  textFiledString;
    }
    else if ([title isEqualToString:@"预借款金额:"]) {
        double price = [textFiledString doubleValue];
        _payModel.borrowMoney = [NSNumber numberWithDouble:price];
    }
    else if ([title isEqualToString:@"收款金额:"]) {
        double price = [textFiledString doubleValue];
        _payModel.receiveMoney = [NSNumber numberWithDouble:price];
    }
    else if ([title isEqualToString:@"配送地址:"]) {
        _payModel.address =  textFiledString;
    }
    else if ([title isEqualToString:@"配送备注:"]) {
        _payModel.remark =  textFiledString;
    }
}

#pragma  mark - XCDistributionFooterViewDelegate

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    BOOL configureSuccess = YES;
    NSString *errString = @"保单信息错误";
    if (_payModel.policyId) {
        errString = @"保单信息错误";
        configureSuccess = NO;
    }
    if ([_payModel.policyTotalAmount isEqualToNumber:[NSNumber numberWithDouble:0]]) {
        errString = @"保单金额为0";
        configureSuccess = NO;
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
    if ([_payModel.borrowMoney isEqualToNumber:[NSNumber numberWithDouble:0]]) {
        errString = @"预借款金额为0";
        configureSuccess = NO;
    }
    if ([_payModel.receiveMoney isEqualToNumber:[NSNumber numberWithDouble:0]]) {
        errString = @"收款金额为0";
        configureSuccess = NO;
    }
    if (!isUsableNSString(_payModel.address, @"")) {
        errString = @"配送地址为空";
        configureSuccess = NO;
    }

    if (configureSuccess) {
        NSLog(@"点击确认提交");
        __weak typeof (self)weakSelf = self;
        
        NSDictionary *param = [_payModel yy_modelToJSONObject];
        [RequestAPI postSubmitPaymentList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            if ([response[@"data"] isEqualToString:@"true"]) {
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"修改成功" complete:nil];
                [weakSelf.view addSubview:tipsView];
            }else {
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交失败" complete:nil];
                [weakSelf.view addSubview:tipsView];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"提交失败" complete:nil];
            [weakSelf.view addSubview:tipsView];
        }];
        
        
    }else {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:errString complete:nil];
        [self.view addSubview:tipsView];
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



@end
