//
//  FinishTipsView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "FinishTipsView.h"

@interface FinishTipsView ()
@property (nonatomic,strong) UILabel *tipsLabel;
@end

@implementation FinishTipsView

- (instancetype)initWithTitle:(NSString *)title superView:(UIView *)superView;
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self createUI];
        self.tipsLabel.text = title;
        [superView addSubview:self];
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor clearColor];

    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200 * kScaleWidth, 90 * kScaleWidth)];
    _tipsLabel.center = self.center;
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.backgroundColor = [UIColor whiteColor];
    _tipsLabel.layer.cornerRadius = 5;
    _tipsLabel.layer.masksToBounds = YES;
    _tipsLabel.backgroundColor = COLOR_RGBA_255(0, 0, 0, 0.6);
    _tipsLabel.font = [UIFont systemFontOfSize:18];
    _tipsLabel.textColor = [UIColor whiteColor];
    [self addSubview:_tipsLabel];


    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);

    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeFromSuperview];

    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
