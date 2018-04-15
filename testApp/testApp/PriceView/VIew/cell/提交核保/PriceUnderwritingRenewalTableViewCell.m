//
//  PriceUnderwritingRenewalTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceUnderwritingRenewalTableViewCell.h"

@interface PriceUnderwritingRenewalTableViewCell ()
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIButton *buttonSelect;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation PriceUnderwritingRenewalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _isSelect = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.labelName = [[UILabel alloc]init];
        [self.contentView addSubview:self.labelName];
        
        self.buttonSelect = [[UIButton alloc] init];
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"unSelect"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.buttonSelect];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 120 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelName.text = @"是否续保";
    self.labelName.textColor = [UIColor  colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    
    self.buttonSelect.frame = CGRectMake(165 * ViewRateBaseOnIP6, 20 *ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6);
    [self.buttonSelect addTarget:self action:@selector(touchButtonSelect:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect); //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#e5e5e5"].CGColor);
    CGContextStrokeRect(context, CGRectMake(30 * ViewRateBaseOnIP6, rect.size.height, rect.size.width - 60 * ViewRateBaseOnIP6, 1 * ViewRateBaseOnIP6));
}

- (void)touchButtonSelect:(UIButton *)button{
    if (_isSelect) {
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    } else {
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"unSelect"] forState:UIControlStateNormal];
    }
    _isSelect = !_isSelect;
    [self.delegate getRenewalStatus:_isSelect];
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
