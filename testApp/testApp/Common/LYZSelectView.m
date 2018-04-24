//
//  LYZSelectView.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "LYZSelectView.h"

@interface LYZSelectView ()
@property (nonatomic, strong) UIView * contentView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIScrollView * contentScrollerView ;
@property (nonatomic, copy) selectConfirmBlock confirmblock;
@end

@implementation LYZSelectView

#pragma mark - Init Method

+(instancetype)alterViewWithArray:(NSArray<NSString *> *)dataArr
                     confirmClick:(selectConfirmBlock)confirmblock
{
    LYZSelectView *alterView = [[LYZSelectView alloc]initWithArray:dataArr];
    alterView.confirmblock = confirmblock;
    return alterView;
}

- (instancetype)initWithArray:(NSArray<NSString *> *)dataArr {
    self=[super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]; // 初始化了init方法没有走initwithFrame
        [self setBackgroundColor:COLOR_RGBA_255(0, 0, 0, 0.4)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exit)];
        [self addGestureRecognizer:tap];
        
        CGFloat buttonW = 540 * ViewRateBaseOnIP6;
        CGFloat buttonH = 110 * ViewRateBaseOnIP6;
        CGFloat totalH = buttonH * dataArr.count;
        CGFloat startY = (SCREEN_HEIGHT -  totalH) * 0.5;
        if (dataArr.count > 5) {
            totalH = buttonH * 5;
            startY = (SCREEN_HEIGHT -  totalH) * 0.5;
        }
     
        _contentView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - buttonW) * 0.5, startY, buttonW, totalH)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        _contentView.layer.cornerRadius = 5;
        [self addSubview:_contentView];
        [_contentView setUserInteractionEnabled:YES];
        
        _contentScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, buttonW, totalH)];
        [_contentScrollerView setUserInteractionEnabled:YES];
        [_contentView addSubview:_contentScrollerView];
        [_contentScrollerView setContentSize:CGSizeMake(0, buttonH * dataArr.count)];
        
        for (int i = 0 ; i < dataArr.count; i++) {
            NSString *title = dataArr[i];
            UIButton *button = [UIButton buttonWithType:0];
            [button setTitle:title forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:34 * ViewRateBaseOnIP6]];
            [button setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
            [button setFrame:CGRectMake(0,  buttonH * i, buttonW, buttonH)];
            [button addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame), buttonW, 1)];
            [separatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
            
            [_contentScrollerView addSubview:button];
            [_contentScrollerView addSubview:separatorLine];
        }
    }
    return self;
}

#pragma mark - Action Method

- (void)clickSelectButton:(UIButton *)button
{
    self.confirmblock(self,button.titleLabel.text);
    [self removeFromSuperview];
}

- (void)exit
{
    [self removeFromSuperview];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if () {
//        <#statements#>
//    }
//    [self removeFromSuperview];
//}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
