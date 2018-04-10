//
//  XCMyCommissionListCell.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionListCell.h"
#import "NSString+MoneyString.h"
@interface XCMyCommissionListCell ()

/** 时间View */
@property (nonatomic, strong) UIView * timeView ;
/** 时间Label  */
@property (nonatomic, strong) UILabel * createTimeLable ;

/** 车险业绩View */
@property (nonatomic, strong) UIView * carListView ;
/** 车险业绩Label */
@property (nonatomic, strong) UILabel * carPerformaceLabel ;
/** 车险业绩数额Label */
@property (nonatomic, strong) UILabel * carPerformaceValueLabel ;
/** 车险佣金Label */
@property (nonatomic, strong) UILabel * carCommissionLable ;
/** 车险佣金数额Label */
@property (nonatomic, strong) UILabel * carCommissionValueLabel ;
/** 车险提成Label */
@property (nonatomic, strong) UILabel * carRoyaltiesLabel ;
/** 车险提成数额Label */
@property (nonatomic, strong) UILabel * carRoyaltiesValueLabel ;

/** 维修业绩View */
@property (nonatomic, strong) UIView * serviceListView ;
/** 维修业绩Label */
@property (nonatomic, strong) UILabel * servicePerformanceLabel ;
/** 维修业绩数额Label */
@property (nonatomic, strong) UILabel * servicePerformanceValueLabel ;
/** 维修佣金Label */
@property (nonatomic, strong) UILabel * serviceCommissionLabel ;
/** 维修佣金数额Label */
@property (nonatomic, strong) UILabel * serviceCommissionValueLabel ;

/** 勋章View */
@property (nonatomic, strong) UIView * medalBonusView ;
/** 勋章奖金Label */
@property (nonatomic, strong) UILabel * medalBonusLabel ;
/** 勋章奖金数额Label */
@property (nonatomic, strong) UILabel * medalBonusValueLable;

@end

@implementation XCMyCommissionListCell

#pragma mark - Init Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
        [self configSubVies];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewOfLeftMargin = 45 * ViewRateBaseOnIP6;
    CGFloat viewOfWidth = 660 * ViewRateBaseOnIP6;
    CGFloat labelOfLeftMargin = 30 * ViewRateBaseOnIP6;
    
    [_timeView setFrame:CGRectMake(viewOfLeftMargin, 0, viewOfWidth,kcellForTimeViewH)];
    CGSize labelSize;
    [_createTimeLable sizeToFit];
    labelSize = _createTimeLable.frame.size;
    [_createTimeLable setFrame:CGRectMake(labelOfLeftMargin, (_timeView.frame.size.height - labelSize.height) * 0.5, labelSize.width, labelSize.height)];
    
#warning 216待定，等新的UI图出现知道
    //车险业绩
    [_carListView setFrame:CGRectMake(viewOfLeftMargin, CGRectGetMaxY(_timeView.frame),viewOfWidth,kcellForCarListViewH)];
    [self setBorderWithView:_carListView top:YES left:NO bottom:YES right:NO borderColor:COLOR_RGB_255(242, 242, 242) borderWidth:1];
    
    [_carPerformaceLabel sizeToFit];
    labelSize = _carPerformaceLabel.frame.size;
    [_carPerformaceLabel setFrame:CGRectMake(labelOfLeftMargin, 30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_carPerformaceValueLabel sizeToFit];
    labelSize = _carPerformaceValueLabel.frame.size;
    [_carPerformaceValueLabel setFrame:CGRectMake(_carListView.frame.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, _carPerformaceLabel.frame.origin.y, labelSize.width, labelSize.height)];

    [_carCommissionLable sizeToFit];
    labelSize = _carCommissionLable.frame.size;
    [_carCommissionLable setFrame:CGRectMake(labelOfLeftMargin, CGRectGetMaxY(_carPerformaceLabel.frame) +  30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_carCommissionValueLabel sizeToFit];
    labelSize = _carCommissionValueLabel.frame.size;
    [_carCommissionValueLabel setFrame:CGRectMake(_carListView.frame.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, _carCommissionLable.frame.origin.y, labelSize.width, labelSize.height)];
    
    [_carRoyaltiesLabel sizeToFit];
    labelSize = _carRoyaltiesLabel.frame.size;
    [_carRoyaltiesLabel setFrame:CGRectMake(labelOfLeftMargin,CGRectGetMaxY(_carCommissionLable.frame) + 30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_carRoyaltiesValueLabel sizeToFit];
    labelSize = _carRoyaltiesValueLabel.frame.size;
    [_carRoyaltiesValueLabel setFrame:CGRectMake(_carListView.frame.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, _carRoyaltiesLabel.frame.origin.y, labelSize.width, labelSize.height)];
    
    // 维修业绩
    [_serviceListView setFrame:CGRectMake(viewOfLeftMargin, CGRectGetMaxY(_carListView.frame), viewOfWidth,kcellForServiceListViewH)];
    [self setBorderWithView:_serviceListView top:NO left:NO bottom:YES right:NO borderColor:COLOR_RGB_255(242, 242, 242) borderWidth:1];
    
    [_servicePerformanceLabel sizeToFit];
    labelSize = _servicePerformanceLabel.frame.size;
    [_servicePerformanceLabel setFrame:CGRectMake(labelOfLeftMargin, 30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_servicePerformanceValueLabel sizeToFit];
    labelSize = _servicePerformanceValueLabel.frame.size;
    [_servicePerformanceValueLabel setFrame:CGRectMake(_carListView.frame.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, _servicePerformanceLabel.frame.origin.y, labelSize.width, labelSize.height)];
    
    [_serviceCommissionLabel sizeToFit];
    labelSize = _serviceCommissionLabel.frame.size;
    [_serviceCommissionLabel setFrame:CGRectMake(labelOfLeftMargin, CGRectGetMaxY(_servicePerformanceLabel.frame) +  30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_serviceCommissionValueLabel sizeToFit];
    labelSize = _serviceCommissionValueLabel.frame.size;
    [_serviceCommissionValueLabel setFrame:CGRectMake(_serviceListView.frame.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, _serviceCommissionLabel.frame.origin.y, labelSize.width, labelSize.height)];
    
    //勋章
    [_medalBonusView setFrame:CGRectMake(viewOfLeftMargin, CGRectGetMaxY(_serviceListView.frame), viewOfWidth,kcellForMedalViewH)];
    [_medalBonusLabel sizeToFit];
    labelSize = _medalBonusLabel.frame.size;
    [_medalBonusLabel setFrame:CGRectMake(labelOfLeftMargin, (_medalBonusView.frame.size.height - labelSize.height ) * 0.5  , labelSize.width, labelSize.height)];
    [_medalBonusValueLable sizeToFit];
    labelSize = _medalBonusValueLable.frame.size;
   [_medalBonusValueLable setFrame:CGRectMake(_medalBonusView.frame.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, _medalBonusLabel.frame.origin.y, labelSize.width, labelSize.height)];
    
}

- (void)configSubVies
{
    UIColor *fontColor = COLOR_RGB_255(68, 68, 68);
    UIColor *orangeColor = COLOR_RGB_255(0, 77, 162);
    
    _timeView = [[UIView alloc] init];
    [_timeView setBackgroundColor:COLOR_RGB_255(255, 255, 255)];
    _createTimeLable = [self createTextLabelWithTitleColor:COLOR_RGB_255(165, 165, 165) FontSize:24 title:@"2018年02月"];
    
    _carListView = [[UIView alloc] init];
    [_carListView setBackgroundColor:COLOR_RGB_255(255, 255, 255)];
   
    _carPerformaceLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"车险业绩"];
    _carCommissionLable = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"佣金"];
    _carRoyaltiesLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"提成"];
    _carPerformaceValueLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"¥0.00"];
    _carCommissionValueLabel = [self createTextLabelWithTitleColor:orangeColor FontSize:28 title:@"¥0.00"];
    _carRoyaltiesValueLabel = [self createTextLabelWithTitleColor:orangeColor FontSize:28 title:@"¥0.00"];
    
    _serviceListView = [[UIView alloc] init];
    _serviceListView.layer.backgroundColor = COLOR_RGB_255(255, 255, 255).CGColor;
    _servicePerformanceLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"维修业绩"];
    _serviceCommissionLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"佣金"];
    _servicePerformanceValueLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"¥0.00"];
    _serviceCommissionValueLabel = [self createTextLabelWithTitleColor:orangeColor FontSize:28 title:@"¥0.00"];
    
    _medalBonusView = [[UIView alloc] init];
    [_medalBonusView setBackgroundColor:COLOR_RGB_255(255, 255, 255)];
    _medalBonusLabel = [self createTextLabelWithTitleColor:fontColor FontSize:28 title:@"勋章奖金"];
    _medalBonusValueLable = [self createTextLabelWithTitleColor:orangeColor FontSize:28 title:@"¥0.00"];
    
    [self addSubview:_timeView];
    [_timeView addSubview:_createTimeLable];
    [self addSubview:_carListView];
    [_carListView addSubview:_carPerformaceLabel];
    [_carListView addSubview:_carPerformaceValueLabel];
    [_carListView addSubview:_carCommissionLable];
    [_carListView addSubview:_carCommissionValueLabel];
    [_carListView addSubview:_carRoyaltiesLabel];
    [_carListView addSubview:_carRoyaltiesValueLabel];
    [self addSubview:_serviceListView];
    [_serviceListView addSubview:_servicePerformanceLabel];
    [_serviceListView addSubview:_servicePerformanceValueLabel];
    [_serviceListView addSubview:_serviceCommissionLabel];
    [_serviceListView addSubview:_serviceCommissionValueLabel];
    [self addSubview:_medalBonusView];
    [_medalBonusView addSubview:_medalBonusLabel];
    [_medalBonusView addSubview:_medalBonusValueLable];
    
}
#pragma mark - Action Method

- (void)setupCellDataWithModel:(XCMyCommissionListModel *)model
{
    if (!model) {
        return;
    }
    if (![model.createTime isEqualToString:@""]) {
        NSMutableString *timeStrM =[NSMutableString stringWithFormat:@"%@", model.createTime];
        NSArray *timeArr = [timeStrM componentsSeparatedByString:@" "];
        NSMutableString *dataStrM = [NSMutableString stringWithFormat:@"%@",[timeArr firstObject]];
        NSArray *dataArr = [dataStrM componentsSeparatedByString:@"-"];
        if (dataArr.count == 3) {
            NSString *timeString = [NSString stringWithFormat:@"%@年%@月",dataArr[0],dataArr[1]];
        [_createTimeLable setText:timeString];
        }
    }else {
        [_createTimeLable setText:@"未知时间"];
    }
    
    if (model.carPerformance) {
        [_carPerformaceValueLabel setText:[NSString stringWithMoneyNumber:[model.carPerformance floatValue]]];
    }else {
        [_carPerformaceValueLabel setText:@"¥0.00"];
    }
    
    if (model.carCommission) {
        [_carCommissionValueLabel setText:[NSString stringWithMoneyNumber:[model.carCommission floatValue]]];
    }else {
        [_carCommissionValueLabel setText:@"¥0.00"];
    }
    
    if (model.carRoyalties ) {
        [_carRoyaltiesValueLabel setText:[NSString stringWithMoneyNumber:[model.carRoyalties floatValue]]];
    }else {
        [_carRoyaltiesValueLabel setText:@"¥0.00"];
    }
    
    if (model.servicePerformance) {
        [_servicePerformanceValueLabel setText:[NSString stringWithMoneyNumber:[model.servicePerformance floatValue]]];
    }else {
        [_servicePerformanceValueLabel setText:@"¥0.00"];
    }
    
    if (model.serviceCommission) {
        [_serviceCommissionValueLabel setText:[NSString stringWithMoneyNumber:[model.serviceCommission floatValue]]];
    }else {
        [_serviceCommissionValueLabel setText:@"¥0.00"];
    }
    
    if (model.medalBonus) {
        [_medalBonusValueLable setText:[NSString stringWithMoneyNumber:[model.medalBonus floatValue]]];
    }else {
        [_medalBonusValueLable setText:@"¥0.00"];
    }
    
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (UILabel *)createTextLabelWithTitleColor:(UIColor *)textColor
                                  FontSize:(NSInteger)size
                                     title:(NSString *)title
{
    UILabel * label = [[UILabel alloc] init];
    [label setText:title];
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Medium" size:size * ViewRateBaseOnIP6];
    [label setFont:font];
    [label setTextColor:textColor];
    return label;
}

- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

#pragma mark - Setter&Getter

@end
