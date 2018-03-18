//
//  XCUserListHeaderView.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserListHeaderView.h"
@interface XCUserListHeaderView ()
@property (nonatomic, strong) UILabel * nameLabel ;
@end
@implementation XCUserListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _nameLabel = [[UILabel alloc] init];

        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
        [_nameLabel setTextColor:[UIColor colorWithHexString:@"#838383"]];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)setGroupName:(NSString *)groupName
{
    NSString *name = @"未知错误";
    if (groupName) {
        name = groupName;
    }
    _groupName = name;
    [_nameLabel setText:_groupName];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_nameLabel setFrame:CGRectMake(29 * ViewRateBaseOnIP6, self.frame.size.height - (25+22)*ViewRateBaseOnIP6, self.frame.size.width - 29 * ViewRateBaseOnIP6, 25 * ViewRateBaseOnIP6)];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _groupName = nil;
    [_nameLabel setText:@""];
}

@end
