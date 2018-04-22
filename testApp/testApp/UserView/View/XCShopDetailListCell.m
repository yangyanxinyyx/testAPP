//
//  XCShopDetailListCell.m
//  testApp
//
//  Created by Melody on 2018/4/10.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopDetailListCell.h"
#import "UILabel+createLabel.h"
#import "XCShopServiceModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XCShopDetailListCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * iconImageView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * serviceNameLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * onSalePriceLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * priceLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * editedButton ;
/**  */
@property (nonatomic, strong) XCShopServiceModel * model ;

@end
@implementation XCShopDetailListCell

+(CGFloat)getCellHeigth
{
    return((336 + 158) * ViewRateBaseOnIP6);
}

#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 20 * ViewRateBaseOnIP6;
    [_iconImageView setFrame:CGRectMake(leftMargin, 20 * ViewRateBaseOnIP6 , 296 * ViewRateBaseOnIP6, 296 * ViewRateBaseOnIP6)];
    CGSize labelSize;
    [_serviceNameLabel sizeToFit];
    labelSize = _serviceNameLabel.frame.size;
    [_serviceNameLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_iconImageView.frame) +  30 * ViewRateBaseOnIP6, labelSize.width, 26 * ViewRateBaseOnIP6)];
    [_priceLabel sizeToFit];
    labelSize = _priceLabel.frame.size;
    [_priceLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_serviceNameLabel.frame) + 30 * ViewRateBaseOnIP6 , labelSize.width, 25 * ViewRateBaseOnIP6)];
    [_onSalePriceLabel sizeToFit];
    labelSize = _onSalePriceLabel.frame.size;
    [_onSalePriceLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_priceLabel.frame) + 16 * ViewRateBaseOnIP6, labelSize.width, 23 * ViewRateBaseOnIP6)];
    
    labelSize = CGSizeMake(100 * ViewRateBaseOnIP6, 48 * ViewRateBaseOnIP6);
    [_editedButton setFrame:CGRectMake(self.bounds.size.width - 20 * ViewRateBaseOnIP6 - labelSize.width, self.bounds.size.height - labelSize.height - 30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
}
#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self configureSubViews];
    }
    return self;
}

-(void)configureSubViews
{
    _iconImageView = [[UIImageView alloc] init];
    _serviceNameLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(51, 51, 51)];
    _priceLabel = [UILabel createLabelWithTextFontSize:32 textColor:COLOR_RGB_255(247, 44, 11)];
    _onSalePriceLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(165, 165, 165)];
    
    _editedButton = [UIButton buttonWithType:0];
    [_editedButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _editedButton.layer.cornerRadius = 12;
    [_editedButton setBackgroundColor:COLOR_RGB_255(1, 77, 163)];
    [_editedButton addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_iconImageView];
    [self addSubview:_serviceNameLabel];
    [self addSubview:_priceLabel];
    [self addSubview:_onSalePriceLabel];
    [self addSubview:_editedButton];
    
}

#pragma mark - Action Method

- (void)clickEditBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopDetailListCellClickEditedButton:serviceModel:)]) {
        [self.delegate XCShopDetailListCellClickEditedButton:button serviceModel:_model];
    }
}

- (void)setupCellWithModel:(XCShopServiceModel *)model
{
    _model = model;
    if (isUsableNSString(model.url1, @"")) {
        NSURL *imageURL = [[NSURL alloc] initWithString:model.url1];
        if (imageURL) {
            [_iconImageView sd_setImageWithURL:imageURL];
        }
    }
    if (isUsableNSString(model.serviceName, @"")) {
        [_serviceNameLabel setText:model.serviceName];
    }
    if (isUsableNSString(model.vipPrice, @"")) {
        
        [_priceLabel setText:[NSString stringWithFormat:@"¥ %@",model.vipPrice]];
    }
    if (isUsableNSString(model.price, @"")) {
        
        NSString *titleStr = @"原价 ";
        NSMutableAttributedString * ma_price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@¥%@",titleStr,model.price]];
        [ma_price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24 * ViewRateBaseOnIP6] range:NSMakeRange(0, titleStr.length + model.price.length)];
        [ma_price addAttribute:NSForegroundColorAttributeName value:COLOR_RGB_255(165, 165, 165) range:NSMakeRange(0, titleStr.length + model.price.length)];
        [ma_price addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange( titleStr.length+1, model.price.length)];
       _onSalePriceLabel.attributedText = ma_price;
//        [_onSalePriceLabel setText:model.price];
    }
    
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
