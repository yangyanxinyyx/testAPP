//
//  XCUserChargebackListDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserChargebackListDetailViewController.h"
#import "SelectTimeView.h"
@interface XCUserChargebackListDetailViewController ()<XCCheckoutDetailTextFiledCellDelegate>
@property (nonatomic, strong) UIButton * commitBtn ;

@end

@implementation XCUserChargebackListDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCCheckoutDetailInputCell class] forCellReuseIdentifier:kTextInputCellID];
    
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat buttonH = 98 * ViewRateBaseOnIP6;
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + buttonH))];
    [_commitBtn setFrame:CGRectMake(0,  CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, buttonH)];
    
}

#pragma mark - Init Method
- (void)configureData
{
    // 12 15 16 有输入
    NSArray *baseTitleNameArr = @[@"投保人:",@"身份证:",@"车牌号:",
                                  @"车架号:",@"初登日期:",@"发动机号:",
                                  @"车型名称:",@"车型代码:",@"(商业)起保日期:",
                                  @"(交强)起保日期:",@"保险公司:",@"缴费通知单号:",
                                  @"交强险(业务员)金额:",@"商业险(业务员)金额:",@"交强险(出单员)金额:",
                                  @"商业险(出单员)金额:",@"出单员:",@"是否续保"];
    NSArray *policyTitleNameArr = @[@"交强险:",@"机动车损险:",@"第三责任险:",@"车上(司机)险:",@"车上(乘客)险:"];
    self.dataTitleArrM = [[NSMutableArray alloc] init];
    [self.dataTitleArrM addObject:baseTitleNameArr];
    [self.dataTitleArrM addObject:policyTitleNameArr];
}

- (void)initUI
{
    self.bottomHeight = 98 * ViewRateBaseOnIP6;
    
    _commitBtn = [UIButton buttonWithType:0];
    [_commitBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
    [_commitBtn setTitle:@"提交核保" forState:UIControlStateNormal];
    [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:36 * ViewRateBaseOnIP6]];
    [_commitBtn addTarget:self action:@selector(commitUnderWriting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
}

#pragma mark - Action Method

- (void)commitUnderWriting:(UIButton *)button
{
    NSDictionary *param = [self.detailModel yy_modelToJSONObject];
    __weak __typeof(self) weakSelf = self;
    [RequestAPI submitPolicyAfterRevoke:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;

        NSString * respnseStr = response[@"errormsg"];
        if ([response[@"result"] integerValue] == 1) {
            [strongSelf showAlterInfoWithNetWork:@"提交成功，待审核"];
        }else {
            [strongSelf showAlterInfoWithNetWork:respnseStr];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
        [strongSelf showAlterInfoWithNetWork:errStr];
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView endEditing:YES];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    __weak __typeof(self) weakSelf = self;
    if (indexPath.section == 0 && indexPath.row == 8) {
        //商业 起保日期
        SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        selectView.block = ^(NSString *string) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [(XCCheckoutDetailTextCell *)cell setTitlePlaceholder:string];
            strongSelf.detailModel.syEffectDate = string;
        };
        [self.view addSubview:selectView];
    }
    else if (indexPath.section == 0 && indexPath.row == 9) {
        //交强 起保日期
        SelectTimeView *selectView = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        selectView.block = ^(NSString *string) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [(XCCheckoutDetailTextCell *)cell setTitlePlaceholder:string];
            strongSelf.detailModel.jqEffectDate = string;
        };
        [self.view addSubview:selectView];
    }
    else if (indexPath.section == 0 && indexPath.row == 17) {
        BOOL selected = NO ;
        if ([self.detailModel.isContinue isEqualToString:@"Y"]) {
            self.detailModel.isContinue = @"N";
            selected = NO;
        }else {
            self.detailModel.isContinue = @"Y";
            selected = YES;
        }
        [(XCCheckoutDetailInputCell *)cell setIsContinue:selected];
        
    }
    
}


#pragma mark - Delegates & Notifications
#pragma mark - XCCheckoutDetailTextFiledCellDelegate

- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    BOOL isDoubleCellType = NO;
    if ([title isEqualToString:@"缴费通知单号:"]) {
        self.detailModel.payNoticeNo = textField.text;
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"交强险(业务员)金额:"]) {
        self.detailModel.jqMoney = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"商业险(业务员)金额:"]) {
        self.detailModel.syMoney = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"交强险(出单员)金额:"]) {
        self.detailModel.jqMoneyExport = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"商业险(出单员)金额:"]) {
        self.detailModel.syMoneyExport = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"商业险(出单员)金额:"]) {
        self.detailModel.syMoneyExport = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"保险公司:"]) {
        self.detailModel.insurerName = textField.text;
    }
    else if ([title isEqualToString:@"出单员:"]) {
        self.detailModel.exportmanName = textField.text;
    }
    
    if (isDoubleCellType) {
        double num = [textField.text doubleValue];
        textField.text = [NSString stringWithFormat:@"%.2f",num];
    }
}

#pragma mark - Privacy Method

- (BOOL)isMoneyCellWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 12 || indexPath.row == 13|| indexPath.row == 14 || indexPath.row == 15)
    {
        return  YES;
    }
    return NO;
}


#pragma mark - Setter&Getter

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataTitleArrM.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArr = self.dataTitleArrM[section];
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *titleArr = self.dataTitleArrM[indexPath.section];
    NSString *title = titleArr[indexPath.row];
    if (indexPath.section == 0 && (indexPath.row == 10 || indexPath.row == 11||
                                   [self isMoneyCellWithIndexPath:indexPath]||indexPath.row == 16 )) {
    
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        [textFiledCell setTitle:title];
        NSString *placetext ;
        if (indexPath.row == 11) {
            placetext = @"输入单号";
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        }else if ([self isMoneyCellWithIndexPath:indexPath]) {
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            placetext = @"输入金额";
        }else {
            placetext = @"请输入";
        }
        [textFiledCell setTitlePlaceholder:placetext];
        textFiledCell.delegate = self;
        return textFiledCell;
    }else if (indexPath.section == 0 && indexPath.row == 18 - 1){
        XCCheckoutDetailInputCell *inputCell = (XCCheckoutDetailInputCell *)[tableView dequeueReusableCellWithIdentifier:kTextInputCellID forIndexPath:indexPath];
        [inputCell setTitle:title];
        
        return inputCell;
    }else {
        XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [cell setTitle:title];
        [cell setTitlePlaceholder:@"刘某某"];
        return cell;
    }
}

@end
