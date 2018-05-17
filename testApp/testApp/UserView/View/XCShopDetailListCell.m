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
/** 查看按钮 */
@property (nonatomic, strong) UIButton * detailButton;
/** tipsImagView */
@property (nonatomic, strong) UIImageView  * tipsImageView ;

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
    CGSize buttonSize = CGSizeMake(100 * ViewRateBaseOnIP6, 48 * ViewRateBaseOnIP6);

    CGSize labelSize;
    [_iconImageView setFrame:CGRectMake(leftMargin, 20 * ViewRateBaseOnIP6 , 295 * ViewRateBaseOnIP6, 295 * ViewRateBaseOnIP6)];

    [_serviceNameLabel sizeToFit];
    labelSize = _serviceNameLabel.frame.size;
    [_serviceNameLabel setFrame:CGRectMake((self.bounds.size.width - labelSize.width ) * 0.5, CGRectGetMaxY(_iconImageView.frame) +  20 * ViewRateBaseOnIP6, labelSize.width, 26 * ViewRateBaseOnIP6)];
    
    [_onSalePriceLabel sizeToFit];
    labelSize = _onSalePriceLabel.frame.size;
    if (labelSize.width > (68+62) * ViewRateBaseOnIP6) {
        labelSize.width = (68+62) * ViewRateBaseOnIP6 ;
    }
    [_onSalePriceLabel setFrame:CGRectMake(leftMargin + (68+62) * ViewRateBaseOnIP6 - labelSize.width, CGRectGetMaxY(_iconImageView.frame) + 66  * ViewRateBaseOnIP6 ,labelSize.width, 25 * ViewRateBaseOnIP6)];
    
    [_priceTitleLabel sizeToFit];
    labelSize = _priceTitleLabel.frame.size;
    [_priceTitleLabel setFrame:CGRectMake((68+62) * ViewRateBaseOnIP6 + 39  * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame) + 71 * ViewRateBaseOnIP6, labelSize.width, 19 * ViewRateBaseOnIP6)];
    
    [_priceLabel sizeToFit];
    labelSize = _priceLabel.frame.size;

    [_priceLabel setFrame: CGRectMake(CGRectGetMaxX(_priceTitleLabel.frame) + 5 * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame) + 72 * ViewRateBaseOnIP6, self.bounds.size.width - (CGRectGetMaxX(_priceTitleLabel.frame) + 5 * ViewRateBaseOnIP6 ),25 * ViewRateBaseOnIP6)];
    if ([self.model.status isEqualToString:@"待审核"]) { /// 审核中

        UIImage *tipsImage  = [UIImage imageNamed:@"greentap"];
        if (tipsImage) {
            [_tipsImageView setImage:tipsImage];
        }
        [_editedButton setFrame:CGRectZero];
        [_deleteButton setFrame:CGRectZero];
        [_detailButton setFrame:CGRectMake((self.frame.size.width - buttonSize.width) * 0.5, CGRectGetMaxY(_priceLabel.frame) + 20 * ViewRateBaseOnIP6, buttonSize.width, buttonSize.height)];
    }
    else if ([self.model.status isEqualToString:@"审核通过"]) { /// 上架中
        UIImage *tipsImage  = [UIImage imageNamed:@"bluetap"];
        if (tipsImage) {
            [_tipsImageView setImage:tipsImage];
        }
        [_editedButton setFrame:CGRectZero];
        [_deleteButton setFrame:CGRectZero];
        [_detailButton setFrame:CGRectMake((self.frame.size.width - buttonSize.width) * 0.5, CGRectGetMaxY(_priceLabel.frame) + 20 * ViewRateBaseOnIP6, buttonSize.width, buttonSize.height)];
    }
    else if ([self.model.status isEqualToString:@"审核不通过"]) { /// 已拒绝
        UIImage *tipsImage  = [UIImage imageNamed:@"redtap"];
        if (tipsImage) {
            [_tipsImageView setImage:tipsImage];
        }
        [_detailButton setFrame:CGRectMake(10 * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame) + 111 * ViewRateBaseOnIP6, buttonSize.width, buttonSize.height)];
        [_editedButton setFrame:CGRectMake(CGRectGetMaxX(_detailButton.frame)+ 8 * ViewRateBaseOnIP6, _detailButton.frame.origin.y, buttonSize.width, buttonSize.height)];
        [_deleteButton setFrame:CGRectMake(CGRectGetMaxX(_editedButton.frame)+ 7 * ViewRateBaseOnIP6, _detailButton.frame.origin.y, buttonSize.width, buttonSize.height)];
        
    }
    else if ([self.model.status isEqualToString:@"下架"]) {
        UIImage *tipsImage  = [UIImage imageNamed:@"yellowtap"];
        if (tipsImage) {
            [_tipsImageView setImage:tipsImage];
        }
//        [_detailButton setFrame:CGRectMake(40 * ViewRateBaseOnIP6, CGRectGetMaxY(_iconImageView.frame) + 111 * ViewRateBaseOnIP6, buttonSize.width, buttonSize.height)];
//        [_editedButton setFrame:CGRectZero];
//        [_deleteButton setFrame:CGRectZero];
//        [_deleteButton setFrame:CGRectMake(CGRectGetMaxX(_detailButton.frame) + 55 * ViewRateBaseOnIP6, _detailButton.frame.origin.y, buttonSize.width, buttonSize.height)];
        [_editedButton setFrame:CGRectZero];
        [_deleteButton setFrame:CGRectZero];
        [_detailButton setFrame:CGRectMake((self.frame.size.width - buttonSize.width) * 0.5, CGRectGetMaxY(_priceLabel.frame) + 20 * ViewRateBaseOnIP6, buttonSize.width, buttonSize.height)];
    }
        labelSize = CGSizeMake(70 * ViewRateBaseOnIP6, 70 * ViewRateBaseOnIP6);
    [_tipsImageView setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    
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
    [_iconImageView setContentMode:UIViewContentModeScaleToFill];
    _tipsImageView = [[UIImageView alloc] init];
    
    _serviceNameLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(51, 51, 51)];
    _onSalePriceLabel = [UILabel createLabelWithTextFontSize:32 textColor:COLOR_RGB_255(247, 44, 11)];
    _priceTitleLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(165, 165, 165)];
    [_priceTitleLabel setText:@"原价"];
    _priceLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(165, 165, 165)];
    
    _editedButton = [self createButtonWithTitle:@"编辑" TitleColor:COLOR_RGB_255(1, 77, 163) action:@selector(clickEditBtn:)];
    _deleteButton = [self createButtonWithTitle:@"删除" TitleColor:COLOR_RGB_255(1, 77, 163) action:@selector(clickDeleteBtn:)];
    _detailButton = [self createButtonWithTitle:@"查看" TitleColor:[UIColor whiteColor] action:@selector(clickDetailBtn:)];
    [_detailButton setBackgroundColor:COLOR_RGB_255(1, 77, 163)];

    
    [self.contentView  addSubview:_iconImageView];
    [self.contentView  addSubview:_tipsImageView];
    [self.contentView  addSubview:_serviceNameLabel];
    [self.contentView  addSubview:_priceTitleLabel];
    [self.contentView  addSubview:_priceLabel];
    [self.contentView  addSubview:_onSalePriceLabel];
    [self.contentView  addSubview:_detailButton];
    [self.contentView  addSubview:_editedButton];
    [self.contentView  addSubview:_deleteButton];
    
    
}

#pragma mark - Action Method
- (UIButton *)createButtonWithTitle:(NSString *)title TitleColor:(UIColor *)color action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.layer.cornerRadius = 23  * ViewRateBaseOnIP6;
    button.layer.borderColor = COLOR_RGB_255(1, 77, 163).CGColor;
    button.layer.borderWidth = 1;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)clickEditBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopDetailListCellClickEditedButton:serviceModel:)]) {
        [self.delegate XCShopDetailListCellClickEditedButton:button serviceModel:_model];
    }
}

- (void)clickDeleteBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopDetailListCellClickDeleteButton:serviceModel:WithCell:)]) {
        [self.delegate XCShopDetailListCellClickDeleteButton:button serviceModel:_model WithCell:self];
    }
}

- (void)clickDetailBtn:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopDetailListCellClickDetailButton:serviceModel:)]) {
        [self.delegate XCShopDetailListCellClickDetailButton:button serviceModel:_model ];
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
    if (isUsable(model.vipPrice, [NSNumber class])) {
        [_onSalePriceLabel setText:[NSString stringWithFormat:@"¥%@",model.vipPrice.stringValue]];
    }
    if (isUsable(model.price, [NSNumber class])) {
        NSString *priceStr = [NSString stringWithFormat:@"¥%@",model.price.stringValue];
        NSMutableAttributedString * ma_price = [[NSMutableAttributedString alloc] initWithString:priceStr];
        [ma_price addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6] range:NSMakeRange(0,priceStr.length)];
        [ma_price addAttribute:NSForegroundColorAttributeName value:COLOR_RGB_255(165, 165, 165) range:NSMakeRange(0,priceStr.length)];
        [ma_price addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,priceStr.length )];
       _priceLabel.attributedText = ma_price;
       _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    [self layoutSubviews];
    
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
