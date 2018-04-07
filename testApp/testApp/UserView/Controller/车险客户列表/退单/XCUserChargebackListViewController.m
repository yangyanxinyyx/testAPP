//
//  XCUserChargebackListViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserChargebackListViewController.h"
#import "XCUserChargebackListDetailViewController.h"
@interface XCUserChargebackListViewController ()<XCCheckoutTableViewCellDelegate>

@end

@implementation XCUserChargebackListViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",  nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

- (void)clickCheckDetailButton
{
    XCUserChargebackListDetailViewController *chargebackVC = [[XCUserChargebackListDetailViewController alloc] initWithTitle:@"退单详情"];
    
    [self.navigationController pushViewController:chargebackVC animated:YES];
    
}

#pragma mark - privary Method

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    cell.carNumber = @"粤AAAAAA";
    cell.userName = @"梁艺钟";
    cell.issureTime = @"a123213-321-321-3";
    
    return cell;
}


#pragma mark - XCCheckoutTableViewCellDelegate

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    [self clickCheckDetailButton];
}

@end
