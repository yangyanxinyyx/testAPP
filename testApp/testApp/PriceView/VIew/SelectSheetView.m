//
//  SelectSheetView.m
//  案列
//
//  Created by admin on 29/3/18.
//  Copyright © 2018年 Yanyx. All rights reserved.
//

#import "SelectSheetView.h"

@interface SelectSheetView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) NSMutableArray *arrayAction;
@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, strong) UIButton *buttonCancle;
@property (nonatomic, strong) NSMutableArray *dataArr ;
@end

@implementation SelectSheetView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self addSubview:self.touchView];
    }
    return self;
}
- (void)setDataWithDataArray:(NSArray<NSString *> *)dataArray{
    if (!dataArray) {
        return;
    }
    
    if (dataArray.count == 0) {
        return;
    } else {
        if (self.dataArr.count == 0) {
            for (int i = 0; i < dataArray.count; i++) {
                [self.dataArr addObject:dataArray[dataArray.count - i - 1]];
            }
        }
        
    }
    if (self.topView) {
        for (UIView * view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < self.dataArr.count; i++) {
        UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80*ViewRateBaseOnIP6*(i+1),SCREEN_WIDTH , 80 * ViewRateBaseOnIP6)];
        UILabel *labeltext = [[UILabel alloc] initWithFrame:CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, SCREEN_WIDTH - 60 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6)];
        labeltext.text = self.dataArr[i];
        labeltext.textColor = [UIColor colorWithHexString:@"#444444"];
        labeltext.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
        labeltext.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:labeltext];
        labeltext.backgroundColor = [UIColor clearColor];
        cell.tag = i;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestCell:)];
        [cell addGestureRecognizer:tapGest];
        [self addSubview:cell];
        cell.backgroundColor = [UIColor whiteColor];
        UILabel *labelSegement = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
        labelSegement.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [cell addSubview:labelSegement];
    }
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - (80*ViewRateBaseOnIP6 * dataArray.count+88*ViewRateBaseOnIP6), SCREEN_WIDTH, 88 * ViewRateBaseOnIP6)];
    UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(325 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6)];
    labelText.font = [UIFont systemFontOfSize:32 * ViewRateBaseOnIP6];
    labelText.text = @"请选择";
    [self.topView setBackgroundColor:[UIColor whiteColor]];
    [self.topView addSubview:labelText];
    [self.topView addSubview:self.buttonCancle];
    [self addSubview:self.topView];
    self.touchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (80*ViewRateBaseOnIP6 * dataArray.count+88 * ViewRateBaseOnIP6));
}

- (void)tapGestCell:(UITapGestureRecognizer *)tapGest{
    UIView *view = tapGest.view;
    NSLog(@"%ld",view.tag);
    if (_block) {
        _block(self.dataArr.count - view.tag - 1);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = YES;
    }];
    
}
- (UIView *)touchView{
    if (!_touchView) {
        _touchView = [[UIView alloc] init];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toucheViewHidden:)];
        [_touchView addGestureRecognizer:tapGest];
        [_touchView addGestureRecognizer:tapGest];
    }
    return _touchView;
}
- (void)toucheViewHidden:(UITapGestureRecognizer *)tapGest{
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = YES;
    }];
    
}

- (UIButton *)buttonCancle{
    if (!_buttonCancle) {
        _buttonCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonCancle.frame = CGRectMake(SCREEN_WIDTH - 64 * ViewRateBaseOnIP6, 25 * ViewRateBaseOnIP6 , 34 * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6);
        [_buttonCancle addTarget:self action:@selector(touchCancle:) forControlEvents:UIControlEventTouchDown];
        [_buttonCancle setBackgroundImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    }
    return _buttonCancle;
}
- (void)touchCancle:(UIButton *)button{
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = YES;
    }];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
