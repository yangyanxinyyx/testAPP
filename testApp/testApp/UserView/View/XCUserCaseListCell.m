//
//  XCUserCaseListCell.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseListCell.h"

@interface XCUserCaseListCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * leftLine ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * bottomLine ;
@property (nonatomic, strong) UILabel * caseNameLabel ;
@property (nonatomic, strong) UILabel * caseProcessLabel ;
@property (nonatomic, strong) UILabel * caseTimeLabel ;
@property (nonatomic, strong) UILabel * detailLabel ;
@property (nonatomic, strong) UIImageView * nextImageView ;
@property (nonatomic, strong) UILabel * carNameLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) XCUserCaseListModel * model ;
@end

@implementation XCUserCaseListCell

+ (CGFloat)getCaseListCellHeight
{
    return 180 * ViewRateBaseOnIP6;
}
#pragma mark - Init Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configSubVies];
        [_caseNameLabel setText:@""];
        [_caseProcessLabel setText:@""];
        [_caseTimeLabel setText:@""];
        [_detailLabel setText:@"查看详情"];

    }
    return self;
}

- (void)configSubVies
{
    _leftLine = [[UIView alloc] init];
    [_leftLine setBackgroundColor:COLOR_RGB_255(0, 77, 161)];
    
    _caseNameLabel = [self createLabelWithTextFontSize:32 textColor:COLOR_RGB_255(68, 68, 68)];
    _caseProcessLabel = [self createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(0, 77, 161)];
    _caseTimeLabel = [self createLabelWithTextFontSize:22 textColor:COLOR_RGB_255(131, 131, 131)];
    _detailLabel = [self createLabelWithTextFontSize:21 textColor:COLOR_RGB_255(131, 131, 131)];
    _carNameLabel = [self createLabelWithTextFontSize:22 textColor:COLOR_RGB_255(131, 131, 131)];
    UIImage *nextImage = [UIImage imageNamed:@"next"];
    _nextImageView = [[UIImageView alloc] initWithImage:nextImage];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    [_bottomLine setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self addSubview:_bottomLine];
    [self addSubview:_leftLine];
    [self addSubview:_caseNameLabel];
    [self addSubview:_caseProcessLabel];
    [self addSubview:_caseTimeLabel];
    [self addSubview:_detailLabel];
    [self addSubview:_nextImageView];
    [self addSubview:_carNameLabel];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 28 * ViewRateBaseOnIP6;
    [_leftLine setFrame:CGRectMake(leftMargin , 28 * ViewRateBaseOnIP6 , 4 * ViewRateBaseOnIP6, 36 * ViewRateBaseOnIP6)];
    [_bottomLine setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1)];
    
    [_caseNameLabel sizeToFit];
    CGSize labelSize = _caseNameLabel.frame.size;
    [_caseNameLabel setFrame:CGRectMake(CGRectGetMaxX(_leftLine.frame) + 22 * ViewRateBaseOnIP6  , 31 * ViewRateBaseOnIP6, 380 * ViewRateBaseOnIP6, 29 * ViewRateBaseOnIP6)];

    [_caseProcessLabel sizeToFit];
    labelSize = _caseProcessLabel.frame.size;
    CGFloat rigthMargin = 30 *ViewRateBaseOnIP6;
    [_caseProcessLabel setFrame:CGRectMake(SCREEN_WIDTH - rigthMargin - labelSize.width , 35 * ViewRateBaseOnIP6 , labelSize.width, 22 * ViewRateBaseOnIP6)];
    [_caseProcessLabel setTextColor:COLOR_RGB_255(0, 77, 161)];
    if ([_caseProcessLabel.text isEqualToString:@"处理完毕"]) {
        [_caseProcessLabel setTextColor:COLOR_RGB_255(9, 187, 7)];
    }
    
    [_carNameLabel sizeToFit];
    labelSize = _carNameLabel.frame.size;
    [_carNameLabel setFrame:CGRectMake(_caseNameLabel.frame.origin.x, CGRectGetMaxY(_caseNameLabel.frame) + 32 * ViewRateBaseOnIP6, labelSize.width, 21 * ViewRateBaseOnIP6)];
    
    [_caseTimeLabel sizeToFit];
    labelSize = _caseTimeLabel.frame.size;
    [_caseTimeLabel setFrame:CGRectMake(_caseNameLabel.frame.origin.x,CGRectGetMaxY(_carNameLabel.frame) + 20 * ViewRateBaseOnIP6, labelSize.width, 21 * ViewRateBaseOnIP6)];
    
    CGFloat imageW = 14 * ViewRateBaseOnIP6;
    CGFloat imageH = 27 * ViewRateBaseOnIP6;

    [_nextImageView setFrame:CGRectMake(SCREEN_WIDTH - rigthMargin - imageW, 119 * ViewRateBaseOnIP6, imageW, imageH)];
    
    [_detailLabel sizeToFit];
    labelSize = _detailLabel.frame.size;
    [_detailLabel setFrame:CGRectMake(CGRectGetMinX(_nextImageView.frame) - leftMargin - labelSize.width, 122 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
}

#pragma mark - Action Method

- (void)setupCellWithCaseListModel:(XCUserCaseListModel *)model caseTypeStr:(NSString *)caseTypeStr
{
    _model = model;
    
    if (isUsableNSString(model.customerName, @"")) {
        [_caseNameLabel setText:model.customerName];
    }else {
        [_caseNameLabel setText:@""];
    }
    if(isUsableNSString(model.status, @"")) {
        [_caseProcessLabel setText:model.status];
    }else {
        [_caseProcessLabel setText:@" "];
    }
    if (isUsableNSString(model.occurTime, @"")) {
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.occurTime];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
        [_caseTimeLabel setText:[NSString stringWithFormat:@"案发时间: %@",model.occurTime]];
    }else {
        [_caseTimeLabel setText:@" "];
    }
    if (isUsableNSString(model.plateNo, @"")) {
        [_carNameLabel setText:[NSString stringWithFormat:@"车 牌 号 : %@",model.plateNo]];
    }else {
        [_carNameLabel setText:[NSString stringWithFormat:@"车 牌 号 : "]];
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
