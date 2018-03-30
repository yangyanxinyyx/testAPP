//
//  XCUserUnderWritingViewController.m
//  testApp
//
//  Created by Melody on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserUnderWritingViewController.h"
#import "XCUserUnderWritingDetailViewController.h"
@interface XCUserUnderWritingViewController ()<XCCheckoutTableViewCellDelegate>
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * dataArr ;
@end

@implementation XCUserUnderWritingViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待核保";
    self.dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

- (void)clickCheckDetailButton
{
    XCUserUnderWritingDetailViewController *detailVC = [[XCUserUnderWritingDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - privary Method

- (void)showAlertViewWithIndepthPathCell:(NSIndexPath*)indexpath
{
    __weak typeof (self)weakSelf = self;
    LYZAlertView *alertView = [LYZAlertView alterViewWithTitle:@"是否删除" content:nil comfirmStr:@"是" cancelStr:@"否" comfirmClick:^(LYZAlertView *alertView) {
        [self.dataArr removeObjectAtIndex:indexpath.row];
        
        //(TODO)删除数据
        [weakSelf removeAlertView:alertView cellIndexpath:indexpath];
        [self.tableView reloadData];
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
    return self.dataArr.count;
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
            [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单

        }];
        action.backgroundColor = COLOR_RGB_255(0, 77, 162);
        UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[action]];
//        actions.performsFirstActionWithFullSwipe = NO;
        return actions;
    }
    return nil;
}

#pragma mark - XCCheckoutTableViewCellDelegate

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button cell:(XCCheckoutTableViewCell *)cell
{
    [self clickCheckDetailButton];
}

@end
