//
//  LYZAlertView.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "LYZAlertView.h"
@interface LYZAlertView ()

@property (nonatomic, strong) UIView *centerView ;
@property (nonatomic, strong) UIView * bgView ;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIView * topSeparator;
@property (nonatomic, strong) UIView * verticalSparator;
@property (nonatomic, strong) UIButton * comfirmBtn;
@property (nonatomic, strong) UIButton * cancelBtn ;

@property (nonatomic, copy) comfirmBlock comfirmblock;
@property (nonatomic, copy) cancelBlock cancelblock;


@end


@implementation LYZAlertView

#pragma mark - Init Method

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                       comfirmStr:(NSString *)comfirmString
                        cancelStr:(NSString *)cancelString
                     comfirmClick:(comfirmBlock)comfirmblock
                      cancelClick:(cancelBlock)cancelblock
{

    LYZAlertView *alterView = [[LYZAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    alterView.titleStr = title;
    alterView.contentStr = content;
    alterView.cancelStr = cancelString;
    alterView.comfirmStr = comfirmString;
    alterView.cancelblock  = cancelblock;
    alterView.comfirmblock  = comfirmblock;
    
    return alterView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        //背景蒙版
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancelButton:)];
        [_bgView addGestureRecognizer:tap];
        [_bgView setBackgroundColor:COLOR_RGBA_255(0, 0, 0, 0.6)];
        [self addSubview:_bgView];
        
        //提示框
        _centerView = [[UIView alloc] initWithFrame:CGRectZero];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = 5;
        _centerView.layer.masksToBounds = YES;
        [self addSubview:_centerView];
        
        //标题
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = COLOR_RGB_255(68, 68, 68);
        [_titleLabel setFont:[UIFont systemFontOfSize: 34 * ViewRateBaseOnIP6]];
        [_centerView addSubview:_titleLabel];
        
        //内容
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor redColor];
        [_centerView addSubview:_contentLabel];
        
        _topSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        [_topSeparator setBackgroundColor: COLOR_RGB_255(229, 229, 229)];
        [_centerView addSubview:_topSeparator];
        
        //确定按钮
        _comfirmBtn =[UIButton buttonWithType:0];
        [_comfirmBtn setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
        [_comfirmBtn addTarget:self action:@selector(clickComfirmButton:) forControlEvents:UIControlEventTouchUpInside];
        [_centerView addSubview:_comfirmBtn];
        
        _verticalSparator = [[UIView alloc] initWithFrame:CGRectZero];
        [_verticalSparator setBackgroundColor: COLOR_RGB_255(229, 229, 229)];
        [_centerView addSubview:_verticalSparator];
        
        //取消按钮
        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectZero];
        [_cancelBtn setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_centerView addSubview:_cancelBtn];
       
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.bgView setFrame:self.frame];
    [self.centerView setFrame:CGRectMake(0, 0, 540 * ViewRateBaseOnIP6, 220 * ViewRateBaseOnIP6)];
    self.centerView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    
    //centerView subViews
    [self.titleLabel setFrame:CGRectMake(0, 0, self.centerView.bounds.size.width, 110 * ViewRateBaseOnIP6)];

    
     [self.contentLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.centerView.bounds.size.width, 110 * ViewRateBaseOnIP6)];
    if (!self.contentStr) {
        [self.contentLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.centerView.bounds.size.width, 0)];
    }
    [self.topSeparator setFrame:CGRectMake(0,CGRectGetMaxY(self.contentLabel.frame),self.centerView.bounds.size.width, 1)];
    
    CGFloat btnWidth = self.centerView.bounds.size.width * 0.5;
    CGFloat btnHeight =  80 * ViewRateBaseOnIP6;
    [self.comfirmBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.topSeparator.frame) + 14.5 * ViewRateBaseOnIP6 , btnWidth,btnHeight)];
    [self.cancelBtn setFrame:CGRectMake(btnWidth , self.comfirmBtn.frame.origin.y, btnWidth, btnHeight)];

    [self.verticalSparator setFrame:CGRectMake(self.centerView.bounds.size.width * 0.5 ,CGRectGetMaxY(self.topSeparator.frame) +(self.centerView.bounds.size.height - self.topSeparator.frame.origin.y  - btnHeight ) * 0.5 , 1, btnHeight)];
    
}

#pragma mark - Action Method

- (void)clickComfirmButton:(UIButton *)button
{
    self.comfirmblock(self);
}

- (void)clickCancelButton:(UIButton *)button
{
    self.cancelblock(self);
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

- (void)setTitleStr:(NSString *)titleStr
{
    _titleLabel.text = titleStr;
}

- (void)setContentStr:(NSString *)contentStr
{
    _contentLabel.text = contentStr;
}

-(void)setComfirmStr:(NSString *)comfirmStr
{
    [_comfirmBtn setTitle:comfirmStr forState:UIControlStateNormal];
}

- (void)setCancelStr:(NSString *)cancelStr
{
    [_cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
}



@end


