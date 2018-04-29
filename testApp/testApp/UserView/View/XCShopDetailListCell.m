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
/** 图标 */
@property (nonatomic, strong) UIImageView * iconImageView ;
/** 服务名称 */
@property (nonatomic, strong) UILabel * serviceNameLabel ;
/** 优惠价 */
@property (nonatomic, strong) UILabel * onSalePriceLabel ;
/** 原价 */
@property (nonatomic, strong) UILabel * priceLabel ;
/** 原价Title */
@property (nonatomic, strong) UILabel * priceTitleLabel ;
/** 编辑按钮 */
@property (nonatomic, strong) UIButton * editedButton ;
/** 删除按钮 */
@property (nonatomic, strong) UIButton * deleteButton ;
/**  */
@property (nonatomic, strong) XCShopServiceModel * model ;

@end
@implementation XCShopDetailListCell

+(CGFloat)getCellHeigth
{
    return((474) * ViewRateBaseOnIP6);
}

#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 20 * ViewRateBaseOnIP6;
    [_iconImageView setFrame:CGRectMake(leftMargin, 20 * ViewRateBaseOnIP6 , 280 * ViewRateBaseOnIP6, 280 * ViewRateBaseOnIP6)];
    CGSize labelSize;
    
    [_serviceNameLabel sizeToFit];
    labelSize = _serviceNameLabel.frame.size;
    [_serviceNameLabel setFrame:CGRectMake((self.bounds.size.width - labelSize.width ) * 0.5, CGRectGetMaxY(_iconImageView.frame) +  20 * ViewRateBaseOnIP6, labelSize.width, 26 * ViewRateBaseOnIP6)];
    
    [_onSalePriceLabel sizeToFit];
    labelSize = _onSalePriceLabel.frame.size;
    [_onSalePriceLabel setFrame:CGRectMake((60 + 15 ) * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame) + 65 * ViewRateBaseOnIP6 , labelSize.width, 25 * ViewRateBaseOnIP6)];
    
    [_priceTitleLabel sizeToFit];
    labelSize = _priceTitleLabel.frame.size;
    [_priceTitleLabel setFrame:CGRectMake(CGRectGetMaxX(_onSalePriceLabel.frame) + 22 * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame) + 71 * ViewRateBaseOnIP6, labelSize.width, 19 * ViewRateBaseOnIP6)];
    
    [_priceLabel sizeToFit];
    labelSize = _priceLabel.frame.size;
    [_priceLabel setFrame: CGRectMake(CGRectGetMaxX(_priceTitleLabel.frame) + 9 * ViewRateBaseOnIP6, _priceTitleLabel.frame.origin.y, self.bounds.size.width - (CGRectGetMaxX(_priceTitleLabel.frame) + 9 * ViewRateBaseOnIP6), 23 * ViewRateBaseOnIP6)];
    labelSize = CGSizeMake(100 * ViewRateBaseOnIP6, 48 * ViewRateBaseOnIP6);
    [_editedButton setFrame:CGRectMake( 40 * ViewRateBaseOnIP6 , CGRectGetMaxY(_iconImageView.frame)  + 106 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_deleteButton setFrame:CGRectMake(CGRectGetMaxX(_editedButton.frame) + 47 * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame)  + 106 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];

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
    [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    _serviceNameLabel = [UILabel createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(51, 51, 51)];
    _onSalePriceLabel = [UILabel createLabelWithTextFontSize:30 textColor:COLOR_RGB_255(247, 44, 11)];
    _priceTitleLabel = [UILabel createLabelWithTextFontSize:20 textColor:COLOR_RGB_255(165, 165, 165)];
    [_priceTitleLabel setText:@"原价"];
    _priceLabel = [UILabel createLabelWithTextFontSize:23 textColor:COLOR_RGB_255(165, 165, 165)];
    
    _editedButton = [UIButton buttonWithType:0];
    [_editedButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _editedButton.layer.cornerRadius = 23  * ViewRateBaseOnIP6;
    [_editedButton setBackgroundColor:COLOR_RGB_255(1, 77, 163)];
    [_editedButton addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteButton= [UIButton buttonWithType:0];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:COLOR_RGB_255(1, 77, 163) forState:UIControlStateNormal];
    _deleteButton.layer.cornerRadius = 23  * ViewRateBaseOnIP6;
    _deleteButton.layer.borderColor = COLOR_RGB_255(1, 77, 163).CGColor;
    _deleteButton.layer.borderWidth = 1;
    [_deleteButton setBackgroundColor:[UIColor whiteColor]];
    [_deleteButton addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self addSubview:_iconImageView];
    [self addSubview:_serviceNameLabel];
    [self addSubview:_priceTitleLabel];
    [self addSubview:_priceLabel];
    [self addSubview:_onSalePriceLabel];
    [self addSubview:_editedButton];
    [self addSubview:_deleteButton];
    
}

#pragma mark - Action Method

- (void)clickEditBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopDetailListCellClickEditedButton:serviceModel:)]) {
        [self.delegate XCShopDetailListCellClickEditedButton:button serviceModel:_model];
    }
}

- (void)clickDeleteBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopDetailListCellClickDeleteButton:serviceModel:)]) {
        [self.delegate XCShopDetailListCellClickDeleteButton:button serviceModel:_model];
    }
}

- (void)setupCellWithModel:(XCShopServiceModel *)model
{
    _model = model;
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolder"];

    [_iconImageView setImage:placeHolderImage];
    if (isUsableNSString(model.url1, @"")) {
        NSURL *imageURL = [[NSURL alloc] initWithString:model.url1];
        if (imageURL) {
            [_iconImageView sd_setImageWithURL:imageURL placeholderImage:placeHolderImage];
        }
    }
    if (isUsableNSString(model.serviceName, @"")) {
        [_serviceNameLabel setText:model.serviceName];
    }
    if (isUsableNSString(model.vipPrice, @"")) {
        [_onSalePriceLabel setText:[NSString stringWithFormat:@"¥%@",model.vipPrice]];
    }
    if (isUsableNSString(model.price, @"")) {
        NSMutableAttributedString * ma_price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.price]];
        [ma_price addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:23 * ViewRateBaseOnIP6] range:NSMakeRange(0,model.price.length)];
        [ma_price addAttribute:NSForegroundColorAttributeName value:COLOR_RGB_255(165, 165, 165) range:NSMakeRange(0,1 +model.price.length)];
        [ma_price addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0, model.price.length + 1)];
       _priceLabel.attributedText = ma_price;
       _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    [self layoutSubviews];
    
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
