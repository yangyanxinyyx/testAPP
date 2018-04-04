//
//  XCCheckoutDetailHeaderView.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailHeaderView.h"

@interface XCCheckoutDetailHeaderView ()
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * groupLabel ;
@end

@implementation XCCheckoutDetailHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_groupLabel sizeToFit];
    CGSize labelSize = _groupLabel.frame.size;
    [_groupLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.frame.size.height - 25 * ViewRateBaseOnIP6) * 0.5 , labelSize.width, 25 * ViewRateBaseOnIP6)];
}

- (void)initUI
{
    [self setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    
    _groupLabel  = [[UILabel alloc] init];
    [_groupLabel setTextColor:COLOR_RGB_255(131, 131, 131)];
    [_groupLabel setFont:[UIFont systemFontOfSize:26 *ViewRateBaseOnIP6]];
    [self addSubview:_groupLabel];
    
}

- (void)setGroupName:(NSString *)groupName
{
    _groupName = groupName;
    [_groupLabel setText:_groupName];
    [self layoutIfNeeded];
}

@end
