//
//  PriceInspectTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInspectTableViewCell.h"

@implementation PriceInspectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc]init];
        [self.contentView addSubview:self.labelName];
        self.buttoninspect = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.buttoninspect];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(31 * ViewRateBaseOnIP6, 44 * ViewRateBaseOnIP6, 250 * ViewRateBaseOnIP6, 31 * ViewRateBaseOnIP6);
    self.labelName.font = [UIFont systemFontOfSize:32 * ViewRateBaseOnIP6];
    self.labelName.backgroundColor = [UIColor clearColor];
    self.labelName.textColor = [UIColor colorWithHexString:@"#333333"];
    
    self.buttoninspect.frame = CGRectMake(607 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 111 * ViewRateBaseOnIP6, 60 * ViewRateBaseOnIP6);
    self.buttoninspect.backgroundColor = [UIColor clearColor];
    [self.buttoninspect setTitleColor:[UIColor colorWithHexString:@"#6899e8"] forState:UIControlStateNormal];
    self.buttoninspect.titleLabel.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    [self.buttoninspect setTitle:@"查看报价" forState:UIControlStateNormal];
    [self.buttoninspect addTarget:self action:@selector(inspectPrice:) forControlEvents:UIControlEventTouchDown];
    
}

// 自绘分割线
 - (void)drawRect:(CGRect)rect{
    //获取cell系统自带的分割线，获取分割线对象目的是为了保持自定义分割线frame和系统自带的分割线一样。如果不想一样，可以忽略。
    UIView *separatorView = [self valueForKey:@"_separatorView"];
    NSLog(@"%@",NSStringFromCGRect(separatorView.frame));
    NSLog(@"%@",NSStringFromCGRect(rect));
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#e5e5e5"].CGColor);
    CGContextStrokeRect(context, separatorView.frame);
    
}

- (void)inspectPrice:(UIButton *)button{
    [self.delegate inspectPriceDelegateWith:button.tag];
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
