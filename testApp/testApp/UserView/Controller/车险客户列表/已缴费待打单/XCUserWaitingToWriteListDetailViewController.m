//
//  XCUserWaitingToWriteListDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserWaitingToWriteListDetailViewController.h"
#import "XCCheckoutDetailBaseModel.h"

@interface XCUserWaitingToWriteListDetailViewController ()

@end

@implementation XCUserWaitingToWriteListDetailViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation  + safeAreaBottom))];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configureData
{
    NSArray *baseTitleNameArr = @[@"投保人:",@"身份证:",@"车牌号:",
                                  @"车架号:",@"初登日期:",@"发动机号:",
                                  @"品牌型号:",@"车型代码:",@"(商业)起保日期:",
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
    
    //    if (indexPath.section == 0 && (indexPath.row == 12 - 1 || indexPath.row == 15 - 1 || indexPath.row == 16 - 1)) {
    //        NSString *placetext ;
    //        if (indexPath.row == 12 - 1) {
    //            placetext = @"输入单号";
    //        }else if (indexPath.row == 15 - 1  || indexPath.row == 16 - 1) {
    //            placetext = @"输入金额";
    //        }
    //        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
    //        [textFiledCell setTitle:title];
    //        [textFiledCell setTitlePlaceholder:placetext];
    //        return textFiledCell;
    //    }
    //    else
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
        [cell setupCellWithDetailPolicyModel:self.model];
//                [cell setTitlePlaceholder:@"刘某某"];
        return cell;
    }
}
@end
