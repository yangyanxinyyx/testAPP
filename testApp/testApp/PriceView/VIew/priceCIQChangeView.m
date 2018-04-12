//
//  priceCIQChangeView.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "priceCIQChangeView.h"
@interface priceCIQChangeView()
{
    BOOL isLaseY;
}
@property (nonatomic, strong) UIButton *buttonLastY;
@property (nonatomic, strong) UIButton *buttonPriceRecord;
@property (nonatomic, strong) UILabel *labelGreen;
@end

@implementation priceCIQChangeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        isLaseY = YES;
        [self addSubview:self.buttonLastY];
        [self addSubview:self.buttonPriceRecord];
        [self addSubview:self.labelGreen];
    }
    return self;
}

- (void)setleftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    [_buttonLastY setTitle:leftTitle forState:UIControlStateNormal];
    [_buttonPriceRecord setTitle:rightTitle forState:UIControlStateNormal];
}

- (UIButton *)buttonLastY{
    if (!_buttonLastY) {
        _buttonLastY = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonLastY.frame = CGRectMake(0, 0, 375 * ViewRateBaseOnIP6, 160 * ViewRateBaseOnIP6);
        _buttonLastY.backgroundColor = [UIColor colorWithHexString:@"#6899e8"];
        [_buttonLastY setTitle:@"上年续保报价" forState:UIControlStateNormal];
        _buttonLastY.titleLabel.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
        [_buttonLastY setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [_buttonLastY addTarget:self action:@selector(toucheButtonLastY:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonLastY;
}


- (UIButton *)buttonPriceRecord{
    if (!_buttonPriceRecord) {
        _buttonPriceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonPriceRecord.frame = CGRectMake(375 * ViewRateBaseOnIP6, 0, 375 * ViewRateBaseOnIP6, 160 * ViewRateBaseOnIP6);
        _buttonPriceRecord.backgroundColor = [UIColor whiteColor];
        _buttonPriceRecord.titleLabel.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
        [_buttonPriceRecord setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
        [_buttonPriceRecord setTitle:@"报价记录" forState:UIControlStateNormal];
        [_buttonPriceRecord addTarget:self action:@selector(touchButtoRecord:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonPriceRecord;
}

- (UILabel *)labelGreen{
    if (!_labelGreen) {
        _labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(0, 154 * ViewRateBaseOnIP6, SCREEN_WIDTH / 2, 6 * ViewRateBaseOnIP6)];
        _labelGreen.backgroundColor = [UIColor colorWithHexString:@"#4ff0b2"];
    }
    return _labelGreen;
}
- (void)toucheButtonLastY:(UIButton *)button{
    _buttonLastY.backgroundColor = [UIColor colorWithHexString:@"#6899e8"];
    [_buttonLastY setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    _buttonPriceRecord.backgroundColor = [UIColor whiteColor];
    [_buttonPriceRecord setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _labelGreen.frame = CGRectMake(0, 154 * ViewRateBaseOnIP6, SCREEN_WIDTH / 2, 6 * ViewRateBaseOnIP6);
    isLaseY = YES;
    [self.delegate changeModel:isLaseY];
}

- (void)touchButtoRecord:(UIButton *)button{
    _buttonPriceRecord.backgroundColor = [UIColor colorWithHexString:@"#6899e8"];
    [_buttonPriceRecord setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    _buttonLastY.backgroundColor = [UIColor whiteColor];
    [_buttonLastY setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _labelGreen.frame = CGRectMake(SCREEN_WIDTH / 2, 154 * ViewRateBaseOnIP6, SCREEN_WIDTH / 2, 6 * ViewRateBaseOnIP6);
    isLaseY = NO;
    [self.delegate changeModel:isLaseY];
}
@end
