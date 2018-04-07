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
@end

@implementation XCUserCaseListCell

#pragma mark - Init Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubVies];
        [_caseNameLabel setText:@"刘某案件..."];
        [_caseProcessLabel setText:@"处理中"];
        [_caseTimeLabel setText:@"2018-01-01 11:11:09"];
        [_detailLabel setText:@"查看详情"];

    }
    return self;
}

- (void)configSubVies
{
    _leftLine = [[UIView alloc] init];
    [_leftLine setBackgroundColor:[UIColor blueColor]];
    
    _caseNameLabel = [self createLabelWithTextFontSize:30 textColor:COLOR_RGB_255(51, 51, 51)];
    _caseProcessLabel = [self createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(253, 161, 0)];
    _caseTimeLabel = [self createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(51, 51, 51)];
    _detailLabel = [self createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(51, 51, 51)];
    UIImage *nextImage = [UIImage imageNamed:@"返回拷贝10"];
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
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [_leftLine setFrame:CGRectMake(leftMargin , 30 * ViewRateBaseOnIP6 , 2, 35 * ViewRateBaseOnIP6)];
    [_bottomLine setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1)];
    
    [_caseNameLabel sizeToFit];
    CGSize labelSize = _caseNameLabel.frame.size;
    [_caseNameLabel setFrame:CGRectMake(CGRectGetMaxX(_leftLine.frame) + leftMargin , _leftLine.frame.origin.y, labelSize.width, labelSize.height)];

    [_caseProcessLabel sizeToFit];
    labelSize = _caseProcessLabel.frame.size;
    CGFloat rigthMargin = 30 *ViewRateBaseOnIP6;
    [_caseProcessLabel setFrame:CGRectMake(SCREEN_WIDTH - rigthMargin - labelSize.width , _caseNameLabel.frame.origin.y , labelSize.width, labelSize.height)];
    
    [_caseTimeLabel sizeToFit];
    labelSize = _caseTimeLabel.frame.size;
    [_caseTimeLabel setFrame:CGRectMake(_caseNameLabel.frame.origin.x,CGRectGetMaxY(_caseNameLabel.frame) + 30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
    CGFloat imageW = 40 * ViewRateBaseOnIP6;
    [_nextImageView setFrame:CGRectMake(SCREEN_WIDTH - rigthMargin - imageW, _caseTimeLabel.frame.origin.y, imageW, imageW)];
    
    [_detailLabel sizeToFit];
    labelSize = _detailLabel.frame.size;
    [_detailLabel setFrame:CGRectMake(CGRectGetMinX(_nextImageView.frame) - leftMargin - labelSize.width, _caseTimeLabel.frame.origin.y, labelSize.width, labelSize.height)];
    
}

#pragma mark - Action Method

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