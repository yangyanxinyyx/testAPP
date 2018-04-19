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

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *plateNO;
@property (nonatomic,strong) NSString *car;
@property (nonatomic,strong) NSString *phoneNO;

@property (nonatomic,strong) NSString *serviceType;
@property (nonatomic,strong) NSNumber *serviceMoney;
@property (nonatomic,strong) NSString *serviceDate;

@property (nonatomic,strong) NSNumber *InsuranceMoney;
@property (nonatomic,strong) NSNumber *selfMoney;


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
            __block int j =i;
            if (i<4) {
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation + 10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeTextField param:nil WithCompletionHandler:^(NSString *content) {
                    if (j == 0) {
                        self.name = content;
                    }else if (j == 1) {
                        self.plateNO = content;
                    }else if (j == 2) {
                        self.car = content;
                    }else if (j == 3) {
                        self.phoneNO = content;
                    }
                }];

                [self.view addSubview:inputView];
            }else if (i == 4){

                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeSelect param:self.serviceArray WithCompletionHandler:^(NSString *content) {
                    self.serviceType = content;
                }];
                [self.view addSubview:inputView];
            }else if (i == 5){
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeTextField param:nil WithCompletionHandler:^(NSString *content) {
                    self.serviceMoney = [NSNumber numberWithInt:[content intValue]] ;
                }];
                [self.view addSubview:inputView];
            }else if (i == 6){
                UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeDate param:nil WithCompletionHandler:^(NSString *content) {
                    self.serviceType = content;
                }];
                [self.view addSubview:inputView];
            }
        }
    }else{
        NSArray *array = @[@"客户名称",@"车  牌  号",@"车  型  号",@"联系电话",@"保单金额",@"自费金额",];
        for (int i=0; i<6; i ++) {
            __block int j =i;
            UserInfoInputView *inputView = [[UserInfoInputView alloc] initWithFrame:CGRectMake(0,kHeightForNavigation +  10 + i*44, SCREEN_WIDTH, 44) title:array[i] type:InputViewTypeTextField param:nil WithCompletionHandler:^(NSString *content) {
                if (j == 0) {
                    self.name = content;
                }else if (j == 1) {
                    self.plateNO = content;
                }else if (j == 2) {
                    self.car = content;
                }else if (j == 3) {
                    self.phoneNO = content;
                }else if (j == 4) {
                    self.InsuranceMoney = [NSNumber numberWithInt:[content intValue]];
                }else if (j == 5) {
                    self.selfMoney = [NSNumber numberWithInt:[content intValue]];
                }
            }];
            [self.view addSubview:inputView];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];



    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (!self.isOrder && (textField.tag ==5 || textField.tag == 4)) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMKEYBOARD] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }else if (self.isOrder && (textField.tag ==5 || textField.tag == 3)){
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMKEYBOARD] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return YES;


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
