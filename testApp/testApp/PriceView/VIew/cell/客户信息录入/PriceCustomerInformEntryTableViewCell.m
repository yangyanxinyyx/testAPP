//
//  PriceCustomerInformEntryTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCustomerInformEntryTableViewCell.h"

@implementation PriceCustomerInformEntryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.textField = [[UITextField alloc] init];
        [self.contentView addSubview:self.textField];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 120 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    
    self.textField.frame = CGRectMake(163 * ViewRateBaseOnIP6, 29 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 24 * ViewRateBaseOnIP6);
    self.textField.placeholder = @"请输入...";
    self.textField.font = [UIFont systemFontOfSize:24 * ViewRateBaseOnIP6];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect); //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, 0, rect.size.width - 10, 1));
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#e5e5e5"].CGColor); CGContextStrokeRect(context, CGRectMake(30 * ViewRateBaseOnIP6, rect.size.height, rect.size.width - 60 * ViewRateBaseOnIP6, 1 * ViewRateBaseOnIP6));
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
