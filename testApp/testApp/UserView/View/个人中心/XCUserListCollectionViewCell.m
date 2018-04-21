//
//  XCUserListCollectionViewCell.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserListCollectionViewCell.h"

@interface XCUserListCollectionViewCell ()
@property (nonatomic, strong) UIImageView * iconImageView ;
@property (nonatomic, strong) UILabel * titleLabel ;
@end

@implementation XCUserListCollectionViewCell

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _iconImageView = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:22 * ViewRateBaseOnIP6];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"#444444"]];
        
        [self addSubview:_iconImageView];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView setFrame:CGRectMake((self.frame.size.width - 48 * ViewRateBaseOnIP6 ) * 0.5, 46 * ViewRateBaseOnIP6, 48 * ViewRateBaseOnIP6, 48 * ViewRateBaseOnIP6)];
    CGFloat labelWidth = _titleLabel.frame.size.width;
    CGFloat labelHeight =_titleLabel.frame.size.height;
    [_titleLabel setFrame:CGRectMake((self.frame.size.width - labelWidth) * 0.5 , 109 * ViewRateBaseOnIP6, labelWidth, labelHeight)];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _icon = nil;
    _iconImageView.image = nil;
    _title = nil;
    [_titleLabel setText:@""];
    
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (void)setIcon:(UIImage *)icon
{
    if (!icon) {return;}
    _icon = icon;
    _iconImageView.image = _icon;
}

- (void)setTitle:(NSString *)title
{
    if (!title) {return;}
    _title = title;
    [_titleLabel setText:_title];
    [_titleLabel sizeToFit];
}

@end
