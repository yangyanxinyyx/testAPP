//
//  XCModifyPwdViewController.m
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCModifyPwdViewController.h"

@interface XCModifyPwdViewController ()<BaseNavigationBarDelegate,UITextFieldDelegate>
{
    BOOL isPass;
}
@property (nonatomic,strong) NSMutableArray *textFieldArray;
@end

@implementation XCModifyPwdViewController


#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    isPass = NO;
}

#pragma mark - Init Method

- (void)setupNav
{
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"修改密码";
    [self.view addSubview:topBar];
}

- (void)createUI
{
    NSArray *titles = @[@"请输入原密码",@"请输入密码",@"请确认密码"];
    NSArray *images = @[@"login_code.png",@"login_password.png",@"login_password.png"];
    for (int i=0; i<titles.count; i++) {
        UITextField *accoutTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, kHeightForNavigation + i * 44, SCREEN_WIDTH-20, 44)];
        [self.view addSubview:accoutTextField];
        
        accoutTextField.placeholder = titles[i];
        accoutTextField.clearButtonMode = UITextFieldViewModeAlways;
        accoutTextField.clearsOnBeginEditing = YES;
        accoutTextField.secureTextEntry = YES;
        accoutTextField.textAlignment = NSTextAlignmentLeft;
        accoutTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        accoutTextField.returnKeyType = UIReturnKeyDone;
        accoutTextField.delegate = self;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
        accoutTextField.leftView=imageView;
        accoutTextField.leftViewMode = UITextFieldViewModeAlways;
        accoutTextField.font = [UIFont systemFontOfSize:14];
        accoutTextField.tag = i;

        [self.textFieldArray addObject:accoutTextField];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, kHeightForNavigation + 44 * (i + 1), SCREEN_WIDTH - 30, 1)];
        line.backgroundColor = COLOR_RGBA_255(229, 229, 229, 1);
        [self.view addSubview:line];
        
    }
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 345) / 2, kHeightForNavigation + 44 * titles.count + 50, 345, 44)];
    [self.view addSubview:confirmBtn];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    confirmBtn.backgroundColor = COLOR_RGB_255(0, 77, 162);
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(pressConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action Method

- (void)pressConfirmBtn:(UIButton *)sender
{
    if (!isPass) {
        return;
    }
    UITextField *textFieldPassword = [self.textFieldArray objectAtIndex:0];
    UITextField *textFieldNewPassword = [self.textFieldArray objectAtIndex:1];
    for (UITextField *textField in self.textFieldArray) {
        [textField endEditing:YES];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserInfoManager shareInstance].userID forKey:@"id"];
    [dic setObject:textFieldPassword.text forKey:@"password"];
    [dic setObject:textFieldNewPassword.text forKey:@"newPassword"];
    __weak __typeof(self) weakSelf = self;
    [RequestAPI updatePassWord:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if ([response[@"result"] integerValue] == 1) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"修改成功" complete:nil];
            [self.view addSubview:tipsView];
        } else {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"修改失败,请联系客服" complete:nil];
            [self.view addSubview:tipsView];
        }
            [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";
    } fail:^(id error) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf showAlterInfoWithNetWork:@"网络错误" complete:nil];
    }];

}
#pragma mark - Delegates & Notifications
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITextField *textField in self.textFieldArray) {
        [textField endEditing:YES];
    }
}

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag == 2) {
         UITextField *textFieldNewPassword = [self.textFieldArray objectAtIndex:1];
        if (textFieldNewPassword.text.length == 0) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"请输入新密码" complete:nil];
            textField.text = @"";
            [[UIApplication sharedApplication].keyWindow addSubview:tipsView];
        }
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField endEditing:YES];
    
    if (textField.tag == 2) {
        UITextField *textFieldNewPassword = [self.textFieldArray objectAtIndex:1];
        if (![textField.text isEqualToString:textFieldNewPassword.text]) {
            isPass = YES;
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"确认密码错误" complete:nil];
            textField.text = @"";
            [[UIApplication sharedApplication].keyWindow addSubview:tipsView];
        } else {
            isPass = YES;
        }
    }
    
    if (textField.tag == 1) {
        if (textField.text.length < 6 && textField.text.length > 0) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"密码字数不少于6位" complete:nil];
            textField.text = @"";
            [[UIApplication sharedApplication].keyWindow addSubview:tipsView];
        }
        
        if (![YXTestNumber testingPassword:textField.text count:6] && textField.text.length > 0) {
            FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"密码必须英文和数字结合" complete:nil];
            textField.text = @"";
            [[UIApplication sharedApplication].keyWindow addSubview:tipsView];
        }
    }
    
    
    
}

#pragma  mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Privacy Method
- (void)showAlterInfoWithNetWork:(NSString *)titleStr complete:(void (^)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:titleStr complete:complete];
        [self.view addSubview:tipsView];
    });
}
#pragma mark - Setter&Getter
- (NSMutableArray *)textFieldArray{
    if (!_textFieldArray) {
        _textFieldArray = [NSMutableArray array];
    }
    return _textFieldArray;
}
@end
