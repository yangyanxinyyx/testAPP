//
//  LoginViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPasswordViewController.h"
#import "UserInfoConfirmView.h"
#import "RequestAPI.h"
#import "CoverLoopimageModel.h"
#import "CoverAnnouncementModel.h"

@interface LoginViewController ()<UITextFieldDelegate,UserInfoComfirmVIewDelegate>

@property (nonatomic,strong) UITextField *accoutTextField;
@property (nonatomic,strong) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}

- (void)createUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 190 * kScaleHeight)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@""];

    self.accoutTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH-20, 44)];
    [self.view addSubview:_accoutTextField];
    _accoutTextField.placeholder = @"请输入手机号";
    _accoutTextField.clearButtonMode = UITextFieldViewModeAlways;
    _accoutTextField.clearsOnBeginEditing = YES;
    _accoutTextField.textAlignment = NSTextAlignmentLeft;
    _accoutTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _accoutTextField.returnKeyType = UIReturnKeyDone;
    _accoutTextField.delegate = self;
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_username.png"]];
    _accoutTextField.leftView=imageView1;
    _accoutTextField.leftViewMode = UITextFieldViewModeAlways;
    _accoutTextField.font = [UIFont systemFontOfSize:14];


    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_accoutTextField.frame), SCREEN_WIDTH-20, 44)];
    [self.view addSubview:_passwordTextField];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.clearsOnBeginEditing = YES;
    _passwordTextField.textAlignment = NSTextAlignmentLeft;
    _passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.delegate = self;
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password.png"]];
    _passwordTextField.leftView = imageView2;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.font = [UIFont systemFontOfSize:14];

    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 345) / 2, CGRectGetMaxY(_passwordTextField.frame) + 50, 345, 44)];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTintColor:[UIColor whiteColor]];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = COLOR_RGB_255(0, 77, 162);
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(pressLoginBtn:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 -54,CGRectGetMaxY(loginBtn.frame) + 10 , 54, 12)];
    [self.view addSubview:forgetBtn];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:COLOR_RGB_255(57, 174, 54) forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    forgetBtn.layer.cornerRadius = 5;
    forgetBtn.layer.masksToBounds = YES;
    [forgetBtn addTarget:self action:@selector(pressForgetBtn:) forControlEvents:UIControlEventTouchUpInside];

    for (int i=0; i<2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_accoutTextField.frame) + 44 * i, SCREEN_WIDTH - 30, 1)];
        line.backgroundColor = COLOR_RGBA_255(229, 229, 229, 1);
        [self.view addSubview:line];
    }
}

- (void)pressLoginBtn:(UIButton *)sender
{
    NSDictionary  *param = @{
                             @"userCode":@"13570229475",
                             @"password":@"xc123456"
                             };
    [RequestAPI getUserInfo:param header:nil success:^(id response) {
        NSLog(@"%@",response);
        if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"登录成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                    [UserInfoManager shareInstance].code = data[@"code"] ? data[@"code"] : @"";
                    [UserInfoManager shareInstance].employeeId = data[@"employeeId"] ? data[@"employeeId"] : 0;
                    [UserInfoManager shareInstance].employeeName = data[@"employeeName"] ? data[@"employeeName"] : @"";
                    [UserInfoManager shareInstance].iconUrl = data[@"iconUrl"] ? data[@"iconUrl"] : @"";
                    [UserInfoManager shareInstance].userID = data[@"id"] ? data[@"id"] : @"";
                    [UserInfoManager shareInstance].isStoreAdministrator = data[@"isStoreAdministrator"] ? data[@"isStoreAdministrator"] : @"";
                    [UserInfoManager shareInstance].name = data[@"name"] ? data[@"name"] : @"";
                    [UserInfoManager shareInstance].needModifyPwsNextLogin = data[@"needModifyPwsNextLogin"] ? data[@"needModifyPwsNextLogin"] : @"";
                    [UserInfoManager shareInstance].noModifyPsw = data[@"noModifyPsw"] ? data[@"noModifyPsw"] : @"";
                    [UserInfoManager shareInstance].phone = data[@"phone"] ? data[@"phone"] : @"";
                    NSDictionary *store = [NSDictionary dictionary];
                    if ( data[@"store"] && [data[@"store"] isKindOfClass:[NSDictionary class]]) {
                        store = data[@"store"];
                        [UserInfoManager shareInstance].isStore = store.count > 0 ? YES : NO;
                    }
                    [UserInfoManager shareInstance].storeID = store[@"id"] ? store[@"id"] : @"";
                    [UserInfoManager shareInstance].storeName = store[@"storeName"] ? store[@"name"] : @"";
                    [UserInfoManager shareInstance].storeCode = store[@"storeCode"] ? store[@"code"] : @"";
                    [UserInfoManager shareInstance].tel = store[@"tel"] ? store[@"tel"] : @"";
                    [UserInfoManager shareInstance].corporateName = store[@"corporateName"] ? store[@"corporateName"] : @"";
                    [UserInfoManager shareInstance].corporateCellphone = store[@"corporateCellphone"] ? store[@"corporateCellphone"] : @"";
                    [UserInfoManager shareInstance].address = store[@"address"] ? store[@"address"] : @"";
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

//                    UserInfoConfirmView *confirmView = [[UserInfoConfirmView alloc] initwithName:[UserInfoManager shareInstance].name department:[UserInfoManager shareInstance].employeeName worknumber:[NSString stringWithFormat:@"%@",[UserInfoManager shareInstance].employeeId]];
//                    confirmView.delegate = self;
//                    [self.view addSubview:confirmView];


                }

                //获取车险信息
                NSDictionary  *param = @{
                                         @"salesman_id":[UserInfoManager shareInstance].userID
                                         };
                [RequestAPI getPersonalPolicy:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                    NSLog(@"%@",response);
                    if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
                        if ([response[@"result"] integerValue] == 1) {
                            NSLog(@"获取车险信息成功");
                            if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                                NSDictionary *data = response[@"data"];
                                [UserInfoManager shareInstance].performanceMedal.lastYearCar = data[@"last_year_car"] ? [NSString stringWithFormat:@"%@",data[@"last_year_car"]]:@"";
                                [UserInfoManager shareInstance].performanceMedal.lastMonthCar = data[@"last_month_car"] ? [NSString stringWithFormat:@"%@",data[@"last_month_car"]]:@"";
                                [UserInfoManager shareInstance].performanceMedal.nowMonthCar = data[@"now_month_car"] ? [NSString stringWithFormat:@"%@",data[@"now_month_car"]]:@"";
                                [UserInfoManager shareInstance].performanceMedal.lastYearCarRanking = data[@"last_year_car_ranking"] ? [NSString stringWithFormat:@"%@",data[@"last_year_car_ranking"]]:@"";
                                [UserInfoManager shareInstance].performanceMedal.lastMonthCarRanking = data[@"last_month_car_ranking"] ? [NSString stringWithFormat:@"%@",data[@"last_month_car_ranking"]]:@"";
                                [UserInfoManager shareInstance].performanceMedal.nowMonthCarRanking = data[@"now_month_car_ranking"] ? [NSString stringWithFormat:@"%@",data[@"now_month_car_ranking"]]:@"";
                                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                                UserInfoManager *manager = [UserInfoManager shareInstance];
                                [self loadCoverModel];

                            }
                        }else if (([response[@"result"] integerValue] == 0)){
                            NSLog(@"获取车险信息失败");
                            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取车险信息错误" complete:nil];
                            [self.view addSubview:tipsView];
                        }
                    }
                } fail:^(id error) {
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
                    [self.view addSubview:tipsView];
                }];


            }else if (([response[@"result"] integerValue] == 0)){
                NSLog(@"登录失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"账号或密码错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }

    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];



}

- (void)loadCoverModel
{
    //获取公告信息
    NSDictionary  *param = @{
                             @"PageSize":@(10),
                             @"PageIndex":@(1)
                             };
    [RequestAPI getCoverAnnouncement:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        NSLog(@"%@",response);
        if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"获取公告成功");
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *data = response[@"data"];
                    NSArray *dataSet = data[@"dataSet"];
                    [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                    for (NSDictionary *dicData in dataSet) {
                        CoverAnnouncementModel *announcement = [[CoverAnnouncementModel alloc] init];
                        [announcement setValuesForKeysWithDictionary:dicData];
                        [[UserInfoManager shareInstance].coverMainModel.announcementDatas addObject:announcement];
                    }
                }

                //获取轮播图信息
                NSDictionary  *param = @{
                                         @"type":@"业务端首页轮播图"
                                         };
                [RequestAPI getCoverLoopImage:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                    NSLog(@"%@",response);
                    if (response && [response isKindOfClass:[NSDictionary class]] && response[@"result"]) {
                        if ([response[@"result"] integerValue] == 1) {
                            NSLog(@"获取轮播图成功");
                            if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
                                NSArray *dataSet =  response[@"data"];
                                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
                                for (NSDictionary *dicData in dataSet) {
                                    CoverLoopimageModel *loopimage = [[CoverLoopimageModel alloc] init];
                                    [loopimage setValuesForKeysWithDictionary:dicData];
                                    [[UserInfoManager shareInstance].coverMainModel.loopImageDatas addObject:loopimage];
                                }
                            }
                            UserInfoManager *manager = [UserInfoManager shareInstance];
                            NSLog(@"");
                            UserInfoConfirmView *confirmView = [[UserInfoConfirmView alloc] initwithName:[UserInfoManager shareInstance].name department:[UserInfoManager shareInstance].employeeName worknumber:[NSString stringWithFormat:@"%@",[UserInfoManager shareInstance].employeeId]];
                            confirmView.delegate = self;
                            [self.view addSubview:confirmView];

                        }else if (([response[@"result"] integerValue] == 0)){
                            NSLog(@"获取轮播图失败");
                            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取轮播图错误" complete:nil];
                            [self.view addSubview:tipsView];
                        }
                    }
                } fail:^(id error) {
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
                    [self.view addSubview:tipsView];
                }];


            }else if (([response[@"result"] integerValue] == 0)){
                NSLog(@"获取公告失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"获取公告错误" complete:nil];
                [self.view addSubview:tipsView];
            }
        }
    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self.view addSubview:tipsView];
    }];


}

- (void)pressForgetBtn:(UIButton *)sender
{
    FindPasswordViewController *VC = [[FindPasswordViewController alloc] init];
     self.modalPresentationStyle=UIModalPresentationPopover;
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark userInfoConfrimDelegate;
- (void)didConfirmUserInfo:(BOOL)isConfirm
{
    if (isConfirm) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadCoverMainViewData" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{

    }
}

#pragma mark textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
