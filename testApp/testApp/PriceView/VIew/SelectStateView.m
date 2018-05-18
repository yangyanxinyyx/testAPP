//
//  SelectStateView.m
//  testApp
//
//  Created by 严玉鑫 on 2018/4/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "SelectStateView.h"
@interface SelectStateView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *topView;
    NSInteger pickerRow;
}
@property (nonatomic, strong) UIView *conteView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, copy) void (^sureCallback)(NSString *content);
@end
@implementation SelectStateView
- (instancetype)initWithFrame:(CGRect)frame datArray:(NSArray *)dataArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _content = [dataArray firstObject];
        pickerRow = 0;
        [self.arrayData addObjectsFromArray:dataArray];
        _conteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 546 * ViewRateBaseOnIP6, SCREEN_WIDTH, 546 * ViewRateBaseOnIP6)];
        [self addSubview:_conteView];
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6)];
        topView.backgroundColor = RGBACOLOR(242, 242, 242, 1.0);
        [_conteView addSubview:topView];
        
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
        [_conteView addSubview:self.pickerView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                     datArray:(NSArray *)dataArray
                    indexName:(NSString *)indexName
        WithCompletionHandler:(void (^)(NSString *))complete
{
    if (self = [self initWithFrame:frame datArray:dataArray WithCompletionHandler:complete]) {
        
        NSUInteger  index = 0;
        if (dataArray.count > 0) {
            for (int p =  0 ; p < dataArray.count; p++) {
                NSString * itemName = dataArray[p];
                NSMutableString *tmpStr = [NSMutableString stringWithString:itemName];
                NSMutableString *selectTmpStr = [NSMutableString stringWithString:indexName];
               
                itemName = [tmpStr stringByReplacingOccurrencesOfString:@"市" withString:@""];
                 NSString * searchName  = [selectTmpStr stringByReplacingOccurrencesOfString:@"市" withString:@""];
                if ([searchName isEqualToString:itemName]) {
                    index = p;
                }
            }
        }
        [_pickerView selectRow:index inComponent:0 animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel *label = (UILabel *)[_pickerView viewForRow:index forComponent:0];
            label.textColor = [UIColor colorWithHexString:@"4494f0"];
            [label setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame datArray:(NSArray *)dataArray WithCompletionHandler:(void (^)(NSString *))complete
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _content = [dataArray firstObject];
        pickerRow = 0;
        [self.arrayData addObjectsFromArray:dataArray];
        _conteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 546 * ViewRateBaseOnIP6, SCREEN_WIDTH, 546 * ViewRateBaseOnIP6)];
        [self addSubview:_conteView];
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6)];
        topView.backgroundColor = RGBACOLOR(242, 242, 242, 1.0);
        [_conteView addSubview:topView];

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
        [_conteView addSubview:self.pickerView];
        self.sureCallback = complete;
    }
    return self;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 88 * ViewRateBaseOnIP6, SCREEN_WIDTH, 458 * ViewRateBaseOnIP6)];
        
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        _pickerView.delegate = self;
        
        _pickerView.dataSource = self;
        
        [self addSubview:_pickerView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[_pickerView viewForRow:0 forComponent:0];
            label.textColor = [UIColor colorWithHexString:@"4494f0"];
            [label setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
            
        });
        [_pickerView reloadAllComponents];//刷新UIPickerView
        
    }
    return _pickerView;
}

- (NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

- (void)clickCancel:(UIButton *)button{
    [self removeFromSuperview];
}

- (void)clickYes:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCell:count:priceCount:)]) {
        [self.delegate didSelectCell:_content count:self.tag priceCount:pickerRow];
    }

    if (self.sureCallback) {
        self.sureCallback(_content);
    }
    [self removeFromSuperview];
}

//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrayData.count;
}

//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return  88 * ViewRateBaseOnIP6;
    
}

//返回指定列的宽度

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return SCREEN_WIDTH;
    
}



// 自定义指定列的每行的视图，即指定列的每行的视图行为一致

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
  
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6)];
    text.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
    text.textAlignment = NSTextAlignmentCenter;
    text.textColor = [UIColor colorWithHexString:@"cccccc"];
    text.text = [_arrayData objectAtIndex:row];
    
    //隐藏上下直线
    
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    
    return text;
    
}

//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_arrayData objectAtIndex:row];
    
    return str;
    
}

//显示的标题字体、颜色等属性

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_arrayData objectAtIndex:row];
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    
    
    return AttributedString;
    
}//NS_AVAILABLE_IOS(6_0);



//被选择的行

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        label.textColor = [UIColor colorWithHexString:@"4494f0"];
        [label setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
        
    });
    NSLog(@"HANG%@",[_arrayData objectAtIndex:row]);
    
    _content = [_arrayData objectAtIndex:row];
    pickerRow = row;
    
}

@end
