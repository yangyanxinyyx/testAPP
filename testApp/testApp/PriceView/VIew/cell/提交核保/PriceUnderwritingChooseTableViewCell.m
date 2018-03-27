//
//  PriceUnderwritingChooseTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceUnderwritingChooseTableViewCell.h"
@interface PriceUnderwritingChooseTableViewCell ()
@property (nonatomic, strong) UIImageView *imageViewSelect;
@end
@implementation PriceUnderwritingChooseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.labelTag = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTag];
        self.imageViewSelect = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewSelect];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 26 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    
    self.labelTag.frame = CGRectMake(SCREEN_WIDTH - 262 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, 200 * ViewRateBaseOnIP6, 19 * ViewRateBaseOnIP6);
    self.labelTag.textColor = [UIColor colorWithHexString:@"#a5a5a5"];
    self.labelTag.font = [UIFont systemFontOfSize:19 * ViewRateBaseOnIP6];
    self.labelTag.textAlignment = NSTextAlignmentRight;
    
    self.imageViewSelect.frame =CGRectMake(SCREEN_WIDTH - 50 * ViewRateBaseOnIP6, 23 * ViewRateBaseOnIP6, 20 * ViewRateBaseOnIP6, 36 * ViewRateBaseOnIP6);
    self.imageViewSelect.image = [UIImage imageNamed:@"右"];
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
