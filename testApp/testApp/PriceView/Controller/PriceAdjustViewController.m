//
//  PriceAdjustViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//  调整报价

#import "PriceAdjustViewController.h"
#import "PriceAdjustTableViewCell.h"
#import "PriceAdjustSureTableViewCell.h"
@interface PriceAdjustViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,PriceAdjustSureTableViewCellDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceAdjustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"调整报价";
    [self.view addSubview:topBar];
    [self createUI];
    
}
- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - cell delegate
- (void)confirmAdjustmentPrice{
    NSLog(@"确认");
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.row < 9) {
        static NSString *identifer = @"identifier";
        PriceAdjustTableViewCell *cell = [[PriceAdjustTableViewCell alloc] init];
        if (!cell) {
            cell = [[PriceAdjustTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        if (indexPath.section == 0 ) {
            cell.labelName.text = @"交强险";
            cell.labelTag.text = @"投保";
            [cell hiddenFranchiseView:YES];
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.labelName.text = @"机动车损险";
                cell.labelTag.text = @"投保";
                [cell hiddenFranchiseView:NO];
                [cell franchiseIsSelect:YES];
            } else if (indexPath.row == 1) {
                cell.labelName.text = @"第三责任险";
                cell.labelTag.text = @"50万";
                [cell hiddenFranchiseView:NO];
                [cell franchiseIsSelect:YES];
            } else if (indexPath.row == 2) {
                cell.labelName.text = @"司机责任险";
                cell.labelTag.text = @"1万";
                [cell hiddenFranchiseView:NO];
                [cell franchiseIsSelect:YES];
            } else if (indexPath.row == 3) {
                cell.labelName.text = @"乘客责任险";
                cell.labelTag.text = @"1万";
                [cell hiddenFranchiseView:NO];
                [cell franchiseIsSelect:NO];
            } else if (indexPath.row == 4) {
                cell.labelName.text = @"盗抢险";
                cell.labelTag.text = @"投保";
                [cell hiddenFranchiseView:YES];
            } else if (indexPath.row == 5) {
                cell.labelName.text = @"涉水险";
                cell.labelTag.text = @"投保";
                [cell hiddenFranchiseView:YES];
            } else if (indexPath.row == 6) {
                cell.labelName.text = @"玻璃险";
                cell.labelTag.text = @"投保";
                [cell hiddenFranchiseView:YES];
            } else if (indexPath.row == 7) {
                cell.labelName.text = @"刮痕险";
                cell.labelTag.text = @"投保";
                [cell hiddenFranchiseView:YES];
            } else {
                cell.labelName.text = @"自然损失险";
                cell.labelTag.text = @"投保";
                [cell hiddenFranchiseView:YES];
            }
        }
        return cell;
    } else {
        static NSString *identife = @"identifierSure";
        PriceAdjustSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identife];
        if (!cell) {
            cell = [[PriceAdjustSureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identife];
        }
        cell.delegate = self;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 9) {
          return  186 * ViewRateBaseOnIP6;
        }
    }
    return 88 * ViewRateBaseOnIP6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70 * ViewRateBaseOnIP6)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30  * ViewRateBaseOnIP6, 0, 200 * ViewRateBaseOnIP6, 70 * ViewRateBaseOnIP6)];
    label.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
    label.textColor = [ UIColor colorWithHexString:@"#838383"];
    if (section == 0) {
        label.text = @"交强险";
    } else {
        label.text = @"商业险调整";
    }
    
    [view addSubview:label];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70 * ViewRateBaseOnIP6;
}

#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}


@end
