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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + kNavMargan, SCREEN_WIDTH, 190 * kScaleHeight)];
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
                             @"userCode":@"17350805203",
                             @"password":@"1"
                             };
    [RequestAPI getUserInfo:param success:^(id response) {
        NSLog(@"%@",response);

        UserInfoConfirmView *confirmView = [[UserInfoConfirmView alloc] initwithName:@"王尼玛" department:@"技术部" worknumber:@"012"];
        confirmView.delegate = self;
        [self.view addSubview:confirmView];
    } fail:^(id error) {
        NSLog(@"%@",error);
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
