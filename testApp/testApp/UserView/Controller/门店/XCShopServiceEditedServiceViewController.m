//
//  XCShopServiceEditedServiceViewController.m
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceEditedServiceViewController.h"
#import "XCUserViolationDetailHeaderView.h"
#define kdetailHeaderViewID @"detailHeaderViewID"
#define kimportTableCellID @"importTableCellID"

@interface XCShopServiceEditedServiceViewController ()<XCDistributionFooterViewDelegate,XCCheckoutDetailTextFiledCellDelegate>

/** 门店价格 */
@property (nonatomic, strong) NSNumber * price ;
/** 高级会员价格 */
@property (nonatomic, strong) NSNumber * vipPrice ;

/** <# 注释 #> */
@property (nonatomic, strong) UIButton * confirmBtn;
@end

@implementation XCShopServiceEditedServiceViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserViolationDetailHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID ];
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation - 98 * ViewRateBaseOnIP6 - kBottomMargan)];
    CGFloat tmpContentViewHeight =  (40 + 88 + 40 ) * ViewRateBaseOnIP6;
    CGFloat btnW = 690 * ViewRateBaseOnIP6;
    CGFloat btnH = 88 * ViewRateBaseOnIP6;
    [_confirmBtn setFrame:CGRectMake(30 * ViewRateBaseOnIP6,SCREEN_HEIGHT - tmpContentViewHeight + (tmpContentViewHeight - btnH) * 0.5 - safeAreaBottom , btnW, btnH)];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom  + tmpContentViewHeight))];
    
}

#pragma mark - Init Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"原价:",@"标准售价:",@"门店价格:",@"高级会员价格:"]];
}
- (void)initUI
{
    _confirmBtn = [UIButton buttonWithType:0];
    _confirmBtn.layer.cornerRadius = 5;
    _confirmBtn.layer.backgroundColor = COLOR_RGB_255(0, 77, 162).CGColor;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:36 * ViewRateBaseOnIP6];
    [_confirmBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
}
#pragma mark - Action Method

- (void)clickConfirmBtn:(UIButton *)button
{
    //提交审核
    [self.tableView endEditing:YES];
    
    if (!isUsable(_model.serviceId, [NSNumber class])) {
        _model.serviceId = [NSNumber numberWithDouble:0];
    }
    if (!isUsable(_model.storeID, [NSNumber class])) {
        _model.serviceId = [NSNumber numberWithDouble:0];
    }
    if (!isUsable([UserInfoManager shareInstance].storeID, [NSNumber class])) {
        [self showAlterInfoWithNetWork:@"非法门店ID" complete:nil];
        return;
    }
    if (!isUsable(self.price, [NSNumber class])) {
        _price = [NSNumber numberWithDouble:0];
    }
    if (!isUsable(self.vipPrice, [NSNumber class])) {
        _vipPrice = [NSNumber numberWithDouble:0];
    }
    
    
    if (_isNewService) {
        NSDictionary *param = @{
                                @"serviceId":self.model.serviceId,
                                @"storeId":[UserInfoManager shareInstance].storeID,
                                @"price":self.price,
                                @"vipPrice":self.vipPrice,
                                };
        __weak __typeof(self) weakSelf = self;
        [RequestAPI insertService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1) {
                [strongSelf showAlterInfoWithNetWork:@"提交成功" complete:^{
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }];
            }else {
                [strongSelf showAlterInfoWithNetWork:response[@"errormsg"] complete:nil];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
        }];
        
    }else {
        NSDictionary *param = @{
                                @"id":self.model.storeID,
                                @"price":self.price,
                                @"vipPrice":self.vipPrice,
                                };
        __weak __typeof(self) weakSelf = self;
        [RequestAPI updateService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            if ([response[@"result"] integerValue] == 1) {
                [strongSelf showAlterInfoWithNetWork:@"提交成功" complete:^{
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }];
            }else {
                [strongSelf showAlterInfoWithNetWork:response[@"errormsg"] complete:nil];
            }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
        } fail:^(id error) {
            __strong __typeof__(weakSelf)strongSelf = weakSelf;
            [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
        }];
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
    if ([title isEqualToString:@"门店价格:"]) {
        textField.text = [self.price stringValue];
    }
    else if ([title isEqualToString:@"高级会员价格:"]) {
        textField.text = [self.vipPrice stringValue];
    }
}
- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    NSMutableString *tmpTitleM = [NSMutableString stringWithString:title];
    NSArray *strArr = [tmpTitleM componentsSeparatedByString:@" "];
    if (strArr.count > 1) {
        title = strArr[1];
    }
    
    if ([title isEqualToString:@"门店价格:"]) {
        self.price = [NSNumber numberWithDouble:[textField.text doubleValue]];
        textField.text = [NSString stringWithMoneyNumber:[self.price  doubleValue]];

    }
    else if ([title isEqualToString:@"高级会员价格:"]) {
        self.vipPrice = [NSNumber numberWithDouble:[textField.text doubleValue]];
        textField.text = [NSString stringWithMoneyNumber:[self.vipPrice  doubleValue]];
    }

}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *titleName = self.dataArrM[indexPath.row];
    if (indexPath.row == 0) {
        XCCheckoutDetailTextCell *textCell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [textCell setTitle:titleName];
        if (isUsable(self.model.price, [NSNumber class])) {
            [textCell setTitlePlaceholder:[NSString stringWithMoneyNumber:[self.model.price doubleValue]]];
        }else {
            [textCell setTitlePlaceholder:@"¥0.00"]; 
        }
        textCell.shouldShowSeparator = YES;
        return textCell;
    }
    else if (indexPath.row == 1) {
        XCCheckoutDetailTextCell *textCell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        textCell.shouldShowSeparator = YES;
        [textCell setTitle:titleName];
        if (isUsable(self.model.vipPrice, [NSNumber class])) {
            [textCell setTitlePlaceholder:[NSString stringWithMoneyNumber:[self.model.vipPrice doubleValue]]];
        }else {
            [textCell setTitlePlaceholder:@"¥0.00"];
        }
        return textCell;
    }
        XCCheckoutDetailTextFiledCell *textFiledCell = [[XCCheckoutDetailTextFiledCell alloc] init];
        textFiledCell.delegate = self;
        textFiledCell.shouldShowSeparator = YES;
        [textFiledCell setTitle:titleName];
        [textFiledCell setTitlePlaceholder:@"输入价格"];
        textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        textFiledCell.isNumField = YES;
        return textFiledCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - Privacy Method
- (void)showAlterInfoWithNetWork:(NSString *)titleStr complete:(void (^)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:complete];
        [self.view addSubview:tipsView];
    });
  
}
#pragma mark - Setter&Getter
- (void)setModel:(XCShopServiceModel *)model
{
    _model = model;
    
}
@end
