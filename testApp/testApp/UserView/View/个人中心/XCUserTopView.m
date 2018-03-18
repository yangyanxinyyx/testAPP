//
//  XCUserTopView.m
//  testApp
//
//  Created by Melody on 2018/3/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserTopView.h"

@interface XCUserTopView()

@property (nonatomic, strong) UIImageView * bgImageView ;
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UIView * innerView ;

@property (nonatomic, strong) UIImageView * iconImageView ;
@property (nonatomic, strong) UILabel * nameLable ;
@property (nonatomic, strong) UIView * separator ;
@property (nonatomic, strong) UIButton * myCommissionBtn ;
@property (nonatomic, strong) UIButton * modifyPasswordBtn ;
@end

@implementation XCUserTopView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        self.userInteractionEnabled = YES;
        [self addSubview:self.bgImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.innerView];
        [self.innerView addSubview:self.iconImageView];
        [self.innerView addSubview:self.nameLable];
        [self.innerView addSubview:self.myCommissionBtn];
        [self.innerView addSubview:self.modifyPasswordBtn];
        [self.innerView addSubview:self.separator];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.bgImageView setFrame:CGRectMake(0, 0, self.bounds.size.width, 330 * ViewRateBaseOnIP6)];
    [self.titleLabel setFrame:CGRectMake(304 * ViewRateBaseOnIP6, 35 * ViewRateBaseOnIP6, 142 * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6)];
    NSInteger innerWidth = 690 * ViewRateBaseOnIP6;
    NSInteger innerHeight = 310 * ViewRateBaseOnIP6;
    
    [self.innerView setFrame:CGRectMake((self.bounds.size.width - innerWidth) * 0.5,self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 30 * ViewRateBaseOnIP6 , innerWidth,innerHeight)];
    [self.iconImageView setFrame:CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6)];
    [self.nameLable setFrame:CGRectMake(200 * ViewRateBaseOnIP6, 86 * ViewRateBaseOnIP6,self.innerView.frame.size.width - 200 * ViewRateBaseOnIP6 , 28 * ViewRateBaseOnIP6)];

    CGFloat btnWidth= (self.innerView.frame.size.width - 1) * 0.5;
    CGFloat btnHeight = 80 * ViewRateBaseOnIP6;
    CGFloat btImageViewWidth = 46 * ViewRateBaseOnIP6;
    CGFloat btImageViewHeight = 46 * ViewRateBaseOnIP6;
    CGFloat btTitleWidth = 110 * ViewRateBaseOnIP6;
    CGFloat btTitleHeight = 27 * ViewRateBaseOnIP6;
    [self.myCommissionBtn setFrame:CGRectMake(0, (self.innerView.frame.size.height - (80 + 30) * ViewRateBaseOnIP6),btnWidth, btnHeight)];
    self.myCommissionBtn.imageView.frame = CGRectMake(0, 0, btImageViewWidth, btImageViewHeight);
    self.myCommissionBtn.titleLabel.frame = CGRectMake(0, 0, btTitleWidth, btTitleHeight);
    [self.myCommissionBtn setImageEdgeInsets:UIEdgeInsetsMake((btnHeight - btImageViewHeight - 30 * ViewRateBaseOnIP6) * 0.5 , 74 * ViewRateBaseOnIP6,0,0)];
    [self.myCommissionBtn setTitleEdgeInsets:UIEdgeInsetsMake((btnHeight - btTitleHeight - 30 * ViewRateBaseOnIP6) * 0.5, 143 * ViewRateBaseOnIP6 - btImageViewWidth, 0, 0)];
    CGFloat mdBTImageViewWidth = 39 * ViewRateBaseOnIP6;
    CGFloat mdBTImageViewHeight = 46 * ViewRateBaseOnIP6;
    [self.modifyPasswordBtn setFrame:CGRectMake(self.innerView.frame.size.width - btnWidth - 1, (self.innerView.frame.size.height - (80 + 30) * ViewRateBaseOnIP6),btnWidth , btnHeight)];
    self.modifyPasswordBtn.imageView.frame = CGRectMake(0, 0, mdBTImageViewWidth, mdBTImageViewHeight);
    self.modifyPasswordBtn.titleLabel.frame = CGRectMake(0, 0, btTitleWidth, btTitleHeight);
    [self.modifyPasswordBtn setImageEdgeInsets:UIEdgeInsetsMake((btnHeight - btImageViewHeight - 30 * ViewRateBaseOnIP6) * 0.5 , 91 * ViewRateBaseOnIP6,0,0)];
    [self.modifyPasswordBtn setTitleEdgeInsets:UIEdgeInsetsMake((btnHeight - btTitleHeight - 30 * ViewRateBaseOnIP6) * 0.5, (91 + 22) * ViewRateBaseOnIP6 , 0, 0)];
    [self.separator setFrame:CGRectMake(344 * ViewRateBaseOnIP6, 200 * ViewRateBaseOnIP6, 1, 80 * ViewRateBaseOnIP6)];
}

#pragma mark - Action Method
//防止冲突
- (void)clickCommissionAndModifyPasswordBtn:(UIButton *)button
{
    NSLog(@"======>");
    if (self.myCommissionBtn == button) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserTopViewMyCommissionButtonClickHandler:)]) {
            [self.delegate XCUserTopViewMyCommissionButtonClickHandler:button];
        }else {
            XCLog(@"Error: class:%@ XCUserTopViewMyCommissionButtonClickHandler delegate was No",[self class]);
        }
    }else if(self.modifyPasswordBtn == button) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserTopViewModifyPasswordButtonClickHandler:)]) {
            [self.delegate XCUserTopViewModifyPasswordButtonClickHandler:button];
        }else {
            XCLog(@"Error: class:%@ XCUserTopViewModifyPasswordButtonClickHandler delegate was No",[self class]);
        }
    }
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

- (void)setUserIcon:(UIImage *)userIcon
{
    if (!userIcon) {
        return;
    }
    _userIcon = userIcon;
    self.iconImageView.image = _userIcon;
    
}

- (void)setUserName:(NSString *)userName
{
    if (!userName) {
        return;
    }
    _userName = userName;
    [self.nameLable setText:_userName];
    [self.nameLable sizeToFit];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        UIImage *bgImage = [UIImage imageNamed:@"背景"];
        _bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    }
    return _bgImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"个人中心"];
        [_titleLabel setTextColor:[UIColor whiteColor]];
    }
    return _titleLabel;
}

- (UIView *)innerView
{
    if (!_innerView) {
        _innerView = [[UIView alloc] init];
        _innerView.backgroundColor = [UIColor whiteColor];
        _innerView.layer.cornerRadius = 5;
        _innerView.layer.shadowOffset = CGSizeMake(0, 3);
        _innerView.layer.shadowOpacity = 0.2;
        _innerView.layer.shadowRadius = 3;
        _innerView.layer.shadowColor = [UIColor colorWithHexString:@"#cecece"].CGColor;
    }
    return _innerView;
}

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        UIImage *userIcon = [UIImage imageNamed:@"个人中心"];
        _iconImageView = [[UIImageView alloc] initWithImage:userIcon];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UILabel *)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(200 * ViewRateBaseOnIP6, 86 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6)];
        NSString *name = @"未知用户";
        [_nameLable setText:name];
        [_nameLable setTextColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0f]];
        [_nameLable setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
        [_nameLable setTextAlignment:NSTextAlignmentLeft];
        [_nameLable sizeToFit];
    }
    return _nameLable;
}

- (UIButton *)myCommissionBtn
{
    if (!_myCommissionBtn) {
        UIImage *commissionIcon = [UIImage imageNamed:@"我的佣金"];
        
    
        UIColor * textColor = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
        UIFont *commonFont = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
        _myCommissionBtn = [UIButton buttonWithType:0];
        [_myCommissionBtn setImage:commissionIcon forState:UIControlStateNormal];
        [_myCommissionBtn setTitle:@"我的佣金" forState:UIControlStateNormal];
        [_myCommissionBtn setTitleColor:textColor forState:UIControlStateNormal];
        [_myCommissionBtn.titleLabel setFont:commonFont];
        [_myCommissionBtn addTarget:self action:@selector(clickCommissionAndModifyPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myCommissionBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
   
        //修改密码按钮 初始化
        if (!_modifyPasswordBtn) {
            UIImage *modifyIcon = [UIImage imageNamed:@"修改密码"];
            _modifyPasswordBtn = [UIButton buttonWithType:0];
            [_modifyPasswordBtn setImage:modifyIcon forState:UIControlStateNormal];
            [_modifyPasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
            [_modifyPasswordBtn setTitleColor:textColor forState:UIControlStateNormal];
            [_modifyPasswordBtn.titleLabel setFont:commonFont];
            [_modifyPasswordBtn addTarget:self action:@selector(clickCommissionAndModifyPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_modifyPasswordBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        }

    }
    return _myCommissionBtn;
}

- (UIView *)separator
{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        [_separator setBackgroundColor:[UIColor colorWithRed:229.0f/255.0f green:229.0f/255.0f blue:229.0f/255.0f alpha:1.0f]];
    }
    return _separator;
}

@end
