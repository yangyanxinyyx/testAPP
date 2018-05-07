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
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 190 * kScaleHeight)];
    [self.view addSubview:topImageView];
    topImageView.backgroundColor = [UIColor redColor];
    topImageView.image = [UIImage imageNamed:@"shouye.png"];

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
        accoutTextField.tag = i;
        [accoutTextField addTarget:self action:@selector(textFieldDidChangePhoneNnumber:) forControlEvents:UIControlEventEditingChanged];

        if (i == 0) {
            accoutTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }

        if (i == 1) {
            accoutTextField.frame = CGRectMake(10, CGRectGetMaxY(topImageView.frame) + i * 44, SCREEN_WIDTH-20 - 110, 44);

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
        }else if (i == 2 || i == 3){
            accoutTextField.secureTextEntry = YES;
        }

            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(topImageView.frame) + 44 * (i +1), SCREEN_WIDTH - 30, 1)];
            line.backgroundColor = COLOR_RGBA_255(229, 229, 229, 1);
            [self.view addSubview:line];

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
    UIButton *backBtn = [[UIButton  alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44)];
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

#pragma mark textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
        if (textField.tag == 0) {
            NSString *str = [YXTestNumber testingMobile:textField.text];
            if (str && str.length > 0) {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:str complete:^{
                    textField.text = @"";
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            }

        }else if (textField.tag == 1){

        }else {
            if (textField.text.length < 6 && textField.text.length > 0) {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"密码字数不能低于6位" complete:^{
                    textField.text = @"";
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            }
        }

    if (textField.tag == 3) {
        UITextField *passField = [self.view viewWithTag:2];
        if (![textField.text isEqualToString:passField.text]) {
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"请确认密码保持一致" complete:^{
                textField.text = @"";
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        }
    }

}

- (void)textFieldDidChangePhoneNnumber:(UITextField *)textField{
    if (textField.tag == 0) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:LETTERNUMKEYBOARD] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
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
