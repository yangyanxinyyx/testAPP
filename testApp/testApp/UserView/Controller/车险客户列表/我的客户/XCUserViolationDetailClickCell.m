//
//  XCUserViolationDetailClickCell.m
//  testApp
//
//  Created by Melody on 2018/4/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserViolationDetailClickCell.h"
#import "UILabel+createLabel.h"
@interface XCUserViolationDetailClickCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topLine ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * middleLine ;
/** 委托状态 */
@property (nonatomic, strong) UILabel * statusLabel ;
/** 提交按钮 */
@property (nonatomic, strong) UIButton * confirmBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) NSArray * titleArr ;
@end

@implementation XCUserViolationDetailClickCell

+ (CGFloat)getCellHeight
{
    return (203+120+10) * ViewRateBaseOnIP6;
}

#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [_topLine setFrame:CGRectMake(0,0, self.bounds.size.width, 10 * ViewRateBaseOnIP6)];
    
    CGSize labelSize;
    for (int i = 0 ; i < _titleArr.count; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:200+i];
        [label sizeToFit];
        labelSize = label.frame.size;
        [label setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_topLine.frame) + 30 *ViewRateBaseOnIP6 + (12 + 26) * ViewRateBaseOnIP6 * i , labelSize.width, 26 * ViewRateBaseOnIP6)];
    }
    UILabel *lastLabel = [self viewWithTag:(200+_titleArr.count -1)];
    
    [_middleLine setFrame:CGRectMake(0, CGRectGetMaxY(lastLabel.frame) + 30 *ViewRateBaseOnIP6, self.bounds.size.width, 1)];
    
    [_statusLabel sizeToFit];
    labelSize = _statusLabel.frame.size;
    [_statusLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_middleLine.frame) + 46 * ViewRateBaseOnIP6, labelSize.width, 27 * ViewRateBaseOnIP6)];
    [_confirmBtn setFrame:CGRectMake(self.bounds.size.width - (240 + 30) * ViewRateBaseOnIP6 , CGRectGetMaxY(_middleLine.frame)+ 25 * ViewRateBaseOnIP6, 240 *ViewRateBaseOnIP6, 70 * ViewRateBaseOnIP6)];
    
    
 
}

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    self.backgroundColor = [UIColor whiteColor];
    
    _topLine = [[UIView alloc] initWithFrame:CGRectZero];
    [_topLine setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    _middleLine = [[UIView alloc] initWithFrame:CGRectZero];
    [_middleLine setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self addSubview:_topLine];
    [self addSubview:_middleLine];
    _titleArr = @[@"违章地点:",@"违章城市:",@"违章分数:",@"违章条款:"];
    
    for (int i = 0 ; i < _titleArr.count; i++) {
        UILabel *label = [UILabel createLabelWithTextFontSize:28 textColor:[UIColor colorWithHexString:@"#888888"]];
        [label setText:_titleArr[i]];
        [label setTag:(200+i)];
        [self addSubview:label];
    }
    _statusLabel = [UILabel createLabelWithTextFontSize:28 textColor:[UIColor colorWithHexString:@"#fda100"]];
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:@"委托办理" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#999999"]
                 forState:UIControlStateSelected];
    [button setBackgroundColor:[UIColor colorWithHexString:@"004da2"]];
    [button addTarget:self action:@selector(clickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
    _confirmBtn = button;
    [self addSubview:_statusLabel];
    [self addSubview:_confirmBtn];

    
}

#pragma mark - Action Method
- (void)clickConfirmButton:(UIButton *)button
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserViolationDetailClickCellClickButton:statusLabel:)]) {
        [self.delegate XCUserViolationDetailClickCellClickButton:button statusLabel:_statusLabel];
    }
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

- (void)setDetailModel:(XCUserViolationDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    NSString *area = @"违章地点: ";
    NSString *city = @"违章城市: ";
    NSString *fen = @"违章分数: 0分";
    NSString *clause = @"违章条款: ";
    if (isUsableNSString(_detailModel.weizhangArea,@"")) {
        area = [NSString stringWithFormat:@"违章地点: %@",_detailModel.weizhangArea];
    }else {
        _detailModel.weizhangArea = @"";
    }
    if (isUsableNSString(_detailModel.weizhangCity,@"")) {
        city = [NSString stringWithFormat:@"违章城市: %@",_detailModel.weizhangCity];
    }else {
        _detailModel.weizhangCity = @"";
    }
    if (isUsable(_detailModel.buckleScores, [NSNumber class])) {
        fen = [NSString stringWithFormat:@"违章分数: %@",[_detailModel.buckleScores stringValue]];
    }else {
        _detailModel.buckleScores = [NSNumber numberWithDouble:0];
    }
    if (isUsableNSString(_detailModel.weizhangClause,@"")) {
        clause = [NSString stringWithFormat:@"违章条款: %@",_detailModel.weizhangClause];
    }else {
        _detailModel.weizhangClause = @"";
    }
    
    NSArray *titleValue = @[area,city,fen,clause];
    
    for (int i = 0 ; i < titleValue.count ; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:200+ i];
        [label setText:titleValue[i]];
    }
    if ([self.detailModel.handled isEqualToString:@"0"]) {
        [_statusLabel setText:@"未处理"];
        _confirmBtn.userInteractionEnabled = YES;
        _confirmBtn.selected = NO;
        [_statusLabel setTextColor:[UIColor colorWithHexString:@"fda100"]];
    }else if ([self.detailModel.handled isEqualToString:@"1"]) {
        [_statusLabel setText:@"已处理"];
        _confirmBtn.userInteractionEnabled = NO;
        _confirmBtn.selected = YES;
        [_statusLabel setTextColor:[UIColor colorWithHexString:@"31bea6"]];
    }else if ([self.detailModel.handled isEqualToString:@"2"]) {
        [_statusLabel setText:@"处理中"];
        _confirmBtn.userInteractionEnabled = NO;
        _confirmBtn.selected = YES;
        [_statusLabel setTextColor:[UIColor colorWithHexString:@"31bea6"]];
    }
}

@end
