//
//  GetCarListViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarListViewController.h"
#import "GetCarListCell.h"
#import "GetCarModel.h"
#import "GetCarViewController.h"
#import "MoneyInputVIew.h"
#import <MJRefresh/MJRefresh.h>
#import "LYZAlertView.h"
#import "NewGuestViewController.h"
#import "AddOrderViewController.h"
static NSString *identifier = @"listCell";

@interface GetCarListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,GetCarListCellDelegate,GetCarViewControllerDelegate,MoneyInputVIewDelegate>

@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) UIView *forbidTipsView;
@property (nonatomic,strong) UIView *noFoundTipsView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *searchContenView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *orderBtn;
//@property (nonatomic, strong) UIButton *fixBtn;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *serviceArray;
@end

@implementation GetCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.serviceArray = [NSMutableArray array];

    [self createUI];

    NSDictionary *param = @{@"storeId":[UserInfoManager shareInstance].storeID};
    [RequestAPI getGetCarService:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取服务列表成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *data = response[@"data"];
                    for (NSDictionary *dic in data) {
                        NSDictionary *temp = @{@"name":dic[@"name"],
                                               @"id":dic[@"id"]
                                               };
                        [self.serviceArray addObject: temp];
                    }
                }
                [self requestDataWithPage:@(1) selectNumber:nil];
            }else{
                NSLog(@"获取服务列表失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取服务列表错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];

    _page = 2;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];


}


-(void)viewTapped:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![UserInfoManager shareInstance].isStore) {
        [self.view addSubview:self.forbidTipsView];
    }
}

- (void)createUI
{
    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.searchContenView];
    [self.searchContenView addSubview:self.textField];
    [self.view addSubview:self.noFoundTipsView];


    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44 - 30 -44) style:UITableViewStylePlain];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tab];
    _tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    _tab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];



    [self.view addSubview:self.orderBtn];
//    [self.view addSubview:self.fixBtn];

}

- (void)requestDataWithPage:(NSNumber *)page selectNumber:(NSString *)selectNumber
{
    NSDictionary *param = nil;
    __block NSNumber *pageSize = @(10);
    if (selectNumber) {
        param = @{@"storeId":[UserInfoManager shareInstance].storeID,
                  @"plateNo":selectNumber,
                  @"PageIndex":page,
                  @"PageSize":pageSize
                  };
    }else{
        param = @{@"storeId":[UserInfoManager shareInstance].storeID,
                  @"PageIndex":page,
                  @"PageSize":pageSize
                  };
    }


    [RequestAPI getGetCarList:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取接车列表成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                    NSArray *dataSet = data[@"dataSet"];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    for (NSDictionary *dicData in dataSet) {
                        GetCarModel *model = [[GetCarModel alloc] init];
                        [model setValuesForKeysWithDictionary:dicData];
                        [self.dataSource addObject:model];
                    }

                    dispatch_async(dispatch_get_main_queue(), ^{

                        [self.tab reloadData];
                        [self showFixBtn:self.dataSource.count > 0 ? NO : YES];
                    });
                    if (dataSet.count < [pageSize integerValue]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tab.mj_footer endRefreshingWithNoMoreData];
                        });
                    }
                }
            }else{
                NSLog(@"获取接车列表失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取接车列表错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];
}

-(void)refresh
{
    [self.dataSource removeAllObjects];
    [self.tab.mj_footer resetNoMoreData];
    _page = 2;
    [self requestDataWithPage:@(1) selectNumber:_textField.text];
    [self.tab.mj_header endRefreshing];
}
-(void)loadMore
{
    [self requestDataWithPage:@(self.page) selectNumber:_textField.text];
    self.page ++;
    [self.tab.mj_footer endRefreshing];

}

- (void)showFixBtn:(BOOL)show
{
    if (show) {

        self.noFoundTipsView.hidden = NO;

    }else{

        self.noFoundTipsView.hidden = YES;

    }

}

#pragma mark - tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 131;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GetCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[GetCarListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.delegate = self;
    }
    if (self.dataSource.count == 0) {
        return cell;
    }
    GetCarModel *model = self.dataSource[indexPath.row];

    cell.carNumberLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row + 1,model.plateNo] ;
    cell.ownerLabel.text = model.customerName;
    cell.itemsLabel.text = model.orderCategory;
    cell.timeLabel.text = model.appointmentTime;
    if ([model.useStatus isEqualToString:@"待消费"]) {
        cell.getCarBtnType = 0;
    }else if ([model.useStatus isEqualToString:@"消费中"]){
        cell.getCarBtnType = 1;
    }else{
        cell.getCarBtnType = 2;
    }

    return cell;
}

- (void)pressGetCarBtn:(GetCarListCell *)cell
{
    NSIndexPath *indexPath = [_tab indexPathForCell:cell];
    GetCarModel *model = self.dataSource[indexPath.row];
    if (cell.getCarBtnType == GetCarBtnTypeGet) {
        GetCarViewController *VC = [[GetCarViewController alloc] init];
        VC.delegate = self;
        VC.orderID = model.orderID;
        VC.isFix = [model.orderCategory isEqualToString:@"维修"] ? YES : NO;
        VC.orderCategory = model.orderCategory;
        VC.appointmentTime = model.appointmentTime;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (cell.getCarBtnType == GetCarBtnTypePay){
        if ([model.orderCategory isEqualToString:@"维修"]) {
            MoneyInputVIew *moneyInput = [[MoneyInputVIew alloc] init];
            moneyInput.orderId = model.orderID;
            moneyInput.delegate = self;
            [self.view addSubview:moneyInput];
        }else{
            LYZAlertView *alert = [LYZAlertView alterViewWithTitle:@"是否完成?" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
                NSDictionary *param = @{@"id":model.orderID};
                [RequestAPI getGetCarFinish:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                    if (isUsableDictionary(response)) {
                        if ([response[@"result"] integerValue] == 1) {
                            NSLog(@"交易成功");
                            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

                            dispatch_async(dispatch_get_main_queue(), ^{
                                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"交易完成!" complete:^{
                                    [self reloadGetCarListWithPlateNO];
                                }];

                                [self.view addSubview:tipsView];
                                [self.view sendSubviewToBack:tipsView];

                            });

                        }else{
                            NSLog(@"交易失败");
                            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"交易错误" complete:nil];
                            [self.view addSubview:tipsView];
                        }
                    }

                } fail:^(id error) {
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
                    [self.view addSubview:tipsView];
                }];
            }];
            [self.view addSubview:alert];
        }
    }
}

- (void)reloadGetCarListWithPlateNO
{
    _page = 2;
    [self.tab.mj_footer resetNoMoreData];
    [self.dataSource removeAllObjects];
    [self requestDataWithPage:@(1) selectNumber:nil];
}

- (void)pressOrderBtn{
    AddOrderViewController *VC = [[AddOrderViewController alloc] init];
    VC.serviceArray = self.serviceArray;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.text = [textField.text uppercaseString];
    _page = 2;
    [self.dataSource removeAllObjects];
    [self requestDataWithPage:@(1) selectNumber:textField.text];
    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}

- (void)pressSearchBtn{

    [self.view endEditing:YES];
    _textField.text = [_textField.text uppercaseString];
    _page = 2;
    [self.dataSource removeAllObjects];
    [self requestDataWithPage:@(1) selectNumber:_textField.text];
}

#pragma mark - getter&setter

- (UIView *)forbidTipsView
{
    if (!_forbidTipsView) {
        _forbidTipsView = [[UIView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44)];
        _forbidTipsView.backgroundColor = COLOR_RGB_255(242, 242, 242);


        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:@"禁止.png"];
        imageView.center = CGPointMake(SCREEN_WIDTH/2, _forbidTipsView.bounds.size.height/2);
        [_forbidTipsView addSubview:imageView];


        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 72)/2, CGRectGetMaxY(imageView.frame) +12, 72, 11)];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"业务员不可用!";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = COLOR_RGB_255(165, 165, 165);
        [_forbidTipsView addSubview:label];


    }
    return _forbidTipsView;
}

- (UIView *)noFoundTipsView
{
    if (!_noFoundTipsView) {
        _noFoundTipsView = [[UIView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44)];
        _noFoundTipsView.backgroundColor = COLOR_RGB_255(242, 242, 242);
        _noFoundTipsView.hidden = YES;

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:@"暂无订单.png"];
        imageView.center = CGPointMake(SCREEN_WIDTH/2, _noFoundTipsView.bounds.size.height/2);
        [_noFoundTipsView addSubview:imageView];


        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 72)/2, CGRectGetMaxY(imageView.frame) +12, 72, 11)];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"无订单信息!";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = COLOR_RGB_255(165, 165, 165);
        [_noFoundTipsView addSubview:label];


    }
    return _noFoundTipsView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 44)];
        _topView.backgroundColor = [UIColor whiteColor];
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1 )];
        segmentView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [_topView addSubview:segmentView];
    }
    return _topView;
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

        UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(500 * ViewRateBaseOnIP6 - 25, -10, 30, 30)];
        searchBtn.backgroundColor = [UIColor clearColor];
        [_textField addSubview:searchBtn];
        [searchBtn addTarget:self action:@selector(pressSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _textField;
}

- (UIButton *)orderBtn
{
    if (!_orderBtn) {
        _orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 15 - 44 - kBottomMargan-44, SCREEN_WIDTH - 30, 44)];
        [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_orderBtn addTarget:self action:@selector(pressOrderBtn) forControlEvents:UIControlEventTouchUpInside];
        _orderBtn.layer.cornerRadius = 5;
        _orderBtn.layer.masksToBounds = YES;
        [_orderBtn setTitle:@"新增订单" forState:UIControlStateNormal];
        _orderBtn.backgroundColor = COLOR_RGB_255(0, 72, 162);
//        _orderBtn.hidden = YES;
    }
    return _orderBtn;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
