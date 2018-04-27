//
//  XCUserListFooterView.m
//  testApp
//
//  Created by Melody on 2018/4/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserListFooterView.h"
@interface XCUserListFooterView ()

/** <# 注释 #> */
@property (nonatomic, strong) UIButton * cancelBtn ;

@end

@implementation XCUserListFooterView
+ (CGFloat)getFooterViewHeight
{
    return (30 + 80 + 30) * ViewRateBaseOnIP6;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _cancelBtn = [UIButton buttonWithType:0];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [_cancelBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:COLOR_RGB_255(131, 131, 131) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
    }
    return self;
}

- (void)clickCancelBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserListFooterViewClickCancelBtn:)]) {
        [self.delegate XCUserListFooterViewClickCancelBtn:button];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_cancelBtn setFrame:CGRectMake(0 , 30 * ViewRateBaseOnIP6, self.bounds.size.width, 80 * ViewRateBaseOnIP6)];
}


@end
