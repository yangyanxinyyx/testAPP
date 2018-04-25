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
@property (nonatomic, strong) UIView * separtatorLine ;
@property (nonatomic, strong) UIView * twoSepartatorLine ;


/** <# 注释 #> */
@property (nonatomic, strong) UILabel * secondTitlelabel ;
/** <# 注释 #> */

@end

@implementation XCCheckoutDetailTextFiledCell
+(CGFloat)getCellHeight
{
    return 88 *ViewRateBaseOnIP6;
}
#pragma mark - lifeCycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isTopShowSeparator = NO;
        _shouldShowSeparator = NO;
        _isCenterSeparator = NO;
        _isTwoInputType = NO;
        _isNumField = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
  
    
    _secondTitlelabel.hidden = YES;
    _secondTextField.hidden = YES;
    if (_isTwoInputType) {
        _secondTitlelabel.hidden = NO;
        _secondTextField.hidden = NO;
        [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labeH) * 0.5, labelSize.width, labeH)];
        [_textField sizeToFit];
        labelSize = _textField.frame.size;
        [_textField setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, (self.bounds.size.height - 26 * ViewRateBaseOnIP6 ) * 0.5, 240 * ViewRateBaseOnIP6 , 26 * ViewRateBaseOnIP6)];
        
        [_secondTitlelabel sizeToFit];
        labelSize = _secondTitlelabel.frame.size;
        [_secondTitlelabel setFrame:CGRectMake(CGRectGetMaxX(_textField.frame), (self.bounds.size.height - labeH) * 0.5, labelSize.width, labeH)];
        [_secondTextField sizeToFit];
        labelSize = _secondTextField.frame.size;
        [_secondTextField setFrame:CGRectMake(CGRectGetMaxX(_secondTitlelabel.frame ) + 16 * ViewRateBaseOnIP6, (self.bounds.size.height - 26 * ViewRateBaseOnIP6 ) * 0.5, SCREEN_WIDTH - (CGRectGetMaxX(_secondTitlelabel.frame) + 16 * ViewRateBaseOnIP6)- 30 * ViewRateBaseOnIP6 , 26 * ViewRateBaseOnIP6)];
        
        [_twoSepartatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1 , self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
        
    }else {
        [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labeH) * 0.5, labelSize.width,labeH)];
        [_textField sizeToFit];
        labelSize = _textField.frame.size;
        [_textField setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, (self.bounds.size.height - 44 * ViewRateBaseOnIP6 ) * 0.5, self.bounds.size.width - (CGRectGetMaxX(_titleLabel.frame) + 16 + 16 * ViewRateBaseOnIP6) , 44 * ViewRateBaseOnIP6)];
    }
    
    if (_shouldShowSeparator) {
        if (_isCenterSeparator) {
             [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - (30 * ViewRateBaseOnIP6) * 2, 1)];
        }else {
            [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
        }
    }
    if (_isTopShowSeparator) {
          [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , 0, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
    }
   
    
}
#pragma mark - Init Method

#pragma mark - Action Method
- (void)setupCellWithShopModel:(XCShopModel *)model
{
    //门店
    if ([self.title isEqualToString:@"门店名称:"] && isUsableNSString(model.name,@"")) {
        [_textField setText:model.name];
    }
    else if ([self.title isEqualToString:@"联系方式:"] && isUsableNSString(model.tel, @"")) {
        [_textField setText:model.tel];
    }
    else if ([self.title isEqualToString:@"负责人:"] && isUsableNSString(model.corporateName, @"")) {
        [_textField setText:model.corporateName];
    }
    else if ([self.title isEqualToString:@"负责人电话:"] && isUsableNSString(model.corporateCellphone, @"")) {
        [_textField setText:model.corporateCellphone];
    }
    else if ([self.title isEqualToString:@"业务员提成:"] && isUsable(model.salesmanCommission, [NSNumber class])) {
    [_textField setText:[NSString stringWithFormat:@"%.2f %%",[model.salesmanCommission doubleValue]]];
        
    }
    else if ([self.title isEqualToString:@"团队经理提成:"] && isUsable(model.managerCommission, [NSNumber class])) {
              [_textField setText:[NSString stringWithFormat:@"%.2f %%",[model.managerCommission doubleValue]]];
    }
    else if ([self.title isEqualToString:@"门店审核状态"]&&isUsableNSString(model.storeStatus, @"")) {
        [_textField setText:model.storeStatus];
    }
    
}

//- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model
//{
//    if ([self.title isEqualToString:@"投保人:"] && isUsableNSString(model.onwerName,@"")) {
//        [_textField setText:model.onwerName];
//    }
//    else if ([self.title isEqualToString:@"身份证:"] && isUsableNSString(model.onwerIdentify,@"")) {
//        [_textField setText:model.onwerIdentify];
//    }
//    else if ([self.title isEqualToString:@"身份证:"] && isUsableNSString(model.onwerIdentify,@"")) {
//        [_textField setText:model.onwerIdentify];
//    }
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Delegates & Notifications

#pragma mark - TextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:(@selector(XCCheckoutDetailTextFiledSubmitTextField:title:))]) {
        [self.delegate XCCheckoutDetailTextFiledSubmitTextField:textField title:_titleLabel.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(_isNumField) {
        if (range.location >10) {
            return NO;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)  {
            return NO;
        }
        return YES;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailTextFiledShouldChangeCharactersInRange:replacementString:title:textFiled:)]) {
        return [self.delegate XCCheckoutDetailTextFiledShouldChangeCharactersInRange:range replacementString:string title:_title textFiled:textField];
    }

  
    return YES;
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
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;  
    [self addSubview:_textField];
    
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_separtatorLine];
    
    _twoSepartatorLine = [[UIView alloc] init];
    [_twoSepartatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_twoSepartatorLine];
    
    _secondTitlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_secondTitlelabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_secondTitlelabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_secondTitlelabel];
    
    _secondTextField = [[UITextField alloc] init];
    [_secondTextField setFont:[UIFont systemFontOfSize:24 * ViewRateBaseOnIP6]];
    _secondTextField.delegate = self;
    _secondTextField.returnKeyType = UIReturnKeyDone;
    [_secondTextField setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_secondTextField];
    
}

#pragma mark - Setter&Getter

-(void)setIsNumField:(BOOL)isNumField
{
    _isNumField =  isNumField;
}

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

- (void)setSecondTitle:(NSString *)secondTitle
{
    _secondTitle = secondTitle;
    [_secondTitlelabel setText:_secondTitle];
    [self layoutSubviews];
}

- (void)setSecondTitlePlaceholder:(NSString *)secondTitlePlaceholder
{
    _secondTitlePlaceholder = secondTitlePlaceholder;
    [_secondTextField setPlaceholder:_secondTitlePlaceholder];
    [self layoutSubviews];
}

- (void)setTextFiledBGColor:(UIColor *)textFiledBGColor
{
    if (_textField) {
        [_textField setBackgroundColor:textFiledBGColor];
    }
}

@end

