//
//  PriceCustomerInformEntryViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCustomerInformEntryViewController.h"
#import "PriceCustomerInformEntryTableViewCell.h"
#import "PriceCustomerInformEntrySubmitTableViewCell.h"
@interface PriceCustomerInformEntryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceCustomerInformEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"客户信息录入";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self createUI];
}

#pragma mark - tabnleview detegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    } else {
     return 7;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 98 * ViewRateBaseOnIP6;
    } else {
      return 80 * ViewRateBaseOnIP6;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 60 * ViewRateBaseOnIP6;
    } else {
        return 20 * ViewRateBaseOnIP6;
    }
}
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view;
    if (section == 2) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60 * ViewRateBaseOnIP6)];
    } else {
        view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20 * ViewRateBaseOnIP6)];
    }
    view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 2) {
        static NSString * identifier = @"cell";
        PriceCustomerInformEntryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCustomerInformEntryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.labelName.text = @"*车牌号 :";
            } else if (indexPath.row == 1) {
                cell.labelName.text = @"初登日期:";
            } else if (indexPath.row == 2){
                cell.labelName.text = @"车 架 号:";
            } else if (indexPath.row == 3){
                cell.labelName.text = @"发动机号:";
            } else if (indexPath.row == 4){
                cell.labelName.text = @"车型代码:";
            } else if (indexPath.row == 5){
                cell.labelName.text = @"品       牌:";;
            }  else{
                cell.labelName.text = @"联系方式:";
            }
            return cell;
        } else {
            if (indexPath.row == 0) {
                cell.labelName.text = @"客户名称:";
            } else if (indexPath.row == 1) {
                cell.labelName.text = @"客户来源:";
            } else if (indexPath.row == 2){
                cell.labelName.text = @"身份证号:";
            } else if (indexPath.row == 3){
                cell.labelName.text = @"性      别:";
            } else if (indexPath.row == 4){
                cell.labelName.text = @"生      日:";
            } else if (indexPath.row == 5){
                cell.labelName.text = @"区      域:";;
            }  else{
                cell.labelName.text = @"地      址:";
            }
            return cell;
        }
    } else {
        static NSString *identifier = @"submitIdentifier";
        PriceCustomerInformEntrySubmitTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCustomerInformEntrySubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    
    
    
}

#pragma marik - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}


@end
