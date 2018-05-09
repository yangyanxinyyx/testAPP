//
//  XCUserUnderWritingDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserUnderWritingDetailViewController.h"
#import "XCCheckoutDetailBaseModel.h"
@interface XCUserUnderWritingDetailViewController ()

@property (nonatomic, strong) UIButton * commitBtn ;

@end

@implementation XCUserUnderWritingDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailInputCell class] forCellReuseIdentifier:kTextInputCellID];

    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat buttonH = 98 * ViewRateBaseOnIP6;
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + buttonH + safeAreaBottom))];
    [_commitBtn setFrame:CGRectMake(0,  CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, buttonH)];
    
}

#pragma mark - Action Method

- (void)commitUnderWriting:(UIButton *)button
{
    __weak __typeof(self) weakSelf = self;
    LYZAlertView *alertView = [LYZAlertView alterViewWithTitle:@"是否撤销" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (isUsable(strongSelf.model.BillID, [NSNumber class])) {
            NSDictionary *param = @{
                                    @"id":strongSelf.model.BillID,
                                    };
            [RequestAPI postPolicyRevokeBySaleMan:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if ([response[@"result"] boolValue] == 1) {
                    [strongSelf showAlterInfoWithNetWork:@"提交成功,待审核" complete:^{
                        [strongSelf.navigationController popViewControllerAnimated:YES];
                    }];
                }
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
            } fail:^(NSError  *error) {
//                __strong __typeof__(weakSelf)strongSelf = weakSelf;
//                NSString *errStr = @"网络请求失败!";
//                if (error.code == NSURLErrorTimedOut) {
//                    errStr = @"网络请求超时!";
//                }
//                if (isUsableNSString(error.userInfo[NSLocalizedDescriptionKey], @"")) {
//                    errStr = error.userInfo[NSLocalizedDescriptionKey];
//                }
                [strongSelf showAlterInfoWithNetWork:@"撤销失败" complete:nil];
            }];
        }else {
            [strongSelf showAlterInfoWithNetWork:@"参数错误" complete:nil];
        }
    }];

    [self.view addSubview:alertView];
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configureData
{
    // 12 15 16 有输入
    NSArray *baseTitleNameArr = @[@"投保人:",@"身份证:",@"车牌号:",
                                  @"车架号:",@"初登日期:",@"发动机号:",
                                  @"品牌型号:",@"(商业)起保日期:",
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
    [_commitBtn setTitle:@"撤销核保" forState:UIControlStateNormal];
    [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:36 * ViewRateBaseOnIP6]];
    [_commitBtn addTarget:self action:@selector(commitUnderWriting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
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
    
    if (indexPath.section == 0 && indexPath.row == 18 - 1){
        BOOL mark = NO;
        if ([self.model.isContinue isEqualToString:@"Y"])
        {
            mark = YES;
        }
        XCCheckoutDetailInputCell *inputCell = (XCCheckoutDetailInputCell *)[tableView dequeueReusableCellWithIdentifier:kTextInputCellID forIndexPath:indexPath];
        [inputCell setTitle:title];
        [inputCell setIsContinue:mark];
        inputCell.userInteractionEnabled = NO;
        
        return inputCell;
    }else {
        XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [cell setTitle:title];
        [cell setTitlePlaceholder:@""];
        [cell setupCellWithDetailPolicyModel:self.model];
        return cell;
    }
}


@end
