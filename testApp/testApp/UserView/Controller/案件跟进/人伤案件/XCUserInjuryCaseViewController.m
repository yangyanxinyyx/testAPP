//
//  XCUserInjuryCaseViewController.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserInjuryCaseViewController.h"
#import "XCUserInjuryCaseDetailViewController.h"
#import "XCUserCaseListModel.h"
#import "XCUserCaseDetailModel.h"
#import <YYModel.h>
@interface XCUserInjuryCaseViewController ()

@end

@implementation XCUserInjuryCaseViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseListCell class] forCellReuseIdentifier:kCaseListCellID];
}

#pragma mark - Init Method

#pragma mark - Action Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XCUserCaseListModel *model = self.dataArr[indexPath.row];
    
    NSDictionary *param = @{
                            @"id":model.caseID,
                            };
    __weak typeof (self)weakSelf = self;
    [RequestAPI getCustomerParticularsList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        BOOL configureSucess  = NO;
        if (response[@"data"]) {
            NSDictionary *dataInfo = response[@"data"];
            if(isUsable(dataInfo, [NSDictionary class])) {
                XCUserCaseDetailModel *detailModel = [XCUserCaseDetailModel yy_modelWithJSON:dataInfo];
                XCUserInjuryCaseDetailViewController *injuryCaseDetailVC = [[XCUserInjuryCaseDetailViewController alloc] initWithTitle:@"人伤案件跟进"];
                injuryCaseDetailVC.detailModel = detailModel;
                [self.navigationController pushViewController:injuryCaseDetailVC animated:YES];
                configureSucess = YES;
            }
        }
        if (!configureSucess) {
            [weakSelf requestFailureHandler];
        }
       [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        [weakSelf requestFailureHandler];
    }];
    
 
}

#pragma mark - Delegates & Notifications

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCUserCaseListModel *model =self.dataArr[indexPath.row];
    XCUserCaseListCell *cell = (XCUserCaseListCell *)[tableView dequeueReusableCellWithIdentifier:kCaseListCellID forIndexPath:indexPath];
    [cell setupCellWithCaseListModel:model caseTypeStr:@"无责案件"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160 * ViewRateBaseOnIP6;
}

#pragma mark - Privacy Method
- (void)requestFailureHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
    [self.view addSubview:tipsView];
}
- (void)requestSuccessHandler
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"撤销成功" complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Setter&Getter


@end
