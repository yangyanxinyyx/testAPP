//
//  XCCheckoutDetailPhotoCell.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailPhotoCell.h"
#import "UILabel+createLabel.h"
#import "XCShopModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XCCheckoutDetailPhotoCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UIScrollView * scrollview ;
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * addPhotoImageView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * separtatorLine ;
@end

@implementation XCCheckoutDetailPhotoCell

+ (CGFloat)getCellHeight
{
    return (88 + 160) * ViewRateBaseOnIP6;
}

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _maxPhoto = 1;
        [self configSubVies];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"tap");
}
- (void)configSubVies
{
    _titleLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(51, 51, 51)];
    
    UIImage *addImage = [UIImage imageNamed:@"添加图片"];
    _addPhotoImageView = [[UIImageView alloc] initWithImage:nil];
    _addPhotoImageView.image = addImage;
    [_addPhotoImageView setBackgroundColor:COLOR_RGB_255(234, 234, 234)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddImageView:)];
    [_addPhotoImageView addGestureRecognizer:tap];
    [_addPhotoImageView setUserInteractionEnabled:YES];
    _scrollview = [[UIScrollView alloc] init];
    _scrollview.userInteractionEnabled = YES;
    
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    
    [self addSubview:_titleLabel];
    [self addSubview:_scrollview];
    [self addSubview:_separtatorLine];
    
}


#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(leftMargin, 30 * ViewRateBaseOnIP6, labelSize.width, 29 * ViewRateBaseOnIP6)];
    labelSize = CGSizeMake(self.bounds.size.width - leftMargin * 2, 140 * ViewRateBaseOnIP6);
    [_scrollview setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_titleLabel.frame) + 18 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_scrollview setContentSize:CGSizeMake(_maxPhoto * 140 * ViewRateBaseOnIP6, 0)];
    labelSize = CGSizeMake(140 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6);
    if (_scrollview.subviews.count > 1) {
        if ((_scrollview.subviews.count - 1) >= _maxPhoto) {
            [_addPhotoImageView setFrame:CGRectZero];
            for (int i = 0 ; i < (_scrollview.subviews.count - 1); i++) {
                UIImageView *imageView = _scrollview.subviews[i];
                [imageView setFrame:CGRectMake(labelSize.width * i, 0, labelSize.width, labelSize.height)];
            }
        }else {
            for (int i = 0 ; i < _scrollview.subviews.count; i++) {
                UIImageView *imageView = _scrollview.subviews[i];
                [imageView setFrame:CGRectMake(labelSize.width * i, 0, labelSize.width, labelSize.height)];
            }
        }
    }else {
        if (![_addPhotoImageView superview]) {
            [_scrollview addSubview:_addPhotoImageView];
        }
        [_addPhotoImageView setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    }
}
#pragma mark - Action Method

- (void)clickAddImageView:(UIImageView * )addImageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailPhotoCellClickAddPhotosImageView:cell:)]) {
        [self.delegate XCCheckoutDetailPhotoCellClickAddPhotosImageView:addImageView cell:self];
    }
}

- (void)clickImageView:(UIImageView *)imageView
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailPhotoCellClickphotoImageView:index:cell:)]) {
       NSInteger index =   [_scrollview.subviews indexOfObject:imageView];
        if (index ) {
            [self.delegate XCCheckoutDetailPhotoCellClickphotoImageView:imageView.image index:index cell:self];
        }
    }
}

- (void)setupCellWithShopModel:(XCShopModel *)model
{
    if ([self.title isEqualToString:@"营业执照上传,1张"]&& isUsableNSString(model.licenseUrl, @"")) {
        NSURL *licenseURL = [NSURL URLWithString:model.licenseUrl];
        if (licenseURL) {
            self.photoArr = @[licenseURL];
        }
    }
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

-(void)setPhotoArr:(NSArray *)photoArr
{
    if (photoArr.count > 0) {
        [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGFloat imageViewW  = 60 * ViewRateBaseOnIP6;
        
        for (int i = 0 ; i < photoArr.count; i++) {
            NSURL *imageURL = photoArr[i];
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:imageURL];
            [imageView setFrame:CGRectMake(i * imageViewW , 0, imageViewW, imageViewW)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
            [imageView addGestureRecognizer:tap];
            [_scrollview addSubview:imageView];
        }
        [_addPhotoImageView setFrame:CGRectMake(photoArr.count * imageViewW, 0, imageViewW, imageViewW)];
        [_scrollview addSubview:_addPhotoImageView];
        [self layoutSubviews];
    }
}

-(void)updateLocalPhotoArr:(NSArray<UIImage *> *)photoArr
{
    if (photoArr.count > 0) {
        [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGFloat imageViewW  = 60 * ViewRateBaseOnIP6;
        
        for (int i = 0 ; i < photoArr.count; i++) {
            UIImage *image = photoArr[i];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = image;
            [imageView setFrame:CGRectMake(i * imageViewW , 0, imageViewW, imageViewW)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
            [imageView addGestureRecognizer:tap];
            [_scrollview addSubview:imageView];
        }
        [_addPhotoImageView setFrame:CGRectMake(photoArr.count * imageViewW, 0, imageViewW, imageViewW)];
        if (_scrollview.subviews.count < _maxPhoto) {
            [_scrollview addSubview:_addPhotoImageView];
        }
        [self layoutSubviews];
    }
}

-(void)setMaxPhoto:(NSInteger)maxPhoto
{
    _maxPhoto = maxPhoto;
    [self layoutSubviews];
}
@end
