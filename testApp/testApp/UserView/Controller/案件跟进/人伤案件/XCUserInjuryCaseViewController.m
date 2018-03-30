//
//  XCUserInjuryCaseViewController.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserInjuryCaseViewController.h"
#import "XCUserCaseListCell.h"
@interface XCUserInjuryCaseViewController ()

@end

@implementation XCUserInjuryCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XCUserCaseListCell *cell = (XCUserCaseListCell *)[tableView dequeueReusableCellWithIdentifier:kcaseListCelID forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160 * ViewRateBaseOnIP6;
}


@end
