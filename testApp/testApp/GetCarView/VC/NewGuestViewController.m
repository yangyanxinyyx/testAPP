//
//  NewGuestViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "NewGuestViewController.h"
#import "UserInfoInputView.h"

@interface NewGuestViewController ()<BaseNavigationBarDelegate>

@property (nonatomic,assign) BOOL isOrder;

@end

@implementation NewGuestViewController

- (instancetype)initWithIsOrder:(BOOL)isOrder
{
    if (self = [super init]) {
        self.isOrder = isOrder;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = self.isOrder ? @"新增订单" : @"新增维修";
    [self.view addSubview:topBar];

    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);

    [self createUI];

}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI{
    if (_isOrder) {
        NSArray *array = @[@"客户名称",@"车  牌  号",@"车  型  号",@"联系电话",@"项目类别",@"项目费用",@"消费时间"];
        for (int i=0; i<7; i++) {
            if (i<4) {
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation + 10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeTextField param:nil];
                [self.view addSubview:inputView];
            }else if (i == 4){
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeSelect param:self.serviceArray];
                [self.view addSubview:inputView];
            }else if (i == 5){
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeTextField param:nil];
                [self.view addSubview:inputView];
            }else if (i == 6){
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeDate param:nil];
                [self.view addSubview:inputView];
            }
        }
    }else{
        NSArray *array = @[@"客户名称",@"车  牌  号",@"车  型  号",@"联系电话",@"公  里  数",@"项目类别",@"项目费用",@"消费时间"];
        for (int i=0; i<8; i ++) {
            if (i == 5) {
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeSelect param:self.serviceArray];
                [self.view addSubview:inputView];
            }else if (i == 7){
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeDate param:nil];
                [self.view addSubview:inputView];
            }
            else{
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeTextField param:nil];
                [self.view addSubview:inputView];
            }
        }
    }

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 412, SCREEN_WIDTH - 30, 44)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressConmit) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = COLOR_RGB_255(0, 77, 162);
    [self.view addSubview:btn];
}

- (void)pressConmit
{

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
