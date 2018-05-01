//
//  XCUserViolationDetailHeaderView.m
//  testApp
//
//  Created by Melody on 2018/4/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserViolationDetailHeaderView.h"
#import "UILabel+createLabel.h"
@interface XCUserViolationDetailHeaderView ()
@property (nonatomic, strong) UILabel * groupLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * bgView ;
@end

@implementation XCUserViolationDetailHeaderView

+ (CGFloat)getHeaderViewHeight
{
    return (88 + 20) * ViewRateBaseOnIP6;
}

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

    [_bgView setFrame:CGRectMake(0, 20*ViewRateBaseOnIP6,self.bounds.size.width , 88 * ViewRateBaseOnIP6)];
    [_groupLabel sizeToFit];
    CGSize labeSize = _groupLabel.frame.size;
    [_groupLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (_bgView.frame.size.height - 29 * ViewRateBaseOnIP6) * 0.5, labeSize.width, 29 * ViewRateBaseOnIP6)];
    
}


- (void)initUI
{
    [self setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    
    _groupLabel = [UILabel createLabelWithTextFontSize:30 textColor:[UIColor colorWithHexString:@"#333333"]];
    [_bgView addSubview:_groupLabel];
    [self addSubview:_bgView];
}

- (void)setGroupName:(NSString *)groupName
{
    _groupName = groupName;
    [_groupLabel setText:groupName];
}

@end
