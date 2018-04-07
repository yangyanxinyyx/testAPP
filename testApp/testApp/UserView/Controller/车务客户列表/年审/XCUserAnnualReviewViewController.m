//
//  XCUserAnnualReviewViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserAnnualReviewViewController.h"
#import "XCUserAnnualReviewDetailViewController.h"
@interface XCUserAnnualReviewViewController ()<XCCheckoutTableViewCellDelegate>

@end

@implementation XCUserAnnualReviewViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Action Method

- (void)clickCheckDetailButton
{
    XCUserAnnualReviewDetailViewController *annualDetailVC = [[XCUserAnnualReviewDetailViewController alloc] initWithTitle:@"年审详情"];
    [self.navigationController pushViewController:annualDetailVC animated:YES];
    
}


#pragma mark - privary Method


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
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
