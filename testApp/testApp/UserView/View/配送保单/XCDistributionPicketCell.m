//
//  XCDistributionPicketCell.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCDistributionPicketCell.h"

@interface XCDistributionPicketCell()
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * valueLabel ;
/** 右箭头 */
@property (nonatomic, strong) UIImageView * extendImageView ;

@property (nonatomic, strong) UIView * separtatorLine ;

@end

@implementation XCDistributionPicketCell

#pragma mark - lifeCycle


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width,labelSize.height)];
    
    labelSize = CGSizeMake(20 * ViewRateBaseOnIP6, 36 * ViewRateBaseOnIP6);
    [_extendImageView setFrame:CGRectMake(self.frame.size.width - (labelSize.width +  30 * ViewRateBaseOnIP6), (self.frame.size.height - labelSize.height) * 0.5 , labelSize.width, labelSize.height)];
    
    [_valueLabel sizeToFit];
    labelSize = _valueLabel.frame.size;
    [_valueLabel setFrame:CGRectMake(CGRectGetMinX(_extendImageView.frame) - 16 * ViewRateBaseOnIP6 - labelSize.width , (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width,labelSize.height)];
    if (_shouldShowSeparator) {
        [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shouldShowSeparator = YES;
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize: 28 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_titleLabel];
    
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_valueLabel setFont:[UIFont systemFontOfSize:24 * ViewRateBaseOnIP6]];
    [_valueLabel setTextColor:COLOR_RGB_255(165, 165, 165)];
    [self addSubview:_valueLabel];
    
    _extendImageView = [[UIImageView alloc] init];
    _extendImageView.image = [UIImage imageNamed:@"next"];
    [self addSubview:_extendImageView];
    
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_separtatorLine];

}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title]) {
        return;
    }
    _title = title;
    [_titleLabel setText:_title];
    [_titleLabel sizeToFit];
    
}

-(void)setTitleValue:(NSString *)titleValue
{
    if ([_titleValue isEqualToString:titleValue]) {
        return;
    }
    _titleValue = titleValue;
    [_valueLabel setText:_titleValue];
    [_valueLabel sizeToFit];
}

@end
