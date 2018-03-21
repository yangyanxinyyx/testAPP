//
//  XCUserUnderWritingViewController.m
//  testApp
//
//  Created by Melody on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserUnderWritingViewController.h"

@interface XCUserUnderWritingViewController ()

@end

@implementation XCUserUnderWritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已核保代缴费";
    [self.tableView registerClass:[XCCheckoutTableViewCell class] forCellReuseIdentifier:kcheckCellID];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCCheckoutTableViewCell *cell = (XCCheckoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kcheckCellID forIndexPath:indexPath];
    cell.carNumber = @"粤AAAAAA";
    cell.userName = @"梁艺钟";
    cell.issureTime = @"a123213-321-321-3";
    
    return cell;
}


@end
