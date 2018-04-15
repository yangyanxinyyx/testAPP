//
//  XCUserRepairDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserRepairDetailViewController.h"
#import "XCUserCaseDetailTextCell.h"
#import "XCUserCaseDetailProgressCell.h"
#define kDetailTextCellID @"DetailTextCellID"
#define kDetailProgressCellID @"DetailProgressCellID"
@interface XCUserRepairDetailViewController ()

@end

@implementation XCUserRepairDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseDetailProgressCell class] forCellReuseIdentifier:kDetailProgressCellID];
    [self.tableView registerClass:[XCUserCaseDetailTextCell class] forCellReuseIdentifier:kDetailTextCellID];
    
    
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
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation )];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configureData
{
    NSArray *baseTitleNameArr = @[@"客户名称:",@"车牌号:",@"车品牌:",
                                  @"车架号:",@"发动机号:",@"车型代码:",
                                  @"联系电话:",@"接车时间:",@"联系地址:",
                                  @"预计完成时间:",@"维修项目:",@"备注:"];
    self.dataTitleArrM = [[NSMutableArray alloc] initWithArray:baseTitleNameArr];
    
}

- (void)initUI
{
    
}

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
- (void)setCarTranDetailModel:(XCCarTransactioDetailModel *)carTranDetailModel
{
    _carTranDetailModel = carTranDetailModel;
    
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //进度状态Cell
        XCUserCaseDetailProgressCell *processCell =  (XCUserCaseDetailProgressCell *)[tableView dequeueReusableCellWithIdentifier:kDetailProgressCellID forIndexPath:indexPath];
        //        NSArray *processArr = @[@"处理完毕",@"服务中..."];
        //        [processCell setProcessStrArr:processArr];
        [processCell setProcessStr:_carTranDetailModel.status];
        if ([_carTranDetailModel.status isEqualToString:@"处理完毕"]) {
            [processCell setIsFinish:YES];
        }else {
            [processCell setIsFinish:NO];
        }
        return processCell;
    }
    else {
        //基本信息Cell
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kDetailTextCellID forIndexPath:indexPath];
        [detailTextCell setTitleStr:@"基本信息"];
        [detailTextCell setLabelArrM:self.dataTitleArrM];
        [detailTextCell setupCellWithRepairCarTranDetailModel:_carTranDetailModel];
        return detailTextCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        return [XCUserCaseDetailProgressCell getCellHeight];
    }else {
        return 720 * ViewRateBaseOnIP6;
    }
}
@end
