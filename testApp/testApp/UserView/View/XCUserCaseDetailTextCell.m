//
//  XCUserCaseDetailTextCell.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseDetailTextCell.h"
#import "UILabel+createLabel.h"
@interface XCUserCaseDetailTextCell()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topLine ;
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * labelArrM ;

/** <# 注释 #> */
@property (nonatomic, strong) UILabel * mutableTextLabel ;

@end

@implementation XCUserCaseDetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        _labelArrM = [[NSMutableArray alloc] init];
        _isMutableTextType = NO;
        [self configSubVies];
        [_titleLabel setText:@"刘某人伤案件理赔进度:"];
//        NSArray *titleArr = @[@"联系人: 刘先生",@"联系电话: 13369925025",@"案发时间: 2017年11月20日",@"提交时间: 2017年12月1日",@"咨询电话: 020-8888888"];
        NSArray *titleArr = @[@"投保人:",@"身份证:",@"车牌号:",
                              @"车架号:",@"初登日期:",@"发动机号:",
                              @"车型名称:",@"车险代码:",@"(商业)起保日期:",
                              @"(交强)起保日期",@"保险公司",@"缴费通知单号:",
                              @"交强险(保单)金额",@"商业险(保单)金额",@"交强保单最终金额:",
                              @"商业险保险最终金额",@"交强险保单:",@"商业险保单:",
                              @"交强佣佣金:",@"商业险佣金",@"出单员:",@"备注:"];
        [self setLabelArrM:titleArr];
        [_mutableTextLabel setText:@"描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中......"];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    
    [_topView setFrame:CGRectMake(0, 0, self.bounds.size.width, 20 * ViewRateBaseOnIP6 )];
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(leftMargin,CGRectGetMaxY(_topView.frame) + ((88 - 29) * ViewRateBaseOnIP6 ) * 0.5, labelSize.width, 29 * ViewRateBaseOnIP6)];
    [_topLine setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_topView.frame) + 88 * ViewRateBaseOnIP6, self.bounds.size.width - leftMargin * 2, 1)];
    
    CGFloat startY = CGRectGetMaxY(_topLine.frame);
    CGFloat topMargin = 30 * ViewRateBaseOnIP6;
    CGFloat labelTopMargin = 24 * ViewRateBaseOnIP6;
    if (_isMutableTextType) {
        [_mutableTextLabel sizeToFit];
        labelSize = _mutableTextLabel.frame.size;
        [_mutableTextLabel setFrame:CGRectMake(leftMargin, (startY + topMargin)  , 645 * ViewRateBaseOnIP6, labelSize.height)];
        if (_labelArrM.count > 0 ) {
            for (int i = 0 ; i < _labelArrM.count; i++) {
                UILabel *label = _labelArrM[i];
                [label setFrame:CGRectZero];
            }
        }
    }else {
        [_mutableTextLabel setFrame:CGRectZero];
        if (_labelArrM.count > 0 ) {
            for (int i = 0 ; i < _labelArrM.count; i++) {
                UILabel *label = _labelArrM[i];
                [label sizeToFit];
                labelSize = label.frame.size;
//                    [label setFrame:CGRectMake(leftMargin, (startY + topMargin + labelSize.height) + (labelTopMargin + labelSize.height) * (i - 1), labelSize.width, labelSize.height)];
                if (i == 0) {
                    [label setFrame:CGRectMake(leftMargin, (startY + topMargin)  , labelSize.width, 24 * ViewRateBaseOnIP6)];
                    
                }else {
                    [label setFrame:CGRectMake(leftMargin, (startY + topMargin) + 24 * ViewRateBaseOnIP6 + labelTopMargin + (labelTopMargin + 24 * ViewRateBaseOnIP6) * (i-1) , labelSize.width, 24 * ViewRateBaseOnIP6)];
                }
            }
            
        }
    }
  
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    
    _titleLabel = [UILabel createLabelWithTextFontSize:30 textColor:COLOR_RGB_255(68, 68, 68)  ];
    
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = COLOR_RGB_255(242, 242, 242);
    
    _mutableTextLabel = [[UILabel alloc] init];
    [_mutableTextLabel setTextColor:COLOR_RGB_255(136, 136, 136)];
    [_mutableTextLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]];
    _mutableTextLabel.numberOfLines = 0;
    [self addSubview:_topView];
    [self addSubview:_titleLabel];
    [self addSubview:_topLine];
    [self addSubview:_mutableTextLabel];
    
}



#pragma mark - Setter&Getter

- (void)setLabelArrM:(NSArray *)labelArr
{
    if (_labelArrM.count > 0) {
        for (UILabel * label in _labelArrM) {
            for (UIView *subView in self.subviews) {
                if ([label isEqual:subView]) {
                    [label removeFromSuperview];
                }
            }
        }
        [_labelArrM removeAllObjects];
    }
    for (int i = 0 ; i < labelArr.count; i++) {
        NSString *title = labelArr[i];
        UILabel *label = [UILabel createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(51, 51, 51)];
        [label setText:title];
        
        [self addSubview:label];
        [_labelArrM addObject:label];
    }
}

@end
