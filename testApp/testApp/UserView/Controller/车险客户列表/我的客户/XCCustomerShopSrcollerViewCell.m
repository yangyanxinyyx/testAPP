//
//  XCCustomerShopSrcollerViewCell.m
//  testApp
//
//  Created by Melody on 2018/4/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerShopSrcollerViewCell.h"
#import "UILabel+createLabel.h"
@interface XCCustomerShopSrcollerViewCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topLine ;
/** 门店名称 */
@property (nonatomic, strong) UILabel * titleLabel ;
/** 距离 */
@property (nonatomic, strong) UILabel * distrbuteLabel ;

@end

@implementation XCCustomerShopSrcollerViewCell

#pragma mark - lifeCycle
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_topLine setFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    
    CGSize labelSize;
    [_titleLabel sizeToFit];
    labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - 28 * ViewRateBaseOnIP6) * 0.5, labelSize.width, 28 * ViewRateBaseOnIP6)];
    
    [_distrbuteLabel sizeToFit];
    labelSize = _distrbuteLabel.frame.size;
    [_distrbuteLabel setFrame:CGRectMake(self.bounds.size.width - labelSize.width - 26 * ViewRateBaseOnIP6, (self.bounds.size.height - 20 *ViewRateBaseOnIP6) * ViewRateBaseOnIP6, labelSize.width, 20 *ViewRateBaseOnIP6)];
}
#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    self.topLine = [[UIView alloc] initWithFrame:CGRectZero];
    [self.topLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    self.titleLabel = [UILabel createLabelWithTextFontSize:30 textColor:COLOR_RGB_255(68, 68, 68)];
    self.distrbuteLabel = [UILabel createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(131, 131, 131)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWithView:)];
    [self addGestureRecognizer:tap];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_titleLabel];
    [self addSubview:_distrbuteLabel];
    [self addSubview:_topLine];

}

#pragma mark - Action Method
- (void)tapWithView:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCustomerShopSrcollerViewCellClickWithModel:)]) {
        [self.delegate XCCustomerShopSrcollerViewCellClickWithModel:self.model];
    }
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (void)setModel:(XCCustomerShopModel *)model
{
    _model = model;
    if (isUsableNSString(model.name, @"")) {
        [_titleLabel setText:_model.name];
    }
    if (isUsable(model.distance, [NSNumber class])) {
        [_distrbuteLabel setText:[NSString stringWithFormat:@"%.2fkm",[model.distance doubleValue]]];
    }
}

@end
