//
//  XCShopServiceAddsServiceFooterView.m
//  testApp
//
//  Created by Melody on 2018/5/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceAddsServiceFooterView.h"
#import "UILabel+createLabel.h"
@interface XCShopServiceAddsServiceFooterView ()

/** <# 注释 #> */
@property (nonatomic, strong)  UILabel* tipsLabel ;

@end
@implementation XCShopServiceAddsServiceFooterView

+ (CGFloat)getFooterViewHeight
{
    return 30 * ViewRateBaseOnIP6;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _tipsLabel = [UILabel createLabelWithTextFontSize:24 textColor:COLOR_RGB_255(153, 153, 153)];
        [_tipsLabel setText:@"*只能单选"];
        [self.contentView addSubview:_tipsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_tipsLabel sizeToFit];
    CGSize labeSize = _tipsLabel.frame.size;
    [_tipsLabel setFrame:CGRectMake(self.bounds.size.width - 30 * ViewRateBaseOnIP6 - labeSize.width, 10 * ViewRateBaseOnIP6, labeSize.width, 23 * ViewRateBaseOnIP6)];
}
@end
