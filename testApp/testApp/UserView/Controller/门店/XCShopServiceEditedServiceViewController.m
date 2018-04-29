//
//  XCShopServiceEditedServiceViewController.m
//  testApp
//
//  Created by Melody on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceEditedServiceViewController.h"
#import "XCUserViolationDetailHeaderView.h"
#import "PriceUnderwritingImportTableViewCell.h"
#define kdetailHeaderViewID @"detailHeaderViewID"
#define kimportTableCellID @"importTableCellID"

@interface XCShopServiceEditedServiceViewController ()<XCDistributionFooterViewDelegate,PriceUnderwritingImportTableViewCellDelegate,XCCheckoutDetailTextFiledCellDelegate>

/** 价格 */
@property (nonatomic, strong) NSNumber * price ;
/** 高级会员价格 */
@property (nonatomic, strong) NSNumber * vipPrice ;
/** 描述 */
@property (nonatomic, copy) NSString * remark ;
@end

@implementation XCShopServiceEditedServiceViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserViolationDetailHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderViewID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID ];
    [self.tableView registerClass:[XCDistributionFooterView class] forHeaderFooterViewReuseIdentifier:kFooterViewID];
        [self.tableView registerClass:[PriceUnderwritingImportTableViewCell class] forCellReuseIdentifier:kimportTableCellID];
    
    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}

#pragma mark - Init Method

- (void)configureData
{
    self.dataArrM = [[NSMutableArray alloc] initWithArray:@[@"原价:",@"价格:",@"服务介绍"]];
}
- (void)initUI
{
    
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - XCCheckoutDetailTextFiledCellDelegate
- (void)XCCheckoutDetailTextFiledSubmitTextField:(UITextField *)textField title:(NSString *)title
{
    XCCheckoutDetailTextFiledCell *twoTextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (textField == twoTextCell.textField) {
        self.price = [NSNumber numberWithDouble:[textField.text doubleValue]];
        twoTextCell.textField.text = [NSString stringWithMoneyNumber:[textField.text doubleValue]];
    }else if (textField == twoTextCell.secondTextField) {
        self.vipPrice = [NSNumber numberWithDouble:[textField.text doubleValue]];
        twoTextCell.secondTextField.text = [NSString stringWithMoneyNumber:[textField.text doubleValue]];

    }
}

#pragma mark - PriceUnderwritingImportTableViewCellDelegate
- (void)textViewENDWithTextView:(UITextView *)textView
{
    self.remark = textView.text;
}

#pragma mark - XCDistributionFooterViewDelegate
- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn
{
    [self.tableView endEditing:YES];
    
    BOOL configureSuccess = YES;
    if (!isUsable(_model.serviceId, [NSNumber class])) {
        configureSuccess = NO;
    }
    if (!isUsable(self.price, [NSNumber class])) {
        configureSuccess = NO;
    }
    if (!isUsable(self.vipPrice, [NSNumber class])) {
        configureSuccess = NO;
    }
    
    if (!configureSuccess) {
        [self showAlterInfoWithNetWork:@"请输入正确信息"];
        return;
    }

    NSDictionary *param = @{
                            @"id":_model.serviceId,
                            @"price":self.price,
                            @"vipPrice":self.vipPrice,
                            };
    __weak __typeof(self) weakSelf = self;
    [RequestAPI updateService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if ([response[@"result"] integerValue] == 1) {
            [strongSelf showAlterInfoWithNetWork:@"修改成功"];
        }else {
            [strongSelf showAlterInfoWithNetWork:response[@"errormsg"]];
        }
        [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        NSString *errStr = [NSString stringWithFormat:@"error:%@",error];
        [strongSelf showAlterInfoWithNetWork:errStr];
    }];
    

}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        textFiledCell.userInteractionEnabled = NO;
        textFiledCell.isTopShowSeparator = YES;
        textFiledCell.isTwoInputType = NO;
        [textFiledCell setTitle:[NSString stringWithFormat:@"原价: %@",[NSString stringWithMoneyNumber:[_model.price doubleValue]]]];
     
        return textFiledCell;
    }
    else if (indexPath.row == 1) {
        XCCheckoutDetailTextFiledCell *textFiledCell = [[XCCheckoutDetailTextFiledCell alloc] init];
        textFiledCell.delegate = self;
        textFiledCell.isTwoInputType = YES;
        textFiledCell.isTopShowSeparator = YES;
        [textFiledCell setTitle:@"价格:"];
        [textFiledCell setTitlePlaceholder:@"输入价格"];
        [textFiledCell setSecondTitle:@"高级会员价:"];
        [textFiledCell setSecondTitlePlaceholder:@"输入价格"];
        textFiledCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        textFiledCell.secondTextField.keyboardType = UIKeyboardTypeDecimalPad;
        textFiledCell.isNumField = YES;
        return textFiledCell;
    }else {
        PriceUnderwritingImportTableViewCell *cell = (PriceUnderwritingImportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kimportTableCellID forIndexPath:indexPath];
        [cell.labelName setText:@"服务介绍:"];
        cell.textView.text = @"服务描述...";
        cell.delegate = self;
        return cell;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];
    [footerView.contentView setBackgroundColor:[UIColor whiteColor]];
    [footerView setTitle:@"保存"];
    footerView.delegate = self;
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XCUserViolationDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    [headerView setGroupName:self.model.serviceName];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 233 * ViewRateBaseOnIP6;
    }
    return 88 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [XCUserViolationDetailHeaderView getHeaderViewHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerViewHeigth;
    footerViewHeigth = (60 + 88 + 60) * ViewRateBaseOnIP6;
    return footerViewHeigth;
}

#pragma mark - Privacy Method
- (void)showAlterInfoWithNetWork:(NSString *)titleStr
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Setter&Getter
- (void)setModel:(XCShopServiceModel *)model
{
    _model = model;
    
}
@end
