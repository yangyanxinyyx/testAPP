//
//  XCShopDetailSeclectCell.m
//  testApp
//
//  Created by Melody on 2018/4/10.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopDetailSeclectCell.h"
#import "UILabel+createLabel.h"
@interface XCShopDetailSeclectCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * selectButton ;
@end

@implementation XCShopDetailSeclectCell

+(CGFloat)getCellHeight
{
    return 88 * ViewRateBaseOnIP6;
}

#pragma mark - lifeCycle
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labelSize;
    [_titleLabel sizeToFit];
    labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(30 *ViewRateBaseOnIP6,(self.bounds.size.height - 27 * ViewRateBaseOnIP6) * 0.5, labelSize.width, 27 * ViewRateBaseOnIP6)];
    labelSize = CGSizeMake(40 * ViewRateBaseOnIP6, 40 *ViewRateBaseOnIP6);
    [_selectButton setFrame:CGRectMake(self.bounds.size.width - labelSize.width - 30 * ViewRateBaseOnIP6, (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width, labelSize.height)];
}
#pragma mark - Init Method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews
{
    UIImage *selectImage = [UIImage imageNamed:@"勾"];
    UIImage *unSelectImage = [UIImage imageNamed:@"灰勾"];
    _titleLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(68, 68, 68)];
    _selectButton = [UIButton buttonWithType:0];
    [_selectButton setImage:unSelectImage forState:UIControlStateNormal];
    [_selectButton setImage:selectImage forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_titleLabel];
    [self addSubview:_selectButton];
}

#pragma mark - Action Method

- (void)clickSelectButton:(UIButton *)button
{
    button.selected = !button.selected;
}

- (BOOL)getSelect
{
    if (_selectButton && _selectButton.selected) {
        return YES;
    }
    return NO;
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter


@end
