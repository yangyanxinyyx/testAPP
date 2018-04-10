//
//  MoneyInputVIew.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/9.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "MoneyInputVIew.h"

@interface MoneyInputVIew ()

@property (nonatomic,strong) NSString *insuranceMoney;
@property (nonatomic,strong) NSString *selfMoney;

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

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(106, 20, 60, 14)];
        title.text = @"金额输入";
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = COLOR_RGB_255(68, 68, 68);
        [backGround addSubview:title];

        UILabel *insuranceTitle = [[UILabel alloc] initWithFrame:CGRectMake(34, 61, 53, 43)];
        insuranceTitle.text = @"保险金额";
        insuranceTitle.font = [UIFont systemFontOfSize:13];
        insuranceTitle.textColor = COLOR_RGB_255(131, 131, 131);
        [backGround addSubview:insuranceTitle];

        UILabel *selfTitle = [[UILabel alloc] initWithFrame:CGRectMake(34, 101, 53, 43)];
        selfTitle.text = @"自费金额";
        selfTitle.font = [UIFont systemFontOfSize:13];
        selfTitle.textColor = COLOR_RGB_255(131, 131, 131);
        [backGround addSubview:selfTitle];

        UITextField *insurancetTF = [[UITextField alloc] initWithFrame:CGRectMake(97, 55, 140, 25)];
        insurancetTF.delegate = self;
        insurancetTF.placeholder = @"输入金额";
        insurancetTF.keyboardType = UIKeyboardTypePhonePad;
        insurancetTF.tag = 0;
        [backGround addSubview:insurancetTF];

        UITextField *selfTF = [[UITextField alloc] initWithFrame:CGRectMake(97, 95, 140, 25)];
        selfTF.delegate = self;
        selfTF.placeholder = @"输入金额";
        selfTF.keyboardType = UIKeyboardTypePhonePad;
        selfTF.tag = 1;
        [backGround addSubview:selfTF];

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
    if (textField.tag == 0) {
        _insuranceMoney = textField.text;
    }else{
        _selfMoney = textField.text;
    }

    [textField endEditing:YES];

    return  YES;

}

- (void)pressCancelBtn
{
    [self removeFromSuperview];
}

- (void)pressConfirmBtn
{
    if (!_insuranceMoney && !_selfMoney) {
        FinishTipsView *tipsView = [[FinishTipsView alloc] initWithTitle:@"请输入金额" complete:nil];
        [self addSubview:tipsView];
        return;
    }

    if (self.delefate && [self.delefate respondsToSelector:@selector(MoneyDidInputWithInsurance:selfMoney:)]) {
        [self.delefate MoneyDidInputWithInsurance:_insuranceMoney selfMoney:_selfMoney];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
