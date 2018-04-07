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
@property (nonatomic, strong) UIView * separtatorLine ;

@end

@implementation XCCheckoutDetailTextFiledCell

#pragma mark - lifeCycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shouldShowSeparator = NO;
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
    
    [_textField sizeToFit];
    labelSize = _textField.frame.size;
    if (_shouldShowSeparator) {
        [_textField setBackgroundColor:COLOR_RGB_255(255, 255, 255)];
    }else {
        [_textField setBackgroundColor:COLOR_RGB_255(240, 240, 240)];
    }
    [_textField setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, (self.bounds.size.height - 44 * ViewRateBaseOnIP6 ) * 0.5, 300 * ViewRateBaseOnIP6 , 44 * ViewRateBaseOnIP6)];
    if (_shouldShowSeparator) {
        [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
    }
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
    
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_separtatorLine];
    
}

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

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    if ([_titlePlaceholder isEqualToString:titlePlaceholder]) {
        return;
    }
    _titlePlaceholder = titlePlaceholder;
    NSString *newString = [NSString stringWithFormat:@"   %@",_titlePlaceholder];
    [_textField setPlaceholder:newString];
    [_textField sizeToFit];
}

@end

