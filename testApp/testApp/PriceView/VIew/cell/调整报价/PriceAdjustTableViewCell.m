//
//  PriceAdjustTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceAdjustTableViewCell.h"
@interface PriceAdjustTableViewCell ()

@property (nonatomic, strong) UIImageView *imageViewFranchise;  //免赔
@property (nonatomic, strong) UILabel *labelFranchise;          //免赔
@property (nonatomic, strong) UIImageView *imageViewParentheses; //括号
@end
@implementation PriceAdjustTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        
        self.labelTag = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTag];
        
        self.labelFranchise = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelFranchise];
        
        self.imageViewFranchise = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewFranchise];
        
        self.imageViewParentheses = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewParentheses];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, 200 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    
    self.imageViewFranchise.frame = CGRectMake(299 * ViewRateBaseOnIP6, 24 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6);
    
    
    self.labelFranchise.frame = CGRectMake( 350  * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6, 23 * ViewRateBaseOnIP6);
    self.labelFranchise.font = [UIFont systemFontOfSize:23 * ViewRateBaseOnIP6];
    self.labelFranchise.text = @"不计免赔";
    
    self.labelTag.frame = CGRectMake(SCREEN_WIDTH - 173 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelTag.textColor = [UIColor colorWithHexString:@"#838383"];
    self.labelTag.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    self.labelTag.textAlignment = NSTextAlignmentRight;
    
    self.imageViewParentheses.frame = CGRectMake(693 * ViewRateBaseOnIP6, 35 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 14 * ViewRateBaseOnIP6);
    self.imageViewParentheses.image = [UIImage imageNamed:@"3"];
    
}
- (void)hiddenFranchiseView:(BOOL)isHidden{
    self.imageViewFranchise.hidden = isHidden;
    self.labelFranchise.hidden = isHidden;
}

- (void)franchiseIsSelect:(BOOL)isSelect{
    if (isSelect) {
        self.imageViewFranchise.image = [UIImage imageNamed:@"勾"];
        self.labelFranchise.textColor = [UIColor colorWithHexString:@"#838383"];
    } else {
        self.imageViewFranchise.image = [UIImage imageNamed:@"灰勾"];
        self.labelFranchise.textColor = [UIColor colorWithHexString:@"#e5e5e5"];
    }
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
