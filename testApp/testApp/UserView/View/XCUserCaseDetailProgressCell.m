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
    _processLabel = [self createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(0, 0, 255)];
    
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
        [_processLabel setText:[_processStrArr firstObject]];
        UIImage *finishImage = [UIImage imageNamed:@"完成"];
        [_iconImageView setImage:finishImage];
    }else {
        [_processLabel setText:[_processStrArr lastObject]];
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
