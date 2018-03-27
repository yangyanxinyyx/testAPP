//
//  XCUserUnderWritingDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserUnderWritingDetailViewController.h"
#import "XCCheckoutDetailTextCell.h"
#import "XCCheckoutDetailTextFiledCell.h"
#import "XCCheckoutDetailInputCell.h"
#define kTextCellID @"textCellID"
#define kTextFiledCellID @"textFiledCellID"
#define kTextInputCellID @"inpuitCellID"
@interface XCUserUnderWritingDetailViewController ()

@end

@implementation XCUserUnderWritingDetailViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCCheckoutDetailInputCell class] forCellReuseIdentifier:kTextInputCellID];
    self.bottomHeight = 140 * ViewRateBaseOnIP6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

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
