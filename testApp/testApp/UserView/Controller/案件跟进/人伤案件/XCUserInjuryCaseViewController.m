//
//  XCUserInjuryCaseViewController.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserInjuryCaseViewController.h"
#import "XCUserInjuryCaseDetailViewController.h"
@interface XCUserInjuryCaseViewController ()

@end

@implementation XCUserInjuryCaseViewController
#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseListCell class] forCellReuseIdentifier:kCaseListCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCUserCaseListCell *cell = (XCUserCaseListCell *)[tableView dequeueReusableCellWithIdentifier:kCaseListCellID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160 * ViewRateBaseOnIP6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCUserInjuryCaseDetailViewController *injuryCaseDetailVC = [[XCUserInjuryCaseDetailViewController alloc] initWithTitle:@"人伤案件跟进"];
    [self.navigationController pushViewController:injuryCaseDetailVC animated:YES];
}

@end
