//
//  SelectTimeView.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "SelectTimeView.h"
@interface SelectTimeView()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    UIView *topView;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@end
@implementation SelectTimeView

- (NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
        for (int year = 2000; year < 2050; year++) {
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
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(SCREEN_WIDTH - 97 * ViewRateBaseOnIP6, 0,72 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
        [yesBtn.titleLabel setFont:[UIFont systemFontOfSize:32*ViewRateBaseOnIP6]] ;
        [topView addSubview:yesBtn];
        
        [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchDown];
        [yesBtn addTarget:self action:@selector(clickYes:) forControlEvents:UIControlEventTouchDown];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(300 * ViewRateBaseOnIP6, 26 * ViewRateBaseOnIP6, 150 * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6)];
        label.text = @"请选择";
        label.textColor = [UIColor colorWithHexString:@"#444444"];
        label.textAlignment = NSTextAlignmentCenter;
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
        
        NSInteger yIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%02ld年", comp.year]];
        NSInteger mIdex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", comp.month]];
        NSInteger dIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", comp.day]];
        
        [_pickerView selectRow:yIndex inComponent:0 animated:YES];
        [_pickerView selectRow:mIdex inComponent:1 animated:YES];
        [_pickerView selectRow:dIndex inComponent:2 animated:YES];
        
        [self pickerView:_pickerView didSelectRow:yIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:mIdex inComponent:1];
        [self pickerView:_pickerView didSelectRow:dIndex inComponent:2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIButton *button = (UIButton *)[_pickerView viewForRow:yearIndex forComponent:0];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
            button = (UIButton *)[_pickerView viewForRow:monthIndex forComponent:1];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
            button = (UIButton *)[_pickerView viewForRow:dayIndex forComponent:2];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
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
        
        NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",((UIButton *)[_pickerView viewForRow:yearIndex forComponent:0]).titleLabel.text, ((UIButton *)[_pickerView viewForRow:monthIndex forComponent:1]).titleLabel.text, ((UIButton *)[_pickerView viewForRow:dayIndex forComponent:2]).titleLabel.text];
        
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
        
        _block(timeStr);
        
    }
    [self remove];
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
        
    }else if(component == 1) {
        
        return self.monthArray.count;
        
    }else {
        
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
    
    NSLog(@"==>zoule");
    if (component == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
        });
        
    }else if (component == 1) {
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            button = (UIButton *)[pickerView viewForRow:dayIndex forComponent:2];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
    }else {
        
//        dayIndex = row;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button = (UIButton *)[pickerView viewForRow:row forComponent:component];
            [button setTitleColor:[UIColor colorWithHexString:@"#4494f0"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
        });
 
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 88 * ViewRateBaseOnIP6;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
  
    //设置文字的属性
    UIButton *genderLabel = [[UIButton alloc] init];
    [genderLabel setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    [genderLabel.titleLabel setFont:[UIFont systemFontOfSize:28 * ViewRateBaseOnIP6]];
    
    if (component == 0) {
        yearIndex = row;
        [genderLabel setTitle:self.yearArray[row] forState:UIControlStateNormal];
        genderLabel.titleEdgeInsets = UIEdgeInsetsMake(0, -80 * ViewRateBaseOnIP6, 0, 0);
        
    }else if (component == 1) {
        monthIndex = row;
        [genderLabel setTitle:self.monthArray[row] forState:UIControlStateNormal];
        
    }else {
        dayIndex = row;
        [genderLabel setTitle:self.dayArray[row] forState:UIControlStateNormal];
        genderLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -120 * ViewRateBaseOnIP6);
    }
    
    return genderLabel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.25 animations:^{
        
        topView.frame = CGRectMake(0, SCREEN_HEIGHT - 546 * ViewRateBaseOnIP6, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6);
        _pickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 466 * ViewRateBaseOnIP6, SCREEN_WIDTH, 466 * ViewRateBaseOnIP6);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.hidden = YES;
    }];
}


@end
