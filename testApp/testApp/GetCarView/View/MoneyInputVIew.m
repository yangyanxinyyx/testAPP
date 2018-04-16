//
//  MoneyInputVIew.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/9.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "MoneyInputVIew.h"

@interface MoneyInputVIew ()

@property (nonatomic,strong) UITextField *insurancetTF;
@property (nonatomic,strong) UITextField *selfTF;

@end

@implementation MoneyInputVIew

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = COLOR_RGBA_255(0, 0, 0, 0.4);

        UIView *backGround = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-270)/2, 191, 270, 211)];
        [self addSubview:backGround];
        backGround.layer.cornerRadius = 5;
        backGround.layer.masksToBounds = YES;
        backGround.backgroundColor = [UIColor whiteColor];

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 270, 15)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"金额输入";
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = COLOR_RGB_255(68, 68, 68);
        [backGround addSubview:title];

        UILabel *insuranceTitle = [[UILabel alloc] initWithFrame:CGRectMake(34, 56, 56, 25)];
        insuranceTitle.text = @"保险金额";
        insuranceTitle.font = [UIFont systemFontOfSize:13];
        insuranceTitle.textColor = COLOR_RGB_255(131, 131, 131);
        [backGround addSubview:insuranceTitle];

        UILabel *selfTitle = [[UILabel alloc] initWithFrame:CGRectMake(34, 96, 56, 25)];
        selfTitle.text = @"自费金额";
        selfTitle.font = [UIFont systemFontOfSize:13];
        selfTitle.textColor = COLOR_RGB_255(131, 131, 131);
        [backGround addSubview:selfTitle];

        _insurancetTF = [[UITextField alloc] initWithFrame:CGRectMake(97, 55, 140, 25)];
        _insurancetTF.font = [UIFont systemFontOfSize:12];
        _insurancetTF.delegate = self;
        _insurancetTF.placeholder = @"输入金额";
        _insurancetTF.keyboardType = UIKeyboardTypeNumberPad;
        _insurancetTF.tag = 0;
        [backGround addSubview:_insurancetTF];
        _insurancetTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _insurancetTF.leftViewMode = UITextFieldViewModeAlways;
        _insurancetTF.backgroundColor = COLOR_RGB_255(240, 240, 240);
        [_insurancetTF setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];

        _selfTF = [[UITextField alloc] initWithFrame:CGRectMake(97, 95, 140, 25)];
        _selfTF.delegate = self;
        _selfTF.placeholder = @"输入金额";
        _selfTF.keyboardType = UIKeyboardTypeNumberPad;
        _selfTF.tag = 1;
        _selfTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _selfTF.leftViewMode = UITextFieldViewModeAlways;
        [backGround addSubview:_selfTF];
        _selfTF.backgroundColor = COLOR_RGB_255(240, 240, 240);
        _selfTF.font = [UIFont systemFontOfSize:12];
        [_selfTF setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];

        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(33, 150, 90, 30)];
        cancelBtn.backgroundColor = COLOR_RGB_255(218, 218, 218);
        [cancelBtn setTitleColor:COLOR_RGB_255(131, 131, 131) forState:UIControlStateNormal];
        cancelBtn.layer.cornerRadius = 3;
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(pressCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [backGround addSubview:cancelBtn];

        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(147, 150, 90, 30)];
        confirmBtn.backgroundColor = COLOR_RGB_255(0, 77, 162);
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmBtn.layer.cornerRadius = 3;
        confirmBtn.layer.masksToBounds = YES;
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(pressConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        [backGround addSubview:confirmBtn];


    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField endEditing:YES];

    return  YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMKEYBOARD] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];


}

- (void)pressCancelBtn
{
    [self removeFromSuperview];
}

- (void)pressConfirmBtn
{
    if (!_insurancetTF.text && !_selfTF.text) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"请输入金额" complete:nil];
        [self addSubview:tipsView];
        return;
    }

    NSDictionary *param = @{@"id":_orderId,
                            @"insurance":[NSNumber numberWithInt:[_insurancetTF.text intValue]],
                            @"weixiuZifei":[NSNumber numberWithInt:[_selfTF.text intValue] ]
                            };
    [RequestAPI getGetCarFinish:param header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (isUsableDictionary(response)) {
            if ([response[@"result"] integerValue] == 1) {
                NSLog(@"接车金额输入成功");
                [UserInfoManager shareInstance].ticketID = response[@"newTicketId"] ? response[@"newTicketId"] : @"";

                dispatch_async(dispatch_get_main_queue(), ^{
                    FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"金额输入成功!" complete:^{

                        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadGetCarListWithPlateNO)]) {
                            [self.delegate reloadGetCarListWithPlateNO];
                        }
                        [self removeFromSuperview];
                    }];

                    [self addSubview:tipsView];
                });

            }else{
                NSLog(@"接车金额失败");
                FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"接车金额错误" complete:nil];
                [self addSubview:tipsView];
            }
        }

    } fail:^(id error) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"网络错误" complete:nil];
        [self addSubview:tipsView];
    }];


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
