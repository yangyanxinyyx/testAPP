//
//  XCUserChargebackListDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserChargebackListDetailViewController.h"
#import "SelectTimeView.h"
#import "LYZSelectView.h"
@interface XCUserChargebackListDetailViewController ()<XCCheckoutDetailTextFiledCellDelegate>
@property (nonatomic, strong) UIButton * commitBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * policyCompanyArrM ;
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
                                  @"品牌型号:",@"车型代码:",@"(商业)起保日期:",
                                  @"(交强)起保日期:",@"保险公司:",
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

        if ([response[@"result"] integerValue] == 1) {
            [strongSelf showAlterInfoWithNetWork:@"提交成功" complete:^{
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [strongSelf showAlterInfoWithNetWork:@"提交失败" complete:nil];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView endEditing:YES];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    __weak __typeof(self) weakSelf = self;
    if (indexPath.section == 0 && indexPath.row == 10) {
        //保险公司
        if (self.policyCompanyArrM) {
            LYZSelectView * alterView = [LYZSelectView alterViewWithArray:self.policyCompanyArrM confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                weakSelf.detailModel.insurerName = selectStr;
                [(XCCheckoutDetailTextFiledCell *)cell setTitlePlaceholder:selectStr];
            }];
            [self.view addSubview:alterView];
        }else{
            if (!self.policyCompanyArrM) {
                //获取保险公司
                _policyCompanyArrM = [[NSMutableArray alloc] init];
                if (_detailModel.exportUnitName) {
                    NSDictionary *param = @{
                                            @"dictCode":_detailModel.exportUnitName,
                                            };
                    [RequestAPI getInsuredrice:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                        if (isUsable(response[@"data"], [NSArray class])) {
                            NSArray *dataArr = response[@"data"];
                            for (NSDictionary *dataInfo in dataArr) {
                                NSString *policyName = dataInfo[@"content"];
                                [_policyCompanyArrM addObject:policyName];
                            }
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            LYZSelectView * alterView = [LYZSelectView alterViewWithArray:self.policyCompanyArrM confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                                weakSelf.detailModel.insurerName = selectStr;
                                [(XCCheckoutDetailTextFiledCell *)cell setTitlePlaceholder:selectStr];
                            }];
                            [weakSelf.view addSubview:alterView];
                        });
                        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    } fail:^(id error) {
                        __strong __typeof__(weakSelf)strongSelf = weakSelf;
                        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
                        _policyCompanyArrM = nil;
                    }];
                }else {
                    [self showAlterInfoWithNetWork:@"退单无出单机构信息" complete:nil];
                    _policyCompanyArrM = nil;
                }
            }
        }
    }
    else if (indexPath.section == 0 && indexPath.row == 8) {
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
    else if (indexPath.section == 0 && indexPath.row == 16) {
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
- (void)XCCheckoutDetailTextFiledBeginEditing:(UITextField *)textField title:(NSString *)title
{
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    if ([title isEqualToString:@"交强险(业务员)金额:"]) {
        if (isUsable(self.detailModel.jqMoney, [NSNumber class])) {
            textField.text =  [self.detailModel.jqMoney stringValue];
        }
    }
    else if ([title isEqualToString:@"商业险(业务员)金额:"]) {
        if (isUsable(self.detailModel.syMoney, [NSNumber class])) {
            textField.text =  [self.detailModel.syMoney stringValue];
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
    BOOL isDoubleCellType = NO;
    if ([title isEqualToString:@"交强险(业务员)金额:"]) {
        self.detailModel.jqMoney = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    else if ([title isEqualToString:@"商业险(业务员)金额:"]) {
        self.detailModel.syMoney = [NSNumber numberWithDouble:[textField.text doubleValue]];
        isDoubleCellType = YES;
    }
    if (isDoubleCellType) {
        double num = [textField.text doubleValue];
        textField.text = [NSString stringWithMoneyNumber:num];
    }
}

#pragma mark - Privacy Method

- (BOOL)isMoneyCellWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 11 || indexPath.row == 12)
    {
        return  YES;
    }
    return NO;
}


#pragma mark - Setter&Getter
- (void)setDetailModel:(XCCheckoutDetailBaseModel *)detailModel
{
    _detailModel = detailModel;
    
   
}
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
    if (indexPath.section == 0 && (indexPath.row == 10 ||
                                   [self isMoneyCellWithIndexPath:indexPath] )) {
    
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
//        [textFiledCell setTitle:title];
        textFiledCell.titleLabel.attributedText = [NSString stringWithImportentValue:title];

        NSString *placetext ;
  
        if ([self isMoneyCellWithIndexPath:indexPath]) {
            textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            placetext = @"输入金额";
        }else {
            if (indexPath.row == 10 ) {
                placetext = @"请选择";
            }
        }
        [textFiledCell setTitlePlaceholder:placetext];
        if ([title isEqualToString:@"交强险(业务员)金额:"]) {
            if (isUsable(self.detailModel.jqMoney, [NSNumber class])) {
                textFiledCell.textField.text = [NSString stringWithMoneyNumber:[self.detailModel.jqMoney doubleValue]];
            }else {
                textFiledCell.textField.text = @"¥0.00";
            }
        }
        else if ([title isEqualToString:@"商业险(业务员)金额:"]) {
            if (isUsable(self.detailModel.syMoney, [NSNumber class])) {
                textFiledCell.textField.text = [NSString stringWithMoneyNumber:[self.detailModel.syMoney doubleValue]];
            }else {
                textFiledCell.textField.text = @"¥0.00";
            }
        }
        textFiledCell.delegate = self;
        if (indexPath.section == 0 && indexPath.row == 10) {
            //保险公司
            textFiledCell.textField.text = _detailModel.insurerName;
            textFiledCell.textField.userInteractionEnabled = NO;
        }else {
            textFiledCell.textField.userInteractionEnabled = YES;
        }
        return textFiledCell;
    }else if (indexPath.section == 0 && indexPath.row == 17 - 1){
        XCCheckoutDetailInputCell *inputCell = (XCCheckoutDetailInputCell *)[tableView dequeueReusableCellWithIdentifier:kTextInputCellID forIndexPath:indexPath];
//        [inputCell setTitle:title];
        inputCell.titleLabel.attributedText = [NSString stringWithImportentValue:title];

        [inputCell setIsContinue:_detailModel.isContinue];
        return inputCell;
    }else {
        XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [cell setTitle:title];
        if (indexPath.section == 0 && (indexPath.row == 8 ||indexPath.row == 9)) {
            cell.titleLabel.attributedText = [NSString stringWithImportentValue:title];
        }
        [cell setupCellWithChargeBackModel:_detailModel];
        return cell;
    }
}

@end
