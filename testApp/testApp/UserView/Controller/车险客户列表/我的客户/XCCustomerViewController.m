//
//  XCCustomerViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerViewController.h"
#import "XCCustomerDetailViewController.h"
@interface XCCustomerViewController ()<XCCheckoutTableViewCellDelegate> {
    CGFloat _addBtnHeigth;
}
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * addCustomerBtn ;
@end

@implementation XCCustomerViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _addBtnHeigth = 88 * ViewRateBaseOnIP6;
    [self createUI];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + _addBtnHeigth + kBottomMargan))];
    [self.addCustomerBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, _addBtnHeigth)];
    
}

#pragma mark - Action Method

- (void)clickCheckDetailButton
{
    XCCustomerDetailViewController *detailVC = [[XCCustomerDetailViewController alloc] initWithTitle:@"客户详情"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)clickUnderWritingDetailButton
{
    
}

- (void)clickAddCustomerButton:(UIButton *)button
{
    
}


#pragma mark - privary Method

- (void)createUI
{
    _addCustomerBtn = [UIButton buttonWithType:0];
    [_addCustomerBtn setTitle:@"新增客户" forState:UIControlStateNormal];
    [_addCustomerBtn setBackgroundColor:COLOR_RGB_255(104, 153, 232)];
    [_addCustomerBtn addTarget:self action:@selector(clickAddCustomerButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addCustomerBtn];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.carNumber = @"粤AAAAAA";
    cell.userName = @"梁艺钟";
    cell.issureTime = @"a123213-321-321-3";
    cell.isCustomerCell = YES;
    return cell;
}



#pragma mark - XCCheckoutTableViewCellDelegate

//点击查看按钮
- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    [self clickCheckDetailButton];
}

//点击核保按钮
-(void)XCCheckoutCellClickUnderWritingButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    [self clickUnderWritingDetailButton];
}

@end
