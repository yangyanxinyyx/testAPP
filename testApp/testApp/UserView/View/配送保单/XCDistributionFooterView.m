//
//  XCDistributionFooterView.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCDistributionFooterView.h"
@interface XCDistributionFooterView ()
{
    UIButton *_confirmBtn;
}
@end

@implementation XCDistributionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize contentViewSize = self.contentView.frame.size;
    CGFloat btnW = 690 * ViewRateBaseOnIP6;
    CGFloat btnH = 88 * ViewRateBaseOnIP6;
    [_confirmBtn setFrame:CGRectMake(30 * ViewRateBaseOnIP6,(contentViewSize.height - btnH) * 0.5 , btnW, btnH)];
    
}

- (void)initUI
{
    [self.contentView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    
    _confirmBtn = [UIButton buttonWithType:0];
    _confirmBtn.layer.cornerRadius = 5;
    _confirmBtn.layer.backgroundColor = COLOR_RGB_255(0, 77, 162).CGColor;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:36 * ViewRateBaseOnIP6];
    [_confirmBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_confirmBtn];
}

- (void)clickConfirmBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCDistributionFooterViewClickConfirmBtn:)]) {
        [self.delegate XCDistributionFooterViewClickConfirmBtn:button];
    }else {
        NSLog(@"Error: - (void)clickConfirmBtn: delegate was nil");
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_confirmBtn setTitle:title forState:UIControlStateNormal];
}

@end
