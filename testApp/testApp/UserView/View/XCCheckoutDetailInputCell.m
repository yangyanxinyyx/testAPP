//
//  XCCheckoutDetailInputCell.m
//  testApp
//
//  Created by Melody on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailInputCell.h"

@interface XCCheckoutDetailInputCell ()

@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UIImageView * continueView ;

@end

@implementation XCCheckoutDetailInputCell


#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel sizeToFit];
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width,24 * ViewRateBaseOnIP6)];
    
    CGFloat imageViewH = 40 * ViewRateBaseOnIP6;
    [_continueView setFrame:CGRectMake(_titleLabel.frame.origin.x + labelSize.width + 25 * ViewRateBaseOnIP6, (self.bounds.size.height - imageViewH ) * 0.5, imageViewH, imageViewH)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubVies];
    }
    return self;
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_titleLabel];
    
    _continueView = [[UIImageView alloc] init];
    UIImage *unContinueImage = [UIImage imageNamed:@"unSelect"];
    _continueView.image = unContinueImage;
    [self addSubview:_continueView];
}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title]) {
        return;
    }
    _title = title;
    [_titleLabel setText:_title];
    [_titleLabel sizeToFit];
}

- (void)setIsContinue:(BOOL)isContinue
{
    _isContinue = isContinue;
    
    NSString *imageString  = nil;
    if (_isContinue) {
        imageString = @"select";
    }else {
        imageString = @"unSelect";
    }
    UIImage *image = [UIImage imageNamed:imageString];
    if (image) {
        [_continueView setImage:image];
    }
}

@end
