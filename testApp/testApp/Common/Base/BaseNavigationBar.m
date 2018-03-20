//
//  BaseNavigationBar.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseNavigationBar.h"

@interface BaseNavigationBar()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *finishBtn;
@end

@implementation BaseNavigationBar

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, kNavMargan + 20, SCREEN_WIDTH, 44);
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self addSubview:cancelBtn];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pressCancelBtn) forControlEvents:UIControlEventTouchUpInside];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, SCREEN_WIDTH - 88, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = COLOR_RGB_255(51, 51, 51);
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];

    self.finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44, 0, 44, 44)];
    [self addSubview:_finishBtn];
    _finishBtn.backgroundColor = [UIColor clearColor];
    [_finishBtn addTarget:self action:@selector(pressFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    _finishBtn.hidden = YES;

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
    line.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [self addSubview:line];

}


- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setFinishBtnImage:(UIImage *)finishBtnImage
{
    _finishBtnImage = finishBtnImage;
    [_finishBtn setImage:finishBtnImage forState:UIControlStateNormal];
    _finishBtn.hidden = NO;
}

- (void)setFinishBtnTitle:(NSString *)finishBtnTitle
{
    _finishBtnTitle = finishBtnTitle;
    [_finishBtn setTitle:finishBtnTitle forState:UIControlStateNormal];
    _finishBtn.hidden = NO;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    self.backgroundColor = backgroundColor;
}

- (void)pressCancelBtn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseNavigationDidPressCancelBtn:)]) {
        [self.delegate baseNavigationDidPressCancelBtn:YES];
    }
}

- (void)pressFinishBtn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseNavigationDidPressCancelBtn:)]) {
        [self.delegate baseNavigationDidPressCancelBtn:NO];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end