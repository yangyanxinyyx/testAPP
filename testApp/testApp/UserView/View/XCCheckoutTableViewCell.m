//
//  XCCheckoutTableViewCell.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutTableViewCell.h"
#import <UIKit/UIKit.h>

@interface XCCheckoutTableViewCell ()

@property (nonatomic, strong) UILabel * carNumberLabel ;
@property (nonatomic, strong) UILabel * userNameLabel ;
@property (nonatomic, strong) UILabel * issueTimeLabel ;
@property (nonatomic, strong) UIButton * checkButton ;

@end

@implementation XCCheckoutTableViewCell

#pragma mark - Init Method
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    self.carNumberLabel = ({
        UILabel *carNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [carNumberLabel setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
        [carNumberLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
        [carNumberLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:carNumberLabel];
        carNumberLabel;
    });
    
    self.userNameLabel = ({
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [userNameLabel setFont:[UIFont systemFontOfSize:22 * ViewRateBaseOnIP6]];
        [userNameLabel setTextColor:COLOR_RGB_255(131, 131, 131)];
        [userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:userNameLabel];
        userNameLabel;
    });
    
    self.issueTimeLabel = ({
        UILabel *issueTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [issueTimeLabel setFont:[UIFont systemFontOfSize:22 * ViewRateBaseOnIP6]];
        [issueTimeLabel setTextColor:COLOR_RGB_255(131, 131, 131)];
        [issueTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:issueTimeLabel];
        issueTimeLabel;
    });
    
    self.checkButton = ({
        UIButton *checkButton = [UIButton buttonWithType:0];
        [checkButton setTitle:@"查看" forState:UIControlStateNormal];
        checkButton.titleLabel.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
        [checkButton setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
        checkButton.layer.cornerRadius = 3;
        checkButton.layer.borderColor = COLOR_RGB_255(104, 153, 232).CGColor;
        checkButton.layer.borderWidth = 0.5;
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkButton];
        checkButton;
    });
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [self.carNumberLabel sizeToFit];
    [self.carNumberLabel setFrame:CGRectMake(leftMargin, 29 * ViewRateBaseOnIP6, self.carNumberLabel.frame.size.width, 28 * ViewRateBaseOnIP6)];
    [self.userNameLabel sizeToFit];
    [self.userNameLabel setFrame:CGRectMake(leftMargin, self.carNumberLabel.frame.origin.y + self.carNumberLabel.frame.size.height + 18 * ViewRateBaseOnIP6, self.userNameLabel.frame.size.width, 21 * ViewRateBaseOnIP6)];
    [self.issueTimeLabel sizeToFit];
    [self.issueTimeLabel setFrame:CGRectMake(leftMargin, self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height + 12 * ViewRateBaseOnIP6, self.issueTimeLabel.frame.size.width, 21 * ViewRateBaseOnIP6)];
    
    CGFloat buttonW = 160 * ViewRateBaseOnIP6;
    CGFloat buttonH = 60 * ViewRateBaseOnIP6;
    [self.checkButton setFrame:CGRectMake(self.frame.size.width - 31 * ViewRateBaseOnIP6 - buttonW,(self.frame.size.height - buttonH) * 0.5   , buttonW, buttonH)];
    
}

#pragma mark - Action Method

- (void)checkButtonClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutCellClickCheckoutButtonHandler:cell:)]) {
        [self.delegate XCCheckoutCellClickCheckoutButtonHandler:button cell:self];

    }else {
        XCLog(@"CLass:%@ - checkButtonClick: Failure ",[self class]);
    }
}

#pragma mark - Delegates & Notifications

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Privacy Method


#pragma mark - Setter&Getter

- (void)setCarNumber:(NSString *)carNumber
{
    if (!carNumber) {
        return;
    }
    _carNumber = carNumber;
    [self.carNumberLabel setText:_carNumber];
    //(TODO)需要sizeToFit?
}

- (void)setUserName:(NSString *)userName
{
    if (!userName) {
        return;
    }
    _userName = userName;
    NSString *userNameStr = [NSString stringWithFormat:@"车主: %@",_userName];
    [self.userNameLabel setText:userNameStr];
}

- (void)setIssureTime:(NSString *)issureTime
{
    if (!issureTime) {
        return;
    }
    _issureTime = issureTime;
     NSString *issureTimeStr = [NSString stringWithFormat:@"出单时间: %@",_issureTime];
    [self.issueTimeLabel setText:issureTimeStr];
}


@end
