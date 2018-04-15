//
//  InputTextView.m
//  testApp
//
//  Created by 严玉鑫 on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "InputTextView.h"
@interface InputTextView()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *viewContent;
@property (nonatomic,strong) UILabel *labelNameInp;
@property (nonatomic,strong) UILabel *labelPriceName;
@property (nonatomic,strong) UITextField *textFieldName;
@property (nonatomic,strong) UIButton *buttonCancle;
@property (nonatomic,strong) UIButton *buttonSure;

@end
@implementation InputTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self addSubview:self.viewContent];
        [self.viewContent addSubview:self.labelNameInp];
        [self.viewContent addSubview:self.labelPriceName];
        [self.viewContent addSubview:self.textFieldName];
        [self.viewContent addSubview:self.buttonCancle];
        [self.viewContent addSubview:self.buttonSure];
    }
    return self;
}

- (void)touchCancleButton:(UIButton *)button{
    [self.delegate inputTextFieldWithText:nil];
    [self removeFromSuperview];
}

- (void)touchSureButton:(UIButton *)button{
    [self.delegate inputTextFieldWithText:self.textFieldName.text];
    [self removeFromSuperview];
}

- (UIView *)viewContent{
    if (!_viewContent) {
        _viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 540 * ViewRateBaseOnIP6, 358 * ViewRateBaseOnIP6)];
        _viewContent.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        _viewContent.backgroundColor = [UIColor whiteColor];
        _viewContent.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        _viewContent.layer.masksToBounds = YES;
    }
    return _viewContent;
}

- (UILabel *)labelNameInp{
    if (!_labelNameInp) {
        _labelNameInp = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.viewContent.frame), 30 * ViewRateBaseOnIP6)];
        _labelNameInp.text = @"名称输入";
        _labelNameInp.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
        _labelNameInp.textAlignment = NSTextAlignmentCenter;

    }
    return _labelNameInp;
}

- (UILabel *)labelPriceName{
    if (!_labelPriceName) {
        _labelPriceName = [[UILabel alloc] initWithFrame:CGRectMake(67 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6, 200, 26 * ViewRateBaseOnIP6)];
        _labelPriceName.textColor = [UIColor colorWithRed:131 / 255.0 green:131 / 255.0 blue:131 / 255.0 alpha:1.0];
        _labelPriceName.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
        _labelPriceName.text = @"报价名称";
        _labelPriceName.textColor = [UIColor colorWithRed:131 / 255.0 green:131 / 255.0 blue:131 / 255.0 alpha:1.0];
        [_labelPriceName sizeToFit];
    }
    return _labelPriceName;
}

- (UITextField *)textFieldName{
    if (!_textFieldName) {
        _textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPriceName.frame) + 23 * ViewRateBaseOnIP6, 128 * ViewRateBaseOnIP6, 540 * ViewRateBaseOnIP6 - (255 * ViewRateBaseOnIP6), 50 * ViewRateBaseOnIP6)];;
        _textFieldName.placeholder = @"  输入名称";
        _textFieldName.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
        _textFieldName.delegate = self;
    }
    return _textFieldName;
}

- (UIButton *)buttonCancle {
    if (!_buttonCancle) {
        _buttonCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonCancle.frame = CGRectMake(67 * ViewRateBaseOnIP6, 238 * ViewRateBaseOnIP6, 180 * ViewRateBaseOnIP6, 60 * ViewRateBaseOnIP6);
        [_buttonCancle setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonCancle setTitleColor:[UIColor colorWithRed:131 / 255.0 green:131 / 255.0 blue:131 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_buttonCancle setBackgroundColor:[UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1.0]];
        _buttonCancle.layer.cornerRadius = 5 * ViewRateBaseOnIP6;
        _buttonCancle.layer.masksToBounds = YES;
        [_buttonCancle addTarget:self action:@selector(touchCancleButton:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonCancle;
}

- (UIButton *)buttonSure{
    if (!_buttonSure) {
        _buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonSure.frame = CGRectMake(CGRectGetMaxX(self.buttonCancle.frame) + 46 * ViewRateBaseOnIP6, 238 * ViewRateBaseOnIP6, 180 *ViewRateBaseOnIP6, 60 *ViewRateBaseOnIP6);
        [_buttonSure setTitle:@"确认" forState:UIControlStateNormal];
        [_buttonSure setTitleColor:[UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_buttonSure setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:77 / 255.0 blue:162 / 255.0 alpha:1.0]];
        _buttonSure.layer.cornerRadius = 5 * ViewRateBaseOnIP6;
        _buttonSure.layer.masksToBounds = YES;
        [_buttonSure addTarget:self action:@selector(touchSureButton:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonSure;
}

@end
