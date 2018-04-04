//
//  XCCustomerViewController.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerViewController.h"
#import "XCCustomerDetailViewController.h"
@interface XCCustomerViewController ()<XCCheckoutTableViewCellDelegate>

@end

@implementation XCCustomerViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户列表";
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat buttonH = 98;
    [self.tableView setFrame:CGRectMake(0, 64 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 - (buttonH + 20) * ViewRateBaseOnIP6)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

- (void)clickCheckDetailButton
{
    XCCustomerDetailViewController *detailVC = [[XCCustomerDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark - privary Method

- (void)showAlertViewWithIndepthPathCell:(NSIndexPath*)indexpath
{
    __weak typeof (self)weakSelf = self;
    LYZAlertView *alertView = [LYZAlertView alterViewWithTitle:@"是否删除" content:nil comfirmStr:@"是" cancelStr:@"否" comfirmClick:^(LYZAlertView *alertView) {
        //(TODO)删除数据
        [weakSelf removeAlertView:alertView cellIndexpath:indexpath];
    } cancelClick:^(LYZAlertView *alertView) {
        [weakSelf removeAlertView:alertView cellIndexpath:indexpath];
    }];
    
    [self.view addSubview:alertView];
}

- (void)removeAlertView:(LYZAlertView *)alertView cellIndexpath:(NSIndexPath *)indexpath
{
    UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:indexpath];
    
    if ([alertView superview]) {
        [alertView removeFromSuperview];
    }
}


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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"=======>Cell Delected Action");
        [self showAlertViewWithIndepthPathCell:indexPath];
    }
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        __weak typeof (self)weakSelf = self;
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            NSLog(@"=======>Cell Delected Action");
            [weakSelf showAlertViewWithIndepthPathCell:indexPath];
        }];
        action.backgroundColor = COLOR_RGB_255(0, 77, 162);
        
        return [UISwipeActionsConfiguration configurationWithActions:@[action]];
    }
    return nil;
}

#pragma mark - XCCheckoutTableViewCellDelegate

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    [self clickCheckDetailButton];
}

@end
