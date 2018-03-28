//
//  XCUserWaitingToPayingDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserWaitingToPayingDetailViewController.h"

@interface XCUserWaitingToPayingDetailViewController ()
@property (nonatomic, strong) UIButton  * distributionPolicyBtn ;
@property (nonatomic, strong) UIButton * distributionBillBtn ;
@end

@implementation XCUserWaitingToPayingDetailViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"已核保代缴费详情";

    [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
    [self.tableView registerClass:[XCCheckoutDetailTextFiledCell class] forCellReuseIdentifier:kTextFiledCellID];
    [self.tableView registerClass:[XCCheckoutDetailInputCell class] forCellReuseIdentifier:kTextInputCellID];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view setFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_distributionPolicyBtn setFrame:CGRectMake(289 * ViewRateBaseOnIP6,    self.tableView.frame.origin.y + self.tableView.frame.size.height + 40 * ViewRateBaseOnIP6 , 200 * ViewRateBaseOnIP6, 60 * ViewRateBaseOnIP6)];
    [_distributionBillBtn setFrame:CGRectMake(_distributionPolicyBtn.frame.origin.x + _distributionPolicyBtn.frame.size.width + 30 * ViewRateBaseOnIP6, _distributionPolicyBtn.frame.origin.y, 200 * ViewRateBaseOnIP6, 60 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)initUI
{
    self.bottomHeight = 140 * ViewRateBaseOnIP6;
    
    _distributionPolicyBtn = [UIButton buttonWithType:0];
    [_distributionPolicyBtn setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
    [_distributionPolicyBtn.titleLabel setFont:[UIFont systemFontOfSize:28 * ViewRateBaseOnIP6]];
    [_distributionPolicyBtn setTitle:@"配送保单" forState:UIControlStateNormal];
    
    
    _distributionPolicyBtn.layer.cornerRadius = 3;
    _distributionPolicyBtn.layer.borderWidth = 1;
    [_distributionPolicyBtn.layer setBorderColor: COLOR_RGB_255(104, 153, 232).CGColor];
    [_distributionPolicyBtn setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    
    _distributionBillBtn = [UIButton buttonWithType:0];
    [_distributionBillBtn setTitleColor:COLOR_RGB_255(255, 255, 255) forState:UIControlStateNormal];
    [_distributionBillBtn.titleLabel setFont:[UIFont systemFontOfSize:28 * ViewRateBaseOnIP6]];
    _distributionBillBtn.layer.cornerRadius = 3;
    _distributionBillBtn.layer.borderWidth = 1;
    _distributionBillBtn.layer.borderColor = COLOR_RGB_255(104, 153, 232).CGColor;
    [_distributionBillBtn setBackgroundColor:COLOR_RGB_255(0, 77, 162)];
    [_distributionBillBtn setTitle:@"配送缴费单" forState:UIControlStateNormal];
    
    
    [self.view addSubview:_distributionPolicyBtn];
    [self.view addSubview:_distributionBillBtn];
    
    
}
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
