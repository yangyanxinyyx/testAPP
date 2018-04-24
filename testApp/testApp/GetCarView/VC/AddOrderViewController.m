//
//  AddOrderViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "AddOrderViewController.h"
#import "NewGuestViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "AddOrderListCell.h"
#import "AddOrderModel.h"

@interface AddOrderViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIButton *orderBtn;
@property (nonatomic, strong) UIButton *fixBtn;
@property (nonatomic, strong) UIView *searchContenView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) AddOrderModel *currentModel;
@end

@implementation AddOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
//    topBar.title =  @"新增订单";
    [self.view addSubview:topBar];
    [topBar addSubview:self.searchContenView];
    [self.searchContenView addSubview:self.textField];

    [self createUI];
    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI
{

    _dataSource = [NSMutableArray array];

    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44 - 30 -44) style:UITableViewStylePlain];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab.backgroundColor = COLOR_RGB_255(242, 242, 242);
    _tab.hidden = YES;
    [self.view addSubview:_tab];

    [self.view addSubview:self.orderBtn];
    [self.view addSubview:self.fixBtn];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"listCell";
    AddOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddOrderListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (_dataSource.count > 0) {
        AddOrderModel *model = _dataSource[indexPath.row];
        cell.title = [NSString stringWithFormat:@"%ld.%@",indexPath.row+1,model.plateNo];
        cell.own = model.customerName;
        cell.car = model.brand;
        if ([model isEqual:self.currentModel]) {
            cell.isSelect = YES;
        }else{
            cell.isSelect = NO;
        }

    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddOrderModel *model = _dataSource[indexPath.row];
    self.currentModel = model;
    [self.tab reloadData];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (void)pressOrderBtn
{
    NewGuestViewController *VC = [[NewGuestViewController alloc] initWithIsOrder:YES];
    VC.serviceArray = self.serviceArray;
    VC.currentModel = self.currentModel;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)pressFixBtn
{
    NewGuestViewController *VC = [[NewGuestViewController alloc] initWithIsOrder:NO];
    VC.currentModel = self.currentModel;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)requestDataWithselectNumber:(NSString *)plateNO
{
    NSDictionary *param = @{@"plateNo":plateNO};
    [RequestAPI getGetCarSelectPlateNO:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取用户信息成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *data = response[@"data"];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

                    for (NSDictionary *dic in data) {
                        AddOrderModel *model = [[AddOrderModel alloc] init];
                         [model setValuesForKeysWithDictionary:dic];

                        [_dataSource addObject:model];

                    }

                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (_dataSource.count > 0) {
                            _tab.hidden = NO;
                        }else{
                            _tab.hidden = YES;
                            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"没有用户数据" complete:nil];
                            [self.view addSubview:tipsView];
                        }
                        [_tab reloadData];
                    });
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    _tab.hidden = YES;
                    [_tab reloadData];
                    NSLog(@"获取用户信息失败");
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取用户信息错误" complete:nil];
                    [self.view addSubview:tipsView];
                });
            }
        }

    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _tab.hidden = YES;
            [_tab reloadData];
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
            [self.view addSubview:tipsView];
        });
        
    }];
}

#pragma mark textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.text = [textField.text uppercaseString];
    [_dataSource removeAllObjects];
    [self requestDataWithselectNumber:textField.text];
    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}

- (UIView *)searchContenView {
    if (!_searchContenView) {
        _searchContenView = [[UIView alloc] initWithFrame:CGRectMake(105 * ViewRateBaseOnIP6, 16 * ViewRateBaseOnIP6, 540 * ViewRateBaseOnIP6, 28)];
        _searchContenView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _searchContenView.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        _searchContenView.layer.masksToBounds = YES;
    }
    return _searchContenView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 500 * ViewRateBaseOnIP6, 19)];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _textField.placeholder = @"车牌号查询";
        [_textField setValue:[UIColor colorWithHexString:@"#838383"] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        _textField.delegate = self;

        //        _textField.text = @"粤A984W9";

        UIImageView *rightView = [[UIImageView alloc]init];
        rightView.image = [UIImage imageNamed:@"search"];
        rightView.bounds = CGRectMake(-60 * ViewRateBaseOnIP6, 0, 19  , 19 );
        rightView.contentMode = UIViewContentModeCenter;
        _textField.rightView = rightView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIButton *)orderBtn
{
    if (!_orderBtn) {
        _orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 +15, SCREEN_HEIGHT - 15 - 44 - kBottomMargan-44, SCREEN_WIDTH/2 - 30, 44)];
        [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_orderBtn addTarget:self action:@selector(pressOrderBtn) forControlEvents:UIControlEventTouchUpInside];
        _orderBtn.layer.cornerRadius = 5;
        _orderBtn.layer.masksToBounds = YES;
        [_orderBtn setTitle:@"新增订单" forState:UIControlStateNormal];
        _orderBtn.backgroundColor = COLOR_RGB_255(0, 72, 162);
    }
    return _orderBtn;
}

- (UIButton *)fixBtn
{
    if (!_fixBtn) {
        _fixBtn = [[UIButton alloc] initWithFrame:CGRectMake( 15, SCREEN_HEIGHT - 15 - 44 - kBottomMargan-44, SCREEN_WIDTH/2 - 30, 44)];
        [_fixBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fixBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_fixBtn addTarget:self action:@selector(pressFixBtn) forControlEvents:UIControlEventTouchUpInside];
        _fixBtn.layer.cornerRadius = 5;
        _fixBtn.layer.masksToBounds = YES;
        [_fixBtn setTitle:@"新增维修" forState:UIControlStateNormal];
        _fixBtn.backgroundColor = COLOR_RGB_255(0, 72, 162);
    }
    return _fixBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
