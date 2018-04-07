//
//  XCModifyPwdViewController.m
//  testApp
//
//  Created by Melody on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCModifyPwdViewController.h"

@interface XCModifyPwdViewController ()<BaseNavigationBarDelegate>

@end

@implementation XCModifyPwdViewController


#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
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
        accoutTextField.textAlignment = NSTextAlignmentLeft;
        accoutTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        accoutTextField.returnKeyType = UIReturnKeyDone;
        accoutTextField.delegate = self;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
        accoutTextField.leftView=imageView;
        accoutTextField.leftViewMode = UITextFieldViewModeAlways;
        accoutTextField.font = [UIFont systemFontOfSize:14];
        
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
    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"修改成功" complete:nil];
    [self.view addSubview:tipsView];
}
#pragma mark - Delegates & Notifications

#pragma  mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
@end
