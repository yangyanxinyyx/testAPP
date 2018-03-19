//
//  FindPasswordViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "FinishTipsView.h"

@interface FindPasswordViewController ()<UITextFieldDelegate>

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];



}

- (void)createUI
{
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + kNavMargan, SCREEN_WIDTH, 190 * kScaleHeight)];
    [self.view addSubview:topImageView];
    topImageView.backgroundColor = [UIColor redColor];
    topImageView.image = [UIImage imageNamed:@""];

    NSArray *titles = @[@"请输入手机号码",@"请输入验证码",@"请输入密码",@"请确认密码"];
    NSArray *images = @[@"login_username.png",@"login_code.png",@"login_password.png",@"login_password.png"];
    for (int i=0; i<4; i++) {
        UITextField *accoutTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(topImageView.frame) + i * 44, SCREEN_WIDTH-20, 44)];
        [self.view addSubview:accoutTextField];
        accoutTextField.placeholder = titles[i];
        accoutTextField.clearButtonMode = UITextFieldViewModeAlways;
        accoutTextField.clearsOnBeginEditing = YES;
        accoutTextField.textAlignment = NSTextAlignmentLeft;
        accoutTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        accoutTextField.returnKeyType = UIReturnKeyDone;
        accoutTextField.delegate = self;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
        accoutTextField.leftView=imageView;
        accoutTextField.leftViewMode = UITextFieldViewModeAlways;
        accoutTextField.font = [UIFont systemFontOfSize:14];

        if (i == 1) {
            accoutTextField.frame = CGRectMake(10, CGRectGetMaxY(topImageView.frame) + i * 44, SCREEN_WIDTH-20 - 90, 44);

            UIButton *sendCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 90,CGRectGetMaxY(topImageView.frame) + i * 44+ 7, 90, 30)];
            [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [sendCodeBtn setTitleColor:COLOR_RGB_255(57, 174, 54) forState:UIControlStateNormal];
            sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            sendCodeBtn.layer.cornerRadius = 5;
            sendCodeBtn.layer.masksToBounds = YES;
            [sendCodeBtn addTarget:self action:@selector(pressSendCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
            sendCodeBtn.layer.borderWidth =1;
            sendCodeBtn.layer.borderColor = [COLOR_RGB_255(57, 174, 54) CGColor];
            [self.view addSubview:sendCodeBtn];
        }

        if (i != 2) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(topImageView.frame) + 44 * (i +1), SCREEN_WIDTH - 30, 1)];
            line.backgroundColor = COLOR_RGBA_255(229, 229, 229, 1);
            [self.view addSubview:line];
        }

    }

    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 345) / 2, CGRectGetMaxY(topImageView.frame) +44*4 + 50, 345, 44)];
    [self.view addSubview:confirmBtn];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    confirmBtn.backgroundColor = COLOR_RGB_255(0, 77, 162);
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(pressConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];

    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIButton *backBtn = [[UIButton  alloc] initWithFrame:CGRectMake(15, 13 + STATUS_BAR_HEIGHT + kNavMargan, image.size.width, image.size.height)];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(pressBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}


- (void)pressSendCodeBtn:(UIButton *)sender
{

}

- (void)pressConfirmBtn:(UIButton *)sender
{
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"密码设置成功" complete:nil];
    [self.view addSubview:tipsView];
}

- (void)pressBackBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
