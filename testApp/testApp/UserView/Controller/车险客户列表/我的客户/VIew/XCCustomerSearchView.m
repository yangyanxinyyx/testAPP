//
//  XCCustomerSearchView.m
//  testApp
//
//  Created by Melody on 2018/5/9.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerSearchView.h"

@interface XCCustomerSearchView ()<UITextFieldDelegate>

/** <# 注释 #> */
@property (nonatomic, strong) UIView * searchContentView ;
/** <# 注释 #> */
@property (nonatomic, strong) UITextField * searchFiled ;
@end

@implementation XCCustomerSearchView

#pragma mark - lifeCycle
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labeSize = CGSizeMake(540 * ViewRateBaseOnIP6, 56 * ViewRateBaseOnIP6);
    [_searchContentView setFrame:CGRectMake(105 * ViewRateBaseOnIP6, (self.bounds.size.height - labeSize.height) * 0.5 , labeSize.width, labeSize.height)];
    labeSize = CGSizeMake(_searchContentView.bounds.size.width - (20 + 20) * ViewRateBaseOnIP6 , 56 * ViewRateBaseOnIP6);
    [_searchFiled setFrame:CGRectMake(20 * ViewRateBaseOnIP6,  (_searchContentView.bounds.size.height - labeSize.height) * 0.5, labeSize.width, labeSize.height)];
    
}
#pragma mark - Init Method

- (instancetype)init
{
    self = [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 96 * ViewRateBaseOnIP6)];
    if (self) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    self.backgroundColor = [UIColor whiteColor];
    _searchContentView = [[UIView alloc] initWithFrame:CGRectZero];
    _searchContentView.backgroundColor = COLOR_RGB_255(240, 240, 240);
    _searchContentView.layer.cornerRadius = 5;
    _searchContentView.layer.masksToBounds = YES;
    
    _searchFiled =  [[UITextField alloc] initWithFrame:CGRectZero];
    _searchFiled.clearButtonMode = UITextFieldViewModeAlways;
    _searchFiled.returnKeyType = UIReturnKeyGo;
    _searchFiled.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    _searchFiled.placeholder = @"客户名称/手机号/车牌号";
    [_searchFiled setValue:[UIColor colorWithHexString:@"#838383"] forKeyPath:@"_placeholderLabel.textColor"];
    [_searchFiled setValue:[UIFont fontWithName:@"PingFang-SC-Medium" size:26 * ViewRateBaseOnIP6] forKeyPath:@"_placeholderLabel.font"];
    UIButton *rightView = [[UIButton alloc]init];
    [rightView setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    rightView.bounds = CGRectMake(-60 * ViewRateBaseOnIP6, 0, 18, 18);
    rightView.contentMode = UIViewContentModeCenter;
    [rightView addTarget:self action:@selector(clickSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    _searchFiled.rightView = rightView;
    _searchFiled.rightViewMode = UITextFieldViewModeAlways;
    _searchFiled.delegate = self;

    [self addSubview:_searchContentView];
    [_searchContentView addSubview:_searchFiled];
}

#pragma mark - Action Method

- (void)clickSearchWithText:(NSString *)text
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCustomerSearchViewClickSerachWithText:textFiled:)]) {
        [self.delegate XCCustomerSearchViewClickSerachWithText:text textFiled:self.searchFiled];
    }
}

- (void)clickSearchBtn:(UIButton *)button
{
    [self clickSearchWithText:self.searchFiled.text];
}
#pragma mark - Delegates & Notifications

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickSearchWithText:textField.text];
    
    return YES;
}
#pragma mark - Privacy Method

#pragma mark - Setter&Getter


@end
