//
//  XCUserCaseDetailProgressCell.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseDetailProgressCell.h"

@interface XCUserCaseDetailProgressCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * iconImageView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * processLabel ;
@end

@implementation XCUserCaseDetailProgressCell
+ (CGFloat)getCellHeight
{
    return 120 * ViewRateBaseOnIP6;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _processStrArr = @[@"服务完成",@"案件处理中..."];
        [self configSubVies];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configSubVies
{
    _iconImageView = [[UIImageView alloc] init];
    _processLabel = [self createLabelWithTextFontSize:36 textColor:COLOR_RGB_255(1, 77, 163)];
    
    [self addSubview:_iconImageView];
    [self addSubview:_processLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = CGSizeMake(56 * ViewRateBaseOnIP6, 56 * ViewRateBaseOnIP6);
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [_iconImageView setFrame:CGRectMake(leftMargin , (self.bounds.size.height - size.height ) * 0.5, size.width, size.height)];
    [_processLabel sizeToFit];
    size = _processLabel.frame.size;
    [_processLabel setFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 40 * ViewRateBaseOnIP6, (self.bounds.size.height - 34 * ViewRateBaseOnIP6) * 0.5, size.width, 34 * ViewRateBaseOnIP6)];
    
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method
- (UILabel *)createLabelWithTextFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:fontSize * ViewRateBaseOnIP6]];
    [label setTextColor:textColor];
    return label;
}

- (void)updateProcessType
{
    if (_isFinish) {
        UIImage *finishImage = [UIImage imageNamed:@"完成"];
        [_iconImageView setImage:finishImage];
    }else {
        UIImage *unFinishImage = [UIImage imageNamed:@"未完成"];
        [_iconImageView setImage:unFinishImage];
    }
    [self layoutSubviews];
}

#pragma mark - Setter&Getter

- (void)setIsFinish:(BOOL)isFinish
{
    _isFinish = isFinish;
    [self updateProcessType];
}

- (void)setProcessStr:(NSString *)processStr
{
    _processStr = processStr;
    [_processLabel setText:processStr];
}

- (void)setProcessStrArr:(NSArray *)processStrArr
{
    NSMutableArray *tmpArrM = [[NSMutableArray alloc] init];
    
    if (processStrArr.count >= 2) {
        for (int i = 0 ; i < 2; i++) {
            NSString *name = processStrArr[i];
            [tmpArrM addObject:name];
        }
        _processStrArr  = tmpArrM;
    }
    [self updateProcessType];
}

@end
