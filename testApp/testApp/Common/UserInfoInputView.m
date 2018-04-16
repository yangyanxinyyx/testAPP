//
//  UserInfoInputView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/12.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserInfoInputView.h"
#import "DatePickerView.h"
#import "SelectStateView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "SelectTimeView.h"

@interface UserInfoInputView ()<UITextFieldDelegate>

@property (nonatomic,strong) id param;

@end

@implementation UserInfoInputView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title type:(InputViewType)type param:(id)param
{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        [self createUIWithTitle:title type:type];
        self.backgroundColor = [UIColor whiteColor];
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
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 44)];
        NSString *str = nil;

        NSArray *array = (NSArray *)self.param;
        str = array[0];


        [_selectBtn setTitle:str forState:UIControlStateNormal];
        [_selectBtn setTitleColor:COLOR_RGB_255(164, 164, 164) forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_selectBtn setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
        [_selectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
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

    SelectTimeView *busSelectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:busSelectTimeV];
    busSelectTimeV.block = ^(NSString *timeStr) {
       self.dateLabel.text = timeStr;
    };

}

- (void)pressSelectbtn:(UIButton *)sender
{
    if (self.param) {
        NSArray *array = (NSArray *)self.param;
        SelectStateView *selectView =  [[SelectStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) datArray:array WithCompletionHandler:^(NSString *content) {
            if (content) {
                [_selectBtn setTitle:content forState:UIControlStateNormal];
                [_selectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
            }
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:selectView];
    }

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
