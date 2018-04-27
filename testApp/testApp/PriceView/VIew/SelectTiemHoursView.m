//
//  SelectTiemHoursView.m
//  testApp
//
//  Created by 严玉鑫 on 2018/4/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "SelectTiemHoursView.h"
@interface SelectTiemHoursView()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hoursIndex;
    UIView *topView;
    UIButton *yesBtn;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *hoursArray;

@end
@implementation SelectTiemHoursView

- (NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
        for (int year = 1800; year < 2100; year++) {
            NSString *str = [NSString stringWithFormat:@"%d年",year];
            [_yearArray addObject:str];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray{
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
        for (int month = 1; month <= 12; month++) {
            NSString *str = [NSString stringWithFormat:@"%02d月",month];
            [_monthArray addObject:str];
        }
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    
    if (_dayArray == nil) {
        
        _dayArray = [NSMutableArray array];
        
        for (int day = 1; day <= 31; day++) {
            
            NSString *str = [NSString stringWithFormat:@"%02d日", day];
            
            [_dayArray addObject:str];
        }
    }
    
    return _dayArray;
}

- (NSMutableArray *)hoursArray{
    if (!_hoursArray) {
        _hoursArray = [NSMutableArray array];
        for (int hours = 1; hours <= 24; hours ++) {
            NSString *str = [NSString stringWithFormat:@"%02d时",hours];
            [_hoursArray addObject:str];
        }
    }
    return _hoursArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 546 * ViewRateBaseOnIP6, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6)];
        topView.backgroundColor = RGBACOLOR(242, 242, 242, 1.0);
        [self addSubview:topView];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(25 * ViewRateBaseOnIP6, 0, 72 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:32*ViewRateBaseOnIP6]];
        [topView addSubview:cancelBtn];
        
        yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(SCREEN_WIDTH - 97 * ViewRateBaseOnIP6, 0,72 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
        [yesBtn.titleLabel setFont:[UIFont systemFontOfSize:32*ViewRateBaseOnIP6]] ;
        [topView addSubview:yesBtn];
        
        [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchDown];
        [yesBtn addTarget:self action:@selector(clickYes:) forControlEvents:UIControlEventTouchDown];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(325 * ViewRateBaseOnIP6, 26 * ViewRateBaseOnIP6, 120 * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6)];
        label.text = @"请选择";
        label.textColor = [UIColor colorWithHexString:@"#444444"];
        label.font = [UIFont systemFontOfSize:34 * ViewRateBaseOnIP6];
        [topView addSubview:label];
        
        //        [self click:^(UIView *view) {
        //
        //            if (_block) {
        //                _block(nil);
        //            }
        //            [self remove];
        //        }];
        
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 466 * ViewRateBaseOnIP6, SCREEN_WIDTH, 466 * ViewRateBaseOnIP6)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
        
        yearIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", comp.year]];
        monthIndex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", comp.month]];
        dayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", comp.day]];
        hoursIndex = [self.hoursArray indexOfObject:[NSString stringWithFormat:@"%02ld时",comp.hour]];
        
        [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [_pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [_pickerView selectRow:dayIndex inComponent:2 animated:YES];
        [_pickerView selectRow:hoursIndex inComponent:3 animated:YES];
        
        [self pickerView:_pickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:monthIndex inComponent:1];
        [self pickerView:_pickerView didSelectRow:dayIndex inComponent:2];
        [self pickerView:_pickerView didSelectRow:hoursIndex inComponent:3];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIButton *button = (UIButton *)[_pickerView viewForRow:yearIndex forComponent:0];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
            button = (UIButton *)[_pickerView viewForRow:monthIndex forComponent:1];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
            button = (UIButton *)[_pickerView viewForRow:dayIndex forComponent:2];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
            button = (UIButton *)[_pickerView viewForRow:hoursIndex forComponent:3];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
        
        [UIView animateWithDuration:0.25 animations:^{
            
            topView.frame = CGRectMake(0, SCREEN_HEIGHT - 546 * ViewRateBaseOnIP6, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6);
            _pickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 466 * ViewRateBaseOnIP6, SCREEN_WIDTH, 466 * ViewRateBaseOnIP6);
        }];
        
    }
    return self;
}

- (void)clickCancel:(UIButton *)button{
    if (_block) {
        _block(nil);
    }
    
    [self remove];
}

- (void)clickYes:(UIButton *)button{
    if (_block) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%@%@%@%@",((UIButton *)[_pickerView viewForRow:yearIndex forComponent:0]).titleLabel.text, ((UIButton *)[_pickerView viewForRow:monthIndex forComponent:1]).titleLabel.text, ((UIButton *)[_pickerView viewForRow:dayIndex forComponent:2]).titleLabel.text,((UIButton *)[_pickerView viewForRow:hoursIndex forComponent:3]).titleLabel.text];
        
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@"-"];
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"时" withString:@""];
        
        _block(timeStr);
        
    }
    [self remove];
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
        
    }else if(component == 1) {
        
        return self.monthArray.count;
        
    }else if (component == 2){
        
        switch (monthIndex + 1) {
                
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31;
                
            case 4:
            case 6:
            case 9:
            case 11: return 30;
                
            default: return 28;
        }
    } else {
        return self.hoursArray.count;
    }
}


- (void)remove {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        topView.frame = CGRectMake(0, SCREEN_HEIGHT - 546 * ViewRateBaseOnIP6, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6);
        _pickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 466 * ViewRateBaseOnIP6, SCREEN_WIDTH, 466 * ViewRateBaseOnIP6);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.hidden = YES;
    }];
    
}
#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        yesBtn.userInteractionEnabled = YES;
    });
    if (component == 0) {
        
        yearIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
        
    }else if (component == 1) {
        
        monthIndex = row;
        
        [pickerView reloadComponent:2];
        
        
        if (monthIndex + 1 == 4 || monthIndex + 1 == 6 || monthIndex + 1 == 9 || monthIndex + 1 == 11) {
            
            if (dayIndex + 1 == 31) {
                
                dayIndex--;
            }
        }else if (monthIndex + 1 == 2) {
            
            if (dayIndex + 1 > 28) {
                dayIndex = 27;
            }
        }
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
            button = (UIButton *)[pickerView viewForRow:dayIndex forComponent:2];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
    }else if(component == 2) {
        
        dayIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
    } else {
        hoursIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 88 * ViewRateBaseOnIP6;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        yesBtn.userInteractionEnabled = NO;
    });
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
        }
    }
    
    //设置文字的属性
    UIButton *genderLabel = [[UIButton alloc] init];
    [genderLabel setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
    [genderLabel.titleLabel setFont:[UIFont systemFontOfSize:28 * ViewRateBaseOnIP6]];
    
    
    if (component == 0) {
        [genderLabel setTitle:self.yearArray[row] forState:UIControlStateNormal];

        
    }else if (component == 1) {
        [genderLabel setTitle:self.monthArray[row] forState:UIControlStateNormal];
        
    }else if(component == 2){
        [genderLabel setTitle:self.dayArray[row] forState:UIControlStateNormal];

    } else {
        [genderLabel setTitle:self.hoursArray[row] forState:UIControlStateNormal];

    }
    
    return genderLabel;
}


@end
