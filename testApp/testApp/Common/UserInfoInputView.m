//
//  UserInfoInputView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/12.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserInfoInputView.h"
#import "DatePickerView.h"

@interface UserInfoInputView ()<UITextFieldDelegate>



@end

@implementation UserInfoInputView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title type:(InputViewType)type
{
    if (self = [super initWithFrame:frame]) {
        [self createUIWithTitle:title type:type];
    }
    return self;
}

- (void)createUIWithTitle:(NSString *)title type:(InputViewType)type
{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, 62, 14)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = COLOR_RGB_255(68, 68, 68);
    [self addSubview:label];

    if (type == InputViewTypeTextField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 8, 16, 200, 14)];
        [self addSubview:_textField];
        _textField.placeholder = @"请输入...";
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.clearsOnBeginEditing = YES;
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:14];
    }else if (type == InputViewTypeSelect){
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 84, 0, 84, 44)];
        [_selectBtn setTitle:@"精致洗车" forState:UIControlStateNormal];
        [self addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(pressSelectbtn:) forControlEvents:UIControlEventTouchUpInside];

    }else{
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, SCREEN_WIDTH - 85, 44)];
        _dateLabel.textColor = COLOR_RGB_255(68, 68, 68);
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dateLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        [_dateLabel addGestureRecognizer:tap];


    }

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 30, 1)];
    [self addSubview:line];
    line.backgroundColor = COLOR_RGB_255(242, 242, 242);


}

- (void)tapView{

//    UIViewController *VC = nil;
//    for (UIView* next = [self superview];next; next = next.superview){
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
//            VC = (UIViewController*)nextResponder;
//        }
//    }

    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSString *date) {
        self.dateLabel.text = date;
    };


}

- (void)pressSelectbtn:(UIButton *)sender
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
