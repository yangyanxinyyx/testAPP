//
//  XCCheckoutDetailTextFiledCell.m
//  testApp
//
//  Created by Melody on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailTextFiledCell.h"

@interface XCCheckoutDetailTextFiledCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UITextField * textField ;

@end

@implementation XCCheckoutDetailTextFiledCell

#pragma mark - lifeCycle

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
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6, labelSize.width,24 * ViewRateBaseOnIP6)];
    
    [_textField sizeToFit];
    labelSize = _textField.frame.size;
    [_textField setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, _titleLabel.frame.origin.y, labelSize.width, 24 * ViewRateBaseOnIP6)];
    
}
#pragma mark - Init Method

#pragma mark - Action Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Delegates & Notifications

#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:(@selector(XCCheckoutDetailTextFiledSubmitTextField:))]) {
        [self.delegate XCCheckoutDetailTextFiledSubmitTextField:textField.text];
    }
}

#pragma mark - Privacy Method

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    [_textField setFont:[UIFont systemFontOfSize:24 * ViewRateBaseOnIP6]];
    _textField.delegate = self;
    [self addSubview:_textField];
    
}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    [_titleLabel setText:title];
}

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    [_textField setPlaceholder:titlePlaceholder];
}

@end

