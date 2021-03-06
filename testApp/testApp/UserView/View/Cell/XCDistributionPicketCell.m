//
//  XCDistributionPicketCell.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCDistributionPicketCell.h"
#import "XCShopModel.h"
#import "UILabel+createLabel.h"
@interface XCDistributionPicketCell()

/** <# 注释 #> */
@property (nonatomic, strong) UILabel * valueLabel ;
/** 右箭头 */
@property (nonatomic, strong) UIButton * extendBtn ;

@property (nonatomic, strong) UIView * separtatorLine ;

@end

@implementation XCDistributionPicketCell
+(CGFloat)getCellHeight
{
    return 88 * ViewRateBaseOnIP6;
}
#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width,labelSize.height)];
    
    CGFloat valueLabelLeftMargin = 16 * ViewRateBaseOnIP6;
    if (_shouldShowArrow) {
        labelSize = CGSizeMake(20 * ViewRateBaseOnIP6, 36 * ViewRateBaseOnIP6);
        [_extendBtn setFrame:CGRectMake(self.frame.size.width - (labelSize.width +  30 * ViewRateBaseOnIP6), (self.frame.size.height - labelSize.height) * 0.5 , labelSize.width, labelSize.height)];
    }else {
        labelSize = CGSizeMake(0.1, 0.1);
        [_extendBtn setFrame:CGRectMake(self.frame.size.width - (labelSize.width +  30 * ViewRateBaseOnIP6), (self.frame.size.height - labelSize.height) * 0.5 , labelSize.width, labelSize.height)];
        valueLabelLeftMargin = 0;
    }
    
    [_valueLabel sizeToFit];
    labelSize = _valueLabel.frame.size;
    [_valueLabel setFrame:CGRectMake(CGRectGetMinX(_extendBtn.frame) - valueLabelLeftMargin - labelSize.width , (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width,labelSize.height)];
    if (_shouldShowSeparator) {
        if (_isCenterSeparator) {
            [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - (30 * ViewRateBaseOnIP6) * 2, 1)];
        }else {
            [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
        }
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _shouldShowSeparator = YES;
        _isCenterSeparator = NO;
        _shouldShowArrow = YES ;
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    _titleLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(51, 51, 51)];
    _valueLabel = [UILabel createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(165, 165, 165)];
    _extendBtn = [UIButton buttonWithType:0];
    [_extendBtn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_extendBtn addTarget:self action:@selector(clickArrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_titleLabel];
    [self addSubview:_valueLabel];
    [self addSubview:_extendBtn];
    [self addSubview:_separtatorLine];

}

#pragma mark - Action Method

- (void)clickArrowBtn:(UIButton *)button
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(XCDistributionPicketCellClickArrowBtn:title:cell:)]) {
        [self.delegate XCDistributionPicketCellClickArrowBtn:button title:self.titleLabel.text cell:self];
    }
}

- (void)setupCellWithShopModel:(XCShopModel *)model
{
//    if ([self.title isEqualToString:@"所属城市"]&&isUsableNSString(model.city, @"")) {
//        [self.valueLabel setText:model.city];
//    }else if ([self.title isEqualToString:@"所在地区"]&&isUsableNSString(model.area, @"")) {
//        [self.valueLabel setText:model.area];
//    }
//    else
        if ([_titleLabel.text isEqualToString:@"门店标签"]) {
        
        NSMutableArray *labelArr = [[NSMutableArray alloc] init];
        if (isUsableNSString(model.label1, @"")) {
            [labelArr addObject:model.label1];
        }
        if (isUsableNSString(model.label2, @"")) {
            [labelArr addObject:model.label2];
        }
        if (isUsableNSString(model.label3, @"")) {
            [labelArr addObject:model.label3];
        }
        if (isUsableNSString(model.label4, @"")) {
            [labelArr addObject:model.label4];
        }
        if (isUsableNSString(model.label5, @"")) {
            [labelArr addObject:model.label5];
        }
        NSString *labelStr = [labelArr componentsJoinedByString:@"、"];
        [self.valueLabel setText:labelStr];
    }
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (void)setTitle:(NSString *)title
{

    _title = title;
//    [_titleLabel setText:_title];
    _titleLabel.attributedText = [NSString stringWithImportentValue:title];
    [_titleLabel sizeToFit];
    
}

-(void)setTitleValue:(NSString *)titleValue
{
    _titleValue = titleValue;
    [_valueLabel setText:_titleValue];
    [_valueLabel sizeToFit];
}

@end
