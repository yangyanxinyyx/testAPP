//
//  PriceCustomerInformEntryTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCustomerInformEntryTableViewCell.h"

@interface PriceCustomerInformEntryTableViewCell ()<UITextFieldDelegate>
{
    BOOL isChangeColor;
}
@property (nonatomic, strong) UILabel *labelContext;

@end

@implementation PriceCustomerInformEntryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationAction:) name:@"CustomerNotification" object:nil];
        isChangeColor = NO;
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.textField = [[UITextField alloc] init];
        [self.contentView addSubview:self.textField];
        self.labelContext = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelContext];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 120 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    if (!isChangeColor) {
        self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    }
    self.textField.frame = CGRectMake(163 * ViewRateBaseOnIP6, 5 * ViewRateBaseOnIP6, SCREEN_WIDTH - 193 * ViewRateBaseOnIP6, 74 * ViewRateBaseOnIP6);
    self.textField.placeholder = @"请输入...";
    
    self.textField.font = [UIFont systemFontOfSize:24 * ViewRateBaseOnIP6];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChangePhoneNnumber:) forControlEvents:UIControlEventEditingChanged];
}
- (void)setLabelNameText:(NSString *)text{
    isChangeColor = YES;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#444444"] range:NSMakeRange(1,3)];
    self.labelName.attributedText = str;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#e5e5e5"].CGColor); CGContextStrokeRect(context, CGRectMake(30 * ViewRateBaseOnIP6, rect.size.height, rect.size.width - 60 * ViewRateBaseOnIP6, 1 * ViewRateBaseOnIP6));
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.labelName.text isEqualToString:@"联系方式:"]) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if ([self.labelName.text isEqualToString:@"身  份  证:"]) {
        textField.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    [self.delegate textFieldBeginEditing:self.textField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.delegate textFieldendEditing:self.textField];
    return YES;
}

- (void)textFieldDidChangePhoneNnumber:(UITextField *)sender{
    if ([self.labelName.text isEqualToString:@"联系方式:"]) {
        if (sender.text.length > 11) {
          self.textField.text = [self.textField.text substringToIndex:11];
        }
    }
    
    if ([self.labelName.text isEqualToString:@"身  份  证:"]) {
        if (sender.text.length > 18) {
            self.textField.text = [self.textField.text substringToIndex:18];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.delegate textFieldendEditing:self.textField];
}

- (void)NotificationAction:(NSNotification *)notification{
    [self.textField endEditing:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
