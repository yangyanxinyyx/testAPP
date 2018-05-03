//
//  XCShopRejectView.m
//  testApp
//
//  Created by Melody on 2018/5/3.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopRejectView.h"
#import "UILabel+createLabel.h"
@interface XCShopRejectView()

@property (nonatomic, strong) UIView *centerView ;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * tipsImageView ;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIView * topSeparator;
@property (nonatomic, strong) UIView * verticalSparator;
@property (nonatomic, strong) UIButton * comfirmBtn;
@property (nonatomic, strong) UIButton * cancelBtn ;

@property (nonatomic, copy) callBackBlock confirmblock;

@end

@implementation XCShopRejectView

#pragma mark - Init Method

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                     confirmClick:(callBackBlock)confirmblock
{
    
    XCShopRejectView *alterView = [[XCShopRejectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alterView.titleStr = title;
    alterView.contentStr = content;
//    alterView.cancelStr = cancelString;
//    alterView.confirmStr = confirmString;
    alterView.confirmblock  = confirmblock;
    
    [[UIApplication  sharedApplication].keyWindow addSubview:alterView];
    return alterView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:COLOR_RGBA_255(0, 0, 0, 0.6)];
        
        //提示框
        _centerView = [[UIView alloc] initWithFrame:CGRectZero];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = 5;
        _centerView.layer.masksToBounds = YES;
        [self addSubview:_centerView];
        
        UIImage *tipsImage = [UIImage imageNamed:@"reject"];
        _tipsImageView = [[UIImageView alloc] initWithImage:tipsImage];
        [_centerView addSubview:_tipsImageView];
        //标题
        _titleLabel = [UILabel createLabelWithTextFontSize:30 textColor:COLOR_RGB_255(51, 51, 51)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_centerView addSubview:_titleLabel];
        
        //内容
        _contentLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(51, 51, 51)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_centerView addSubview:_contentLabel];
        
        _topSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        [_topSeparator setBackgroundColor: COLOR_RGB_255(229, 229, 229)];
        [_centerView addSubview:_topSeparator];
    
        _verticalSparator = [[UIView alloc] initWithFrame:CGRectZero];
        [_verticalSparator setBackgroundColor: COLOR_RGB_255(229, 229, 229)];
        [_centerView addSubview:_verticalSparator];
        
        //确定按钮
        _comfirmBtn =[UIButton buttonWithType:0];
        [_comfirmBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:(30) * ViewRateBaseOnIP6]];
        [_comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_comfirmBtn setTitleColor:COLOR_RGB_255(51, 51, 51) forState:UIControlStateNormal];        [_comfirmBtn addTarget:self action:@selector(clickComfirmButton:) forControlEvents:UIControlEventTouchUpInside];
        [_centerView addSubview:_comfirmBtn];
        
//        //取消按钮
//        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectZero];
//        [_cancelBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:(28) * ViewRateBaseOnIP6]];
//        [_cancelBtn setTitleColor:COLOR_RGB_255(51, 51, 51) forState:UIControlStateNormal];
//        [_cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
//        [_centerView addSubview:_cancelBtn];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentViewW = 450 * ViewRateBaseOnIP6;
    CGFloat contentLabelWidth = contentViewW - (22 * ViewRateBaseOnIP6 * 2);
    CGFloat contentHeight = 0;
    if (isUsableNSString(self.contentLabel.text, @"")) {
        contentHeight = [UILabel getHeightLineWithString:self.contentLabel.text withWidth:contentLabelWidth withFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]];
    }
    CGFloat totalHeight = (108 + 126) * ViewRateBaseOnIP6  + contentHeight;
    
    
    [self.centerView setFrame:CGRectMake(0, 0, contentViewW , totalHeight)];
    [self.centerView setCenter:self.center];
    
    //CenterView subView

    CGSize labelSize = CGSizeMake(27 *ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    [self.tipsImageView setFrame:CGRectMake(148 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
    [self.titleLabel sizeToFit];
    labelSize = self.titleLabel.frame.size;
    if (labelSize.width > contentLabelWidth - (185 + 22) * ViewRateBaseOnIP6) {
        labelSize.width = contentLabelWidth - (185 + 22) * ViewRateBaseOnIP6;
    }
    [self.titleLabel setFrame:CGRectMake(185 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6, labelSize.width, 28 * ViewRateBaseOnIP6)];
    
    [self.contentLabel sizeToFit];
    labelSize = CGSizeMake(contentLabelWidth, contentHeight);
    [self.contentLabel setFrame:CGRectMake(22 * ViewRateBaseOnIP6, CGRectGetMaxY(self.titleLabel.frame) +  40 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
    [self.topSeparator setFrame:CGRectMake(0,CGRectGetMaxY(self.contentLabel.frame )- 1  + 40 * ViewRateBaseOnIP6, self.frame.size.width, 1)];
    [self.comfirmBtn sizeToFit];
    labelSize = self.comfirmBtn.frame.size;
    [self.comfirmBtn setFrame:CGRectMake((self.centerView.frame.size.width - labelSize.width) * 0.5, CGRectGetMaxY(self.topSeparator.frame) +  30 * ViewRateBaseOnIP6,labelSize.width , 27 * ViewRateBaseOnIP6)];
    
}


#pragma mark - Action Method

- (void)clickComfirmButton:(UIButton *)button
{
    if (self.confirmblock) {
        self.confirmblock(self);
    }
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

#pragma mark - Setter&Getter

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
    [self layoutSubviews];

}

- (void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    _contentLabel.text = contentStr;
    [self layoutSubviews];
}


@end
