//
//  XCCheckoutTableViewCell.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutTableViewCell.h"
#import "XCCheckoutDetailBaseModel.h"
#import "XCCustomerListModel.h"
#import <UIKit/UIKit.h>

@interface XCCheckoutTableViewCell ()

@property (nonatomic, strong) UILabel * carNumberLabel ;
@property (nonatomic, strong) UILabel * userNameLabel ;
@property (nonatomic, strong) UILabel * issueTimeLabel ;
@property (nonatomic, strong) UIButton * checkButton ;
@property (nonatomic, strong) UIButton * underWritingButton ;
@property (nonatomic, strong) UIView * separpatorLine ;

/** 我的客户Model */
@property (nonatomic, strong) XCCustomerListModel * customerModel ;
@end

@implementation XCCheckoutTableViewCell

#pragma mark - Init Method
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _isCustomerCell = NO;
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
    
    _underWritingButton = [UIButton buttonWithType:0];
    [_underWritingButton setTitle:@"核保" forState:UIControlStateNormal];
    _underWritingButton.titleLabel.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
    [_underWritingButton setTitleColor:COLOR_RGB_255(104, 153, 232) forState:UIControlStateNormal];
    _underWritingButton.layer.cornerRadius = 3;
        _underWritingButton.layer.borderColor = COLOR_RGB_255(104, 153, 232).CGColor;
    _underWritingButton.layer.borderWidth = 0.5;
    [_underWritingButton addTarget:self action:@selector(clickUnderWritingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_underWritingButton];
    
    _separpatorLine = [[UIView alloc] init];
    [_separpatorLine setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self addSubview:_separpatorLine];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [self.carNumberLabel sizeToFit];
    [self.carNumberLabel setFrame:CGRectMake(leftMargin, 29 * ViewRateBaseOnIP6, 450 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6)];
    [self.userNameLabel sizeToFit];
    [self.userNameLabel setFrame:CGRectMake(leftMargin, self.carNumberLabel.frame.origin.y + self.carNumberLabel.frame.size.height + 18 * ViewRateBaseOnIP6, self.userNameLabel.frame.size.width, 21 * ViewRateBaseOnIP6)];
    [self.issueTimeLabel sizeToFit];
    [self.issueTimeLabel setFrame:CGRectMake(leftMargin, self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height + 12 * ViewRateBaseOnIP6, self.issueTimeLabel.frame.size.width, 21 * ViewRateBaseOnIP6)];
    
    
    CGFloat buttonW = 160 * ViewRateBaseOnIP6;
    CGFloat buttonH = 60 * ViewRateBaseOnIP6;

    if (_isCustomerCell) {
         buttonW = 110 * ViewRateBaseOnIP6;
         buttonH = 50 * ViewRateBaseOnIP6;
        [self.underWritingButton setFrame:CGRectMake(self.frame.size.width - (31 * ViewRateBaseOnIP6 + buttonW) * 2,(self.frame.size.height - buttonH) * 0.5   , buttonW, buttonH)];        
        
        self.checkButton.titleLabel.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
        [self.checkButton setTitleColor:COLOR_RGB_255(255, 255, 255) forState:UIControlStateNormal];
        self.checkButton.layer.borderColor = COLOR_RGB_255(1,77,163).CGColor;
        [self.checkButton setBackgroundColor:COLOR_RGB_255(104, 153, 232)];
        [self.checkButton setFrame:CGRectMake(self.frame.size.width - 31 * ViewRateBaseOnIP6 - buttonW,(self.frame.size.height - buttonH) * 0.5   , buttonW, buttonH)];
        
        
        _underWritingButton.titleLabel.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
        [_underWritingButton setTitleColor:COLOR_RGB_255(1,77, 163) forState:UIControlStateNormal];
        _underWritingButton.layer.borderColor = COLOR_RGB_255(1,77, 163).CGColor;
        
    }else {
        [self.underWritingButton setFrame:CGRectZero];
        [self.checkButton setFrame:CGRectMake(self.frame.size.width - 31 * ViewRateBaseOnIP6 - buttonW,(self.frame.size.height - buttonH) * 0.5   , buttonW, buttonH)];
    }
    
    [_separpatorLine setFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    
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

- (void)clickUnderWritingButton:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutCellClickUnderWritingButtonHandler:cell:)]) {
        [self.delegate XCCheckoutCellClickUnderWritingButtonHandler:button cell:self];
        
    }else {
        XCLog(@"CLass:%@ - (void)clickUnderWritingButton:Failure ",[self class]);
    }
}

- (void)setupCellWithMYCustomerListModel:(XCCustomerListModel *)model
{
    _customerModel = model;
    NSString *titleStr = [NSString stringWithFormat:@"%@ %@ (%@)",model.customerName,model.plateNo,model.brand];
    [_carNumberLabel setText:titleStr];
    [_userNameLabel setText:[NSString stringWithFormat:@"跟进时间: %@",model.nextFollowTime]];
    [_issueTimeLabel setText:[NSString stringWithFormat:@"联系方式: %@",model.phoneNo]];
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

- (void)setIsCustomerCell:(BOOL)isCustomerCell
{
    _isCustomerCell = isCustomerCell;
    [self layoutSubviews];
}

- (void)setBaseModel:(XCCheckoutDetailBaseModel *)baseModel
{
    if (!baseModel) {
        return;
    }
    if (isUsableNSString(baseModel.plateNo, @"")) {
        [_carNumberLabel setText:baseModel.plateNo];
    }
    if (isUsableNSString(baseModel.onwerName, @"")) {
        [_carNumberLabel setText:[NSString stringWithFormat:@"车主: %@",baseModel.onwerName]];
    }
    if (isUsableNSString(baseModel.recordDate, @"")) {
        [_issueTimeLabel setText:[NSString stringWithFormat:@"出单时间: %@",baseModel.recordDate]];
    }
    
}

@end
