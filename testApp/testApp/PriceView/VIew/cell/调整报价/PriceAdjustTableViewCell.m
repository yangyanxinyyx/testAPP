//
//  PriceAdjustTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceAdjustTableViewCell.h"
@interface PriceAdjustTableViewCell ()
{
    BOOL isFranchise;
    BOOL isOpenToubao;
}
@property (nonatomic, strong) UIImageView *imageViewFranchise;  //免赔
@property (nonatomic, strong) UILabel *labelFranchise;          //免赔
@property (nonatomic, strong) UIImageView *imageViewParentheses; //括号
@property (nonatomic, strong) UIView *viewFranchise; //不计免赔
@property (nonatomic, strong) UIView *viewTag; //投保;
@end
@implementation PriceAdjustTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        isFranchise = NO;
        isOpenToubao = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        
        self.labelFranchise = [[UILabel alloc] init];
        self.imageViewFranchise = [[UIImageView alloc] init];
        self.viewFranchise = [[UIView alloc] init];
        [self.viewFranchise addSubview:self.labelFranchise];
        [self.viewFranchise addSubview:self.imageViewFranchise];
        [self.contentView addSubview:self.viewFranchise];
        self.viewFranchise.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setFranchise:)];
        [self.viewFranchise addGestureRecognizer:tapGest];
    
        self.labelTag = [[UILabel alloc] init];
        self.imageViewParentheses = [[UIImageView alloc] init];
        self.viewTag = [[UIView alloc] init];
        [self.viewTag addSubview:self.labelTag];
        [self.viewTag addSubview:self.imageViewParentheses];
        [self.contentView addSubview:self.viewTag];
        self.viewTag.userInteractionEnabled = YES;
        UITapGestureRecognizer *tagTapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setToubao:)];
        [self.viewTag addGestureRecognizer:tagTapGest];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, 200 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    
    
    self.viewFranchise.frame = CGRectMake(300 * ViewRateBaseOnIP6, 0, 150 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
    self.imageViewFranchise.frame = CGRectMake(0, 24 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6);
    
    self.labelFranchise.frame = CGRectMake(50  * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6, 23 * ViewRateBaseOnIP6);
    self.labelFranchise.font = [UIFont systemFontOfSize:23 * ViewRateBaseOnIP6];
    self.labelFranchise.text = @"不计免赔";
    
    self.viewTag.frame = CGRectMake(SCREEN_WIDTH - 223 * ViewRateBaseOnIP6, 0, 173 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
    self.labelTag.frame = CGRectMake(0, 32 * ViewRateBaseOnIP6, 150 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6);
    self.labelTag.textColor = [UIColor colorWithHexString:@"#838383"];
    self.labelTag.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    self.labelTag.textAlignment = NSTextAlignmentRight;
    
    self.imageViewParentheses.frame = CGRectMake(CGRectGetMaxX(self.labelTag.frame) + 16 * ViewRateBaseOnIP6, 35 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 14 * ViewRateBaseOnIP6);
    self.imageViewParentheses.image = [UIImage imageNamed:@"3"];
    
}
- (void)hiddenFranchiseView:(BOOL)isHidden{
    self.viewFranchise.hidden = isHidden;
    self.viewFranchise.hidden = isHidden;

}

- (void)franchiseIsSelect:(BOOL)isSelect{
    if (isSelect) {
        self.imageViewFranchise.image = [UIImage imageNamed:@"勾"];
        self.labelFranchise.textColor = [UIColor colorWithHexString:@"#838383"];
    } else {
        self.imageViewFranchise.image = [UIImage imageNamed:@"灰勾"];
        self.labelFranchise.textColor = [UIColor colorWithHexString:@"#e5e5e5"];
    }
    isFranchise = isSelect;
}

- (void)selectToubaoState:(BOOL)state{
    self.viewTag.userInteractionEnabled = state;
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

- (void)setFranchise:(UITapGestureRecognizer *)tap{
   
//    if (!isFranchise) {
//        self.imageViewFranchise.image = [UIImage imageNamed:@"勾"];
//        self.labelFranchise.textColor = [UIColor colorWithHexString:@"#838383"];
//    } else {
//        self.imageViewFranchise.image = [UIImage imageNamed:@"灰勾"];
//        self.labelFranchise.textColor = [UIColor colorWithHexString:@"#e5e5e5"];
//    }
    isFranchise = !isFranchise;
    [self.delegate getFranchiseState:isFranchise count:self.tag];
}

- (void)setToubao:(UITapGestureRecognizer *)tap{
    isOpenToubao = !isOpenToubao;
    [self.delegate openToubao:isOpenToubao count:self.tag];
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
