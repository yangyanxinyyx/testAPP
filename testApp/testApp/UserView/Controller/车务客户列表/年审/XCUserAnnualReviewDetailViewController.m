//
//  XCUserAnnualReviewDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserAnnualReviewDetailViewController.h"
#import "XCUserCaseDetailTextCell.h"
#import "XCUserCaseDetailProgressCell.h"
#import "XCUserCaseScrollerViewCell.h"
#import "XCPhotoPreViewController.h"
#define kDetailTextCellID @"DetailTextCellID"
#define kDetailProgressCellID @"DetailProgressCellID"
#define kDetailScrollerCellID @"DetailScrollerCellID"
@interface XCUserAnnualReviewDetailViewController ()<XCUserCaseScrollerViewCellDelegate>
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * imageURLArrM ;
@end

@implementation XCUserAnnualReviewDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageURLArrM = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[XCUserCaseDetailProgressCell class] forCellReuseIdentifier:kDetailProgressCellID];
    [self.tableView registerClass:[XCUserCaseDetailTextCell class] forCellReuseIdentifier:kDetailTextCellID];
    [self.tableView registerClass:[XCUserCaseScrollerViewCell class] forCellReuseIdentifier:kDetailScrollerCellID];

    [self initUI];
    [self configureData];
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation )];
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma marl - XCUserCaseScrollerViewCellDelegate
- (void)XCUserCaseScrollerViewCellClickphotoWithURL:(NSURL *)photoURL index:(NSInteger)index cell:(XCUserCaseScrollerViewCell *)cell
{
    XCPhotoPreViewController *vc = [[XCPhotoPreViewController alloc] initWithTitle:@"照片预览"sources:self.imageURLArrM];
    [vc updatePositionWithIndex:index];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Privacy Method

- (void)configureData
{
    NSArray *baseTitleNameArr = @[@"客户名称:",@"车牌号:",@"车品牌:",
                                  @"车架号:",@"发动机号:",@"车型代码:",
                                  @"联系电话:",@"年审到期时间:",@"备注:"];
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
    if (_carTranDetailModel.url1) {
        [_imageURLArrM addObject:_carTranDetailModel.url1];
    }
    if (_carTranDetailModel.url2) {
        [_imageURLArrM addObject:_carTranDetailModel.url2];
    }
    if (_carTranDetailModel.url3) {
        [_imageURLArrM addObject:_carTranDetailModel.url3];
    }
    if (_carTranDetailModel.url4) {
        [_imageURLArrM addObject:_carTranDetailModel.url4];
    }
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        //进度状态Cell
        XCUserCaseDetailProgressCell *processCell =  (XCUserCaseDetailProgressCell *)[tableView dequeueReusableCellWithIdentifier:kDetailProgressCellID forIndexPath:indexPath];

        [processCell setProcessStr:_carTranDetailModel.status];
        if ([_carTranDetailModel.status isEqualToString:@"处理完毕"]) {
            [processCell setIsFinish:YES];
        }else {
            [processCell setIsFinish:NO];
        }
        return processCell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //基本信息Cell
        XCUserCaseDetailTextCell *detailTextCell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kDetailTextCellID forIndexPath:indexPath];
        [detailTextCell setTitleStr:@"基本信息"];
        [detailTextCell setLabelTitleArrM:self.dataTitleArrM];
        [detailTextCell setupCellWithCarTransactionDetailModel:_carTranDetailModel];
        return detailTextCell;
    }
    else {
        //ScrollerViewCell
        XCUserCaseScrollerViewCell *scrollerCell =  (XCUserCaseScrollerViewCell *)[tableView dequeueReusableCellWithIdentifier:kDetailScrollerCellID forIndexPath:indexPath];
        scrollerCell.delegate = self;
        [scrollerCell setTitleStr:@"相关文件:"];
        [scrollerCell setPhotoURLArr:_imageURLArrM];
        return scrollerCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        return [XCUserCaseDetailProgressCell getCellHeight];
    }else if (indexPath.row == 1) {
        return  [XCUserCaseDetailTextCell getCellHeight];
    }else {
        return [XCUserCaseScrollerViewCell getCellHeight];
    }
}
@end
