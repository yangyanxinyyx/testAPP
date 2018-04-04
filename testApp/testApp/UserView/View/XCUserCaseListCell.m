//
//  XCUserCaseListCell.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseListCell.h"

@interface XCUserCaseListCell ()
@property (nonatomic, strong) UILabel * caseNameLabel ;
@property (nonatomic, strong) UILabel * caseProcessLabel ;
@property (nonatomic, strong) UIButton * checkDetailBtn ;
@end

@implementation XCUserCaseListCell

#pragma mark - Init Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubVies];
        [_caseNameLabel setText:@"刘某案件..."];
        [_caseProcessLabel setText:@"进度: 处理中..."];
    }
    return self;
}

- (void)configSubVies
{
    _caseNameLabel = [[UILabel alloc] init];
    [_caseNameLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
    [_caseNameLabel setTextColor:COLOR_RGB_255(51, 51, 51)];
    
    _caseProcessLabel  = [[UILabel alloc] init];
    [_caseProcessLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_caseProcessLabel setTextColor:COLOR_RGB_255(253, 161, 0)];
    
    _checkDetailBtn = [UIButton buttonWithType:0];
    [_checkDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
//    [_checkDetailBtn.titleLabel setTextColor:COLOR_RGB_255(104, 153, 232)];
    [_checkDetailBtn setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
    [_checkDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [_checkDetailBtn addTarget:self action:@selector(clickCheckDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_caseNameLabel];
    [self addSubview:_caseProcessLabel];
    [self addSubview:_checkDetailBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_caseNameLabel sizeToFit];
    CGSize labelSize = _caseNameLabel.frame.size;
    [_caseNameLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, labelSize.width, 29 *ViewRateBaseOnIP6)];
    
    [_caseProcessLabel sizeToFit];
    labelSize = _caseProcessLabel.frame.size;
    [_caseProcessLabel setFrame:CGRectMake(_caseNameLabel.frame.origin.x, _caseNameLabel.frame.origin.y + _caseProcessLabel.frame.size.height + 20 * ViewRateBaseOnIP6 , labelSize.width, 24 * ViewRateBaseOnIP6)];
    
    [_checkDetailBtn sizeToFit];
    labelSize = _checkDetailBtn.frame.size;
    [_checkDetailBtn setFrame:CGRectMake(616 * ViewRateBaseOnIP6, (self.bounds.size.height - 24 * ViewRateBaseOnIP6) * 0.5, labelSize.width, 24 * ViewRateBaseOnIP6 )];
    
}

#pragma mark - Action Method
- (void)clickCheckDetail:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserCaseListCellClickDetailButtonHandler:cell:)]) {
        [self.delegate XCUserCaseListCellClickDetailButtonHandler:button cell:self];
    }
}


#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
