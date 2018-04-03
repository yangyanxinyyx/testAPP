
//
//  PriceInfoCellView.m
//  testApp
//
//  Created by 严玉鑫 on 2018/4/3.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInfoCellView.h"

@interface PriceInfoCellView ()
{
    NSString *text;
}
@end

@implementation PriceInfoCellView

- (instancetype)initWithFrame:(CGRect)frame withLabelNameText:(NSString *)labelNameText{
    if (self = [super initWithFrame:frame]) {
        text = labelNameText;
        [self addSubview:self.labelName];
        [self addSubview:self.labelContent];
    }
    return self;
}

- (UILabel *)labelName{
    if (!_labelName) {
        _labelName = [[UILabel alloc] init];
        _labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 0, 0, 26 * ViewRateBaseOnIP6);
        _labelName.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
        _labelName.text = text;
        [_labelName sizeToFit];
        _labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 0, CGRectGetWidth(_labelName.frame), 26 * ViewRateBaseOnIP6);
        _labelName.textColor = [UIColor colorWithHexString:@"#444444"];
        
    }
    return _labelName;
}

- (UILabel *)labelContent{
    if (!_labelContent) {
        _labelContent = [[UILabel alloc] initWithFrame:CGRectMake(50 * ViewRateBaseOnIP6 + CGRectGetWidth(self.labelName.frame), 0, SCREEN_WIDTH -(80 * ViewRateBaseOnIP6 + CGRectGetWidth(self.labelName.frame)) , 26 * ViewRateBaseOnIP6)];
        _labelContent.textColor = [UIColor colorWithHexString:@"#838383"];
        _labelContent.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    
    }
    return _labelContent;
}
@end
