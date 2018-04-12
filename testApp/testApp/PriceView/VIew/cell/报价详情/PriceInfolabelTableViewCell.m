//
//  PriceInfolabelTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//   标签cell

#import "PriceInfolabelTableViewCell.h"

@implementation PriceInfolabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [ super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.labelTag = [[UILabel alloc] init];
        self.labelInfo = [[UILabel alloc] init];
        self.labelNumber = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTag];
        [self.contentView addSubview:self.labelInfo];
        [self.contentView addSubview:self.labelNumber];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelTag.frame = CGRectMake(31 * ViewRateBaseOnIP6 , 30 * ViewRateBaseOnIP6, 200, 26 * ViewRateBaseOnIP6);
    self.labelTag.backgroundColor = [UIColor clearColor];
    self.labelTag.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelTag.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    
    self.labelInfo.frame = CGRectMake(355 * ViewRateBaseOnIP6, 33 *ViewRateBaseOnIP6, 100, 23 *ViewRateBaseOnIP6);
    self.labelInfo.backgroundColor = [UIColor clearColor];
    self.labelInfo.textColor = [UIColor colorWithHexString:@"#a5a5a5"];
    self.labelInfo.font = [UIFont systemFontOfSize:23 * ViewRateBaseOnIP6];
    
    self.labelNumber.frame = CGRectMake(200 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, SCREEN_WIDTH - 230 * ViewRateBaseOnIP6, 22 * ViewRateBaseOnIP6);
    self.labelNumber.textAlignment = NSTextAlignmentRight;
    self.labelNumber.backgroundColor = [UIColor clearColor];
    self.labelNumber.font = [UIFont systemFontOfSize:22 * ViewRateBaseOnIP6];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
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
