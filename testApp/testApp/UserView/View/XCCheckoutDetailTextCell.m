//
//  XCCheckoutDetailTextCell.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailTextCell.h"

@interface XCCheckoutDetailTextCell()

@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UILabel * placeholderLabel ;
@end

@implementation XCCheckoutDetailTextCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubVies];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    CGFloat labeH = 25 * ViewRateBaseOnIP6;
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labeH) * 0.5, labelSize.width,labeH)];
    
    [_placeholderLabel sizeToFit];
    labelSize = _placeholderLabel.frame.size;
    [_placeholderLabel setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, _titleLabel.frame.origin.y, labelSize.width, labeH)];
    
}

#pragma mark - Action Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize: 26 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_titleLabel];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_placeholderLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_placeholderLabel setTextColor:COLOR_RGB_255(165, 165, 165)];
    [self addSubview:_placeholderLabel];

}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    [_titleLabel setText:title]; if ([_title isEqualToString:title]) {
        return;
    }
    _title = title;
    [_titleLabel setText:_title];
    [_titleLabel sizeToFit];

}

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    if ([_titlePlaceholder isEqualToString:titlePlaceholder]) {
        return;
    }
    _titlePlaceholder = titlePlaceholder;
    [_placeholderLabel setText:_titlePlaceholder];
    [_placeholderLabel sizeToFit];

}



@end
