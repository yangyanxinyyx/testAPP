//
//  XCDistributionInputCell.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCDistributionInputCell.h"
@interface XCDistributionInputCell ()
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UIImageView * selectImageView ;
@end
@implementation XCDistributionInputCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(0, 72, 162)];
    [self addSubview:_titleLabel];
    
    _selectImageView = [[UIImageView alloc] init];
    [_selectImageView setUserInteractionEnabled:YES];
    UIImage *unContinueImage = [UIImage imageNamed:@"unSelect"];
    _selectImageView.image = unContinueImage;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeContinueValue:)];
    [_selectImageView addGestureRecognizer:tap];
    [self addSubview:_selectImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel sizeToFit];
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labelSize.height) * 0.5, labelSize.width,24 * ViewRateBaseOnIP6)];
    
    CGFloat imageViewH = 40 * ViewRateBaseOnIP6;
    [_selectImageView setFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 29 * ViewRateBaseOnIP6, (self.bounds.size.height - imageViewH ) * 0.5, imageViewH, imageViewH)];
}

- (void)changeContinueValue:(UIButton *)button
{
    _isSelect = !_isSelect;
    NSString *imageString  = nil;
    if (_isSelect) {
        imageString = @"select";
    }else {
        imageString = @"unSelect";
    }
    UIImage *image = [UIImage imageNamed:imageString];
    if (image) {
        [_selectImageView setImage:image];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCDistributionInputCellClickSelectView:)]) {
        [self.delegate XCDistributionInputCellClickSelectView:_isSelect];
    }else {
        NSLog(@"Error: - (void)changeContinueValue: delegate was nil");

    }
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
