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
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"tap");
//}
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
    
    
    if (self.isAnnualType) {
        if (self.photoArr.count == 1) {
            [_addPhotoImageView setFrame:CGRectZero];
            UIImageView *imageView = [_scrollview.subviews firstObject];
            [imageView setFrame:CGRectMake(0, 0, labelSize.width, labelSize.width)];
        }else {
            if (![_addPhotoImageView superview]) {
                [_scrollview addSubview:_addPhotoImageView];
            }
            [_addPhotoImageView setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        }
        
    }else {
        if (_scrollview.subviews.count > 1) {
            if ((_scrollview.subviews.count - 1) >= _maxPhoto) {
                [_addPhotoImageView setFrame:CGRectZero];
                for (int i = 0 ; i < (_scrollview.subviews.count - 1); i++) {
                    UIImageView *imageView = _scrollview.subviews[i];
                    [imageView setFrame:CGRectMake(i * (10 * ViewRateBaseOnIP6 + labelSize.width) , 0, labelSize.width, labelSize.width)];
                }
            }else {
                for (int i = 0 ; i < _scrollview.subviews.count; i++) {
                    UIImageView *imageView = _scrollview.subviews[i];
                    [imageView setFrame:CGRectMake(i * (10 * ViewRateBaseOnIP6 + labelSize.width) , 0, labelSize.width, labelSize.width)];
                }
            }
        }else {
            if (![_addPhotoImageView superview]) {
                [_scrollview addSubview:_addPhotoImageView];
            }
            [_addPhotoImageView setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        }
    }
   
}
#pragma mark - Action Method

- (void)clickAddImageView:(UIImageView * )addImageView
{
    NSLog(@"clcik");
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailPhotoCellClickAddPhotosImageView:cell:)]) {
        [self.delegate XCCheckoutDetailPhotoCellClickAddPhotosImageView:addImageView cell:self];
    }
}

- (void)clickImageView:(UIGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailPhotoCellClickphotoWithURL:index:cell:)]) {
        NSInteger index =  [_scrollview.subviews indexOfObject:tap.view];
        NSString *urlPath = self.photoArr[index];
        if (isUsable(urlPath, [NSString class])) {
            NSURL *photoURL = [self getImageURLWithFilePath:urlPath];
            [self.delegate XCCheckoutDetailPhotoCellClickphotoWithURL:photoURL index:index cell:self];

        }
    }
}

- (void)setupCellWithShopModel:(XCShopModel *)model
{
//    if ([self.title isEqualToString:@"营业执照上传,1张"]&& isUsableNSString(model.licenseUrl, @"")) {
//        NSURL *licenseURL = [NSURL URLWithString:model.licenseUrl];
//        if (licenseURL) {
//            self.photoArr = @[licenseURL];
//        }
//    }
//    if ([self.title isEqualToString:@"门店图片,最多4张"]) {
//        NSMutableArray *photoURLArrM = [[NSMutableArray alloc] init];
//        if ([self isUsefulURLWith:model.url1]) {
//            [photoURLArrM addObject:model.url1];
//        }
//        if ([self isUsefulURLWith:model.url2]) {
//            [photoURLArrM addObject:model.url2];
//        }
//        if ([self isUsefulURLWith:model.url3]) {
//            [photoURLArrM addObject:model.url3];
//        }
//        if ([self isUsefulURLWith:model.url4]) {
//            [photoURLArrM addObject:model.url4];
//        }
//        self.photoArr = photoURLArrM;
//    }
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method
- (BOOL)isUsefulURLWith:(NSString *)photoPath
{
    BOOL result = NO;
    if (isUsableNSString(photoPath, @"")) {
        if ([photoPath hasPrefix:@"http://"]||[photoPath hasPrefix:@"https://"]) {
            result = YES;
        }
    }
    return result;
}

- (NSURL *)getImageURLWithFilePath:(NSString *)filePath
{
    NSURL *photoURL = nil;;
    if (isUsable(filePath, [NSString class])) {
        if ([filePath hasPrefix:@"http://"]||[filePath hasPrefix:@"https://"]) {
            photoURL = [NSURL URLWithString:filePath];
        }else {
            //        photoURL = [NSURL fileURLWithPath:filePath];
            photoURL = [NSURL URLWithString:filePath];
        }
    }
    return photoURL;
}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

-(void)setPhotoArr:(NSArray *)photoArr
{
    _photoArr = photoArr;
    [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat imageViewW  = 60 * ViewRateBaseOnIP6;
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolder"];

    if (photoArr.count > 0) {
        
        for (int i = 0 ; i < photoArr.count; i++) {
            NSString *filePath = photoArr[i];
            NSURL *photoURL = [self getImageURLWithFilePath:filePath];
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:photoURL placeholderImage:placeHolderImage];
//            [imageView setFrame:CGRectMake(i * (30 * ViewRateBaseOnIP6 + imageViewW) , 0, imageViewW, imageViewW)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
            [imageView addGestureRecognizer:tap];
            [imageView setContentMode:UIViewContentModeScaleToFill];
//            [imageView setClipsToBounds:YES];
            imageView.userInteractionEnabled = YES;
            [_scrollview addSubview:imageView];
        }
        [_addPhotoImageView setFrame:CGRectMake(photoArr.count * imageViewW, 0, imageViewW, imageViewW)];
        [_scrollview addSubview:_addPhotoImageView];
        [self layoutSubviews];
    }else {
        [self layoutSubviews];
        [_addPhotoImageView setFrame:CGRectMake(0, 0, imageViewW, imageViewW)];
        [_scrollview addSubview:_addPhotoImageView];
    }
}


-(void)setMaxPhoto:(NSInteger)maxPhoto
{
    _maxPhoto = maxPhoto;
}
@end
