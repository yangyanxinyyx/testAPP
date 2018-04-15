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
static NSString *identifier = @"listCell";

@interface GetCarListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,GetCarListCellDelegate>

@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) UIView *forbidTipsView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *searchContenView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *orderBtn;
@property (nonatomic, strong) UIButton *fixBtn;
@end

@implementation GetCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [NSMutableArray array];
    [self createUI];
    [self requestDataWithPage:@(1) selectNumber:@"粤A984W9"];
}

- (void)createUI
{
    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.searchContenView];
    [self.searchContenView addSubview:self.textField];

    if (![UserInfoManager shareInstance].isStore) {
        [self.view addSubview:self.forbidTipsView];
        return;
    }

    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44 - 30 -44) style:UITableViewStylePlain];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [self.view addSubview:_tab];

    [self.view addSubview:self.orderBtn];
    [self.view addSubview:self.fixBtn];

}

- (void)requestDataWithPage:(NSNumber *)page selectNumber:(NSString *)selectNumber
{
    NSDictionary *param = nil;
    if (selectNumber) {
        param = @{@"storeId":[UserInfoManager shareInstance].storeID,
                  @"plateNo":selectNumber,
                  @"PageIndex":page,
                  @"PageSize":@(10)
                  };
    }else{
        param = @{@"storeId":[UserInfoManager shareInstance].storeID,
                  @"PageIndex":page,
                  @"PageSize":@(10)
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
                        [_dataSource addObject:model];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tab reloadData];
                        [self showFixBtn:_dataSource.count > 0 ? NO : YES];
                    });
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

- (void)showFixBtn:(BOOL)show
{
    if (show) {
        self.fixBtn.hidden = NO;
        self.orderBtn.frame = CGRectMake(SCREEN_WIDTH/2 +15, SCREEN_HEIGHT - 15 - 44 - kBottomMargan-44, SCREEN_WIDTH/2 - 30, 44);

    }else{
        self.fixBtn.hidden = YES;
        self.orderBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 15 - 44 - kBottomMargan-44, SCREEN_WIDTH - 30, 44);
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
    }
    GetCarModel *model =_dataSource[indexPath.row];

    cell.carNumberLabel.text = model.plateNo;
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

- (void)pressGetCarBtn:(UIButton *)sender
{
    GetCarListCell *cell = (GetCarListCell *)sender.superview;
    if (cell.getCarBtnType == GetCarBtnTypeGet) {
        GetCarViewController *VC = [[GetCarViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)pressOrderBtn{


}

- (void)pressFixBtn{

    
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
        label.textColor = COLOR_RGB_255(165, 165, 165);
        [_forbidTipsView addSubview:label];


    }
    return _forbidTipsView;
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
        _orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 15 - 44 - kBottomMargan-44, SCREEN_WIDTH - 30, 44)];
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
