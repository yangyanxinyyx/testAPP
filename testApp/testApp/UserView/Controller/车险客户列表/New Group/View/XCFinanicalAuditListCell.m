//
//  XCFinanicalAuditListCell.m
//  testApp
//
//  Created by Melody on 2018/4/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCFinanicalAuditListCell.h"
@interface XCFinanicalAuditListCell()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * leftLine ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * bottomLine ;
@property (nonatomic, strong) UILabel * carNumLabel ;
@property (nonatomic, strong) UILabel * carNameLabel ;
@property (nonatomic, strong) UILabel * processLabel ;
@property (nonatomic, strong) UILabel * timeLabel ;
@property (nonatomic, strong) UILabel * detailLabel ;
@property (nonatomic, strong) UIImageView * nextImageView ;

@property (nonatomic, strong) XCCheckoutDetailBaseModel * model ;


@end
@implementation XCFinanicalAuditListCell

#pragma mark - Init Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configSubVies];
        [_detailLabel setText:@"查看详情"];
        
    }
    return self;
}

- (void)configSubVies
{
    _leftLine = [[UIView alloc] init];
    [_leftLine setBackgroundColor:COLOR_RGB_255(0, 77, 161)];
    
    _carNumLabel = [self createLabelWithTextFontSize:32 textColor:COLOR_RGB_255(68, 68, 68)];
    _carNameLabel = [self createLabelWithTextFontSize:22 textColor:COLOR_RGB_255(131,131,131)];
    _timeLabel = [self createLabelWithTextFontSize:22 textColor:COLOR_RGB_255(131, 131, 131)];
    _detailLabel = [self createLabelWithTextFontSize:22 textColor:COLOR_RGB_255(131, 131, 131)];
    _processLabel = [self createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(0, 77, 161)];

    UIImage *nextImage = [UIImage imageNamed:@"返回拷贝10"];
    _nextImageView = [[UIImageView alloc] initWithImage:nextImage];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    [_bottomLine setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self addSubview:_bottomLine];
    [self addSubview:_leftLine];
    [self addSubview:_carNumLabel];
    [self addSubview:_carNameLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_processLabel];
    [self addSubview:_detailLabel];
    [self addSubview:_nextImageView];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [_leftLine setFrame:CGRectMake(leftMargin , 30 * ViewRateBaseOnIP6 , 2, 35 * ViewRateBaseOnIP6)];
    [_bottomLine setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1)];
    
    [_carNumLabel sizeToFit];
    CGSize labelSize = _carNumLabel.frame.size;
    [_carNumLabel setFrame:CGRectMake(CGRectGetMaxX(_leftLine.frame) + leftMargin , _leftLine.frame.origin.y, 380 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6)];
    
    [_processLabel sizeToFit];
    labelSize = _processLabel.frame.size;
    CGFloat rigthMargin = 30 *ViewRateBaseOnIP6;
    [_processLabel setFrame:CGRectMake(SCREEN_WIDTH - rigthMargin - labelSize.width , _carNumLabel.frame.origin.y , labelSize.width, 23 * ViewRateBaseOnIP6)];

    [_carNameLabel sizeToFit];
    labelSize = _carNameLabel.frame.size;
    [_carNameLabel setFrame:CGRectMake(_carNumLabel.frame.origin.x,CGRectGetMaxY(_carNumLabel.frame) + 30 * ViewRateBaseOnIP6, labelSize.width, 21 * ViewRateBaseOnIP6)];
    
    [_timeLabel sizeToFit];
    labelSize = _timeLabel.frame.size;
    [_timeLabel setFrame:CGRectMake(_carNameLabel.frame.origin.x,CGRectGetMaxY(_carNameLabel.frame) + 20 * ViewRateBaseOnIP6, labelSize.width, 22 * ViewRateBaseOnIP6)];
    
    CGFloat imageW = 14 * ViewRateBaseOnIP6;
    CGFloat imageH = 27 * ViewRateBaseOnIP6;
    
    [_nextImageView setFrame:CGRectMake(SCREEN_WIDTH - rigthMargin - imageW, 119 * ViewRateBaseOnIP6, imageW, imageH)];
    
    [_detailLabel sizeToFit];
    labelSize = _detailLabel.frame.size;
    [_detailLabel setFrame:CGRectMake(CGRectGetMinX(_nextImageView.frame) - leftMargin - labelSize.width, 122 * ViewRateBaseOnIP6, labelSize.width, 21 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method

- (void)setupCellWithCaseListModel:(XCCheckoutDetailBaseModel *)model 
{
    _model = model;
    
    if (isUsableNSString(model.plateNo, @"")) {
        [_carNumLabel setText:[NSString stringWithFormat:@"%@",model.plateNo]];
    }else {
        [_carNumLabel setText:@" "];
    }
    if(isUsableNSString(model.onwerName, @"")) {
        [_carNameLabel setText:[NSString stringWithFormat:@"车主: %@",model.onwerName]];
    }else {
        [_carNameLabel setText:@"车主:  "];
    }

    if ([self.typeStr isEqualToString:@"配送"]) {
        if (isUsableNSString(model.policyStatus, @"")) {
            [_processLabel setText:model.policyStatus];
        }else {
            [_processLabel setText:@" "];
        }
        if (isUsableNSString(model.createTime,@"")) {
            NSMutableString *tmpDate = [NSMutableString stringWithString:model.createTime];
            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_timeLabel setText:[NSString stringWithFormat:@"配送时间: %@",[tmpArr firstObject]]];
        }else {
            [_timeLabel setText:@"配送时间:  "];
        }
    }else if ([self.typeStr isEqualToString:@"财务审核"]) {
        if (isUsableNSString(model.financeRemark, @"出纳审核通过")) {
            [_processLabel setText:@"完成"];
            [_processLabel setTextColor:COLOR_RGB_255(131, 131, 131)];
        }else {
            [_processLabel setText:model.financeRemark];
            [_processLabel setTextColor:COLOR_RGB_255(0, 77, 161)];
        }
        if (isUsableNSString(model.createTime,@"")) {
            NSMutableString *tmpDate = [NSMutableString stringWithString:model.createTime];
            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_timeLabel setText:[NSString stringWithFormat:@"创建时间: %@",[tmpArr firstObject]]];
        }else {
            [_timeLabel setText:@"创建时间:  "];
        }
    }
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method
- (UILabel *)createLabelWithTextFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:fontSize * ViewRateBaseOnIP6]];
    [label setTextColor:textColor];
    return label;
}


#pragma mark - Setter&Getter
@end
