//
//  PriceUnderwritingTextTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceUnderwritingTextTableViewCell.h"

@implementation PriceUnderwritingTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        
        self.textFieldMoney = [[UITextField alloc] init];
        [self.contentView addSubview:self.textFieldMoney];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    
    self.textFieldMoney.frame = CGRectMake(336 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, SCREEN_WIDTH - 366 * ViewRateBaseOnIP6, 26 *  ViewRateBaseOnIP6);
    self.textFieldMoney.placeholder = @"请输入金额";
    [self.textFieldMoney setValue:[UIColor colorWithHexString:@"#a5a5a5"] forKeyPath:@"_placeholderLabel.textColor"];
    self.textFieldMoney.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect); //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#e5e5e5"].CGColor);
    CGContextStrokeRect(context, CGRectMake(30 * ViewRateBaseOnIP6, rect.size.height, rect.size.width - 60 * ViewRateBaseOnIP6, 1 * ViewRateBaseOnIP6));
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
