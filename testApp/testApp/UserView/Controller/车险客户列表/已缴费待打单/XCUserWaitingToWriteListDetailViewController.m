//
//  XCUserWaitingToWriteListDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserWaitingToWriteListDetailViewController.h"

@interface XCUserWaitingToWriteListDetailViewController ()

@property (nonatomic, strong) UIButton * commitBtn ;

@end

@implementation XCUserWaitingToWriteListDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"已缴费详情";
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCCheckoutDetailInputCell class] forCellReuseIdentifier:kTextInputCellID];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view setFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    CGFloat tableViewH = self.tableView.frame.size.height;
    [_commitBtn setFrame:CGRectMake(0, self.tableView.frame.origin.y + tableViewH + 40 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6)];
}

#pragma mark - Action Method

- (void)commitUnderWriting:(UIButton *)button
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"保存成功!" complete:nil];
    [self.view addSubview:tipsView];
    
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)initUI
{
    self.bottomHeight = (40 + 98) * ViewRateBaseOnIP6;
    
    _commitBtn = [UIButton buttonWithType:0];
    [_commitBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
    [_commitBtn setTitle:@"保存文档" forState:UIControlStateNormal];
    [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:36 * ViewRateBaseOnIP6]];
    [_commitBtn addTarget:self action:@selector(commitUnderWriting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
}
#pragma mark - Setter&Getter

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        XCCheckoutDetailTextFiledCell *textFiledCell = (XCCheckoutDetailTextFiledCell *)[tableView dequeueReusableCellWithIdentifier:kTextFiledCellID forIndexPath:indexPath];
        [textFiledCell setTitle:@"缴费通知单"];
        [textFiledCell setTitlePlaceholder:@"输入单号"];
        return textFiledCell;
    }else if (indexPath.row == 2){
        XCCheckoutDetailInputCell *inputCell = (XCCheckoutDetailInputCell *)[tableView dequeueReusableCellWithIdentifier:kTextInputCellID forIndexPath:indexPath];
        [inputCell setTitle:@"是否续保"];
        
        return inputCell;
    }else {
        XCCheckoutDetailTextCell *cell = (XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID forIndexPath:indexPath];
        [cell setTitle:@"投保人:"];
        [cell setTitlePlaceholder:@"刘某某"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 * ViewRateBaseOnIP6;
}


@end
