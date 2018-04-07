//
//  XCCheckoutDetailPhotoCell.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailPhotoCell.h"
@interface XCCheckoutDetailPhotoCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UIScrollView * scrollview ;
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * addPhotoImageView ;
@end

@implementation XCCheckoutDetailPhotoCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:[UIFont systemFontOfSize:26 * ViewRateBaseOnIP6]];
    [_titleLabel setTextColor:COLOR_RGB_255(68, 68, 68)];
    [self addSubview:_titleLabel];
    
    _addPhotoImageView = [[UIImageView alloc] initWithImage:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddImageView:)];
    [_addPhotoImageView addGestureRecognizer:tap];
    _scrollview = [[UIScrollView alloc] init];
    _scrollview.userInteractionEnabled = YES;
    [_scrollview addSubview:_scrollview];

    [self addSubview:_scrollview];
//    _separtatorLine = [[UIView alloc] init];
//    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
//    [self addSubview:_separtatorLine];
    
}


#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, 0, labelSize.width, labelSize.height)];
    
    
}
#pragma mark - Action Method

- (void)clickAddImageView:(UIImageView * )addImageView
{
    
}

- (void)clickImageView:(UIImageView *)imageView
{
    
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

-(void)setPhotoArr:(NSArray *)photoArr
{
    if (photoArr.count > 0) {
        [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGFloat imageViewW  = 60 * ViewRateBaseOnIP6;
        
        for (int i = 0 ; i < photoArr.count; i++) {
            UIImage *image = photoArr[i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setFrame:CGRectMake(i * imageViewW , 0, imageViewW, imageViewW)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
            [imageView addGestureRecognizer:tap];
            [_scrollview addSubview:imageView];
        }
        [_addPhotoImageView setFrame:CGRectMake(photoArr.count * imageViewW, 0, imageViewW, imageViewW)];
        [_scrollview addSubview:_addPhotoImageView];
    }
}
@end
