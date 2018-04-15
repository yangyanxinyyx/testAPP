//
//  XCUserCaseScrollerViewCell.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseScrollerViewCell.h"
#import "UILabel+createLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XCUserCaseScrollerViewCell ()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIScrollView * scrollView ;

/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * imageViewArrM ;

@end

@implementation XCUserCaseScrollerViewCell
+ (CGFloat)getCellHeight
{
    return (88 + 140 +30 ) * ViewRateBaseOnIP6;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imageViewArrM = [[NSMutableArray alloc] init];
        [self configSubVies];
        [_titleLabel setText:@"刘某人伤案件理赔进度"];
//        UIImage *image = [UIImage imageNamed:@"未完成"];
//        self.photoArr = @[image,image,image,image,image,image,image,image,image,image];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    
    [_topView setFrame:CGRectMake(0, 0, self.bounds.size.width, 20 * ViewRateBaseOnIP6)];
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(leftMargin,CGRectGetMaxY(_topView.frame) + 30 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];
    [_scrollView setFrame:CGRectMake(30 *ViewRateBaseOnIP6, (20 + 88 ) * ViewRateBaseOnIP6, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6)];
    
    if (_scrollView.subviews > 0 ) {
        CGFloat imageViewW = 140 *ViewRateBaseOnIP6;
        for (int i = 0 ; i < _scrollView.subviews.count; i++) {
            UIImageView *imageView = _scrollView.subviews[i];
            [imageView setFrame:CGRectMake(i * (140 +16)* ViewRateBaseOnIP6, 0, imageViewW , imageViewW)];
            
        }
    }

}

#pragma mark - Action Method
- (void)clickImage:(UITapGestureRecognizer *)tap
{
    
    NSLog(@"Click%@",tap);
//    for (UIImageView *imageView in _scrollView.subviews) {
//
//
//    }
    
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    _titleLabel = [UILabel createLabelWithTextFontSize:28 textColor:[UIColor blackColor]];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_topView];
    [self addSubview:_titleLabel];
    [self addSubview:_scrollView];
}

#pragma mark - Setter&Getter

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    [_titleLabel setText:_titleStr];
}

- (void)setPhotoURLArr:(NSArray<NSURL *> *)photoURLArr
{
    if (photoURLArr.count > 0) {
        CGFloat imageViewW = 140 * ViewRateBaseOnIP6;
        CGFloat rigthMargin = 16 * ViewRateBaseOnIP6;
        [_scrollView setContentSize:CGSizeMake((imageViewW + rigthMargin) * photoURLArr.count ,imageViewW)];
        _photoURLArr = photoURLArr;
        if (_scrollView.subviews.count > 0) {
            for (UIView *view in _scrollView.subviews) {
                [view removeFromSuperview];
            }
        }
         UIImage *image = [UIImage imageNamed:@"未完成"];
        for (int i = 0 ; i < photoURLArr.count; i++) {
            NSURL *imageURL = photoURLArr[i];
            UIImageView *imageView = [[UIImageView alloc] init];
            
            [imageView sd_setImageWithURL:imageURL placeholderImage:image];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
            [imageView addGestureRecognizer:tap];
            [_scrollView addSubview:imageView];
        }
    }
}

@end
