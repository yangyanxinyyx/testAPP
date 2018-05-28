//
//  XCShopLabelChildView.m
//  testApp
//
//  Created by Melody on 2018/5/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopLabelChildView.h"
#import "UILabel+createLabel.h"
@interface XCShopLabelChildView ()
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * selectBtn ;
@end

@implementation XCShopLabelChildView

+(CGFloat)getViewHeight
{
    return (32 + 40) * ViewRateBaseOnIP6;
}

#pragma mark - lifeCycle
- (void)layoutSubviews
{
    [super layoutSubviews];
 
    CGFloat commonLabelHeight = 32 * ViewRateBaseOnIP6;
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(40 * ViewRateBaseOnIP6 , 40 * ViewRateBaseOnIP6, labelSize.width, commonLabelHeight)];
    
    labelSize = CGSizeMake(40 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6);
    [_selectBtn setFrame:CGRectMake(self.frame.size.width - labelSize.width - 60 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    
}
#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Selected:(BOOL)isSelected
{
    self = [self initWithFrame:frame];
    _title = title;
    _isSelected = isSelected;
    [self setupSubViews];
    [_titleLabel setText:title];
    [_selectBtn setSelected:_isSelected];
    
    return self;
}

- (void)setupSubViews
{
    _titleLabel = [UILabel createLabelWithTextFontSize:34 textColor:COLOR_RGB_255(68, 68, 68)];
    
    _selectBtn = [UIButton buttonWithType:0];
    UIImage *selectImage = [UIImage imageNamed:@"勾"];
    UIImage *unSelectImage = [UIImage imageNamed:@"灰勾"];
    _selectBtn.userInteractionEnabled = NO;
    [_selectBtn setImage:unSelectImage forState:UIControlStateNormal];
    [_selectBtn setImage:selectImage forState:UIControlStateSelected];
    
    [self addSubview:_titleLabel];
    [self addSubview:_selectBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelected)];
    [self addGestureRecognizer:tap];
}

#pragma mark - Action Method
- (void)toggleSelected
{
    self.isSelected = !_isSelected;
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    [_selectBtn setSelected:_isSelected];
}

@end

