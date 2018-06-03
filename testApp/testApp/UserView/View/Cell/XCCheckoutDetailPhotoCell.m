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
#define kcollectViewCell @"customCell"
@interface XCCheckoutDetailPhotoCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** <# 注释 #> */
@property (nonatomic, strong) UIScrollView * scrollview ;

/** <# 注释 #> */
@property (nonatomic, strong) UICollectionView * collectView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIImageView * addPhotoImageView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * separtatorLine ;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

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
        _isShowTopTag = NO;
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10 * ViewRateBaseOnIP6;
    layout.minimumInteritemSpacing = 1 * ViewRateBaseOnIP6;
    layout.itemSize =  CGSizeMake(140 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6);
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kcollectViewCell];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.showsVerticalScrollIndicator = NO ;
    _collectView.bounces = NO;
    _collectView.dataSource = self;
    _collectView.delegate = self;
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    [_collectView addGestureRecognizer:_longPress];
    
//    _scrollview = [[UIScrollView alloc] init];
//    _scrollview.userInteractionEnabled = YES;
//
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    
    [self addSubview:_titleLabel];
    [self addSubview:_collectView];
    [self addSubview:_separtatorLine];
    [_collectView addSubview:_addPhotoImageView];
    
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
    
    [_collectView setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_titleLabel.frame) + 18 * ViewRateBaseOnIP6, labelSize.width, labelSize.height)];

    labelSize = CGSizeMake(140 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6);
        
        if (self.photoArr.count > 0) {
             [_collectView setFrame:CGRectMake(leftMargin,CGRectGetMaxY(_titleLabel.frame) + 18 * ViewRateBaseOnIP6, (self.photoArr.count + 1 ) * (10 * ViewRateBaseOnIP6 + labelSize.width),labelSize.width)];
            if ( self.photoArr.count >= _maxPhoto) {
                [_addPhotoImageView setFrame:CGRectZero];
            }else {
                [_addPhotoImageView setFrame:CGRectMake(10 * ViewRateBaseOnIP6 + (self.photoArr.count) * (10 * ViewRateBaseOnIP6 + labelSize.width),0,labelSize.width, labelSize.height)];
            }
        }else {
            if (![_addPhotoImageView superview]) {
                [self addSubview:_addPhotoImageView];
            }
            [_addPhotoImageView setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
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


#pragma mark - Delegates & Notifications


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailPhotoCellClickphotoWithURL:index:cell:)]) {
        NSInteger index =  indexPath.row;
        NSString *urlPath = self.photoArr[index];
        if (isUsable(urlPath, [NSString class])) {
            NSURL *photoURL = [self getImageURLWithFilePath:urlPath];
            [self.delegate XCCheckoutDetailPhotoCellClickphotoWithURL:photoURL index:index cell:self];
            
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filePath = self.photoArr[indexPath.row];
    NSURL *photoURL = [self getImageURLWithFilePath:filePath];
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolder"];

    UICollectionViewCell *cell = (UICollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:kcollectViewCell forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6)];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView sd_setImageWithURL:photoURL placeholderImage:placeHolderImage];
    [cell.contentView addSubview:imageView];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0)
{
    NSString *temp = [self.photoArr objectAtIndex:sourceIndexPath.row];
    [self.photoArr removeObjectAtIndex:sourceIndexPath.row];
    [self.photoArr insertObject:temp atIndex:destinationIndexPath.row];
    // 将数据插入到资源数组中的目标位置上
//    [self.photoArr exchangeObjectAtIndex:sourceIndexPath.row  withObjectAtIndex:destinationIndexPath.row];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(XCCheckoutDetailPhotoCellChangePhotoArr:cell:)]) {
        [self.delegate XCCheckoutDetailPhotoCellChangePhotoArr:self.photoArr cell:self];
    }
}



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
- (void)longPressMethod:(UILongPressGestureRecognizer *)longPressGes {
    
    // 判断手势状态
    switch (longPressGes.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
            NSIndexPath *indexPath = [self.collectView indexPathForItemAtPoint:[longPressGes locationInView:self.collectView]];
            // 如果点击的位置不是cell,break
            if (nil == indexPath) {
                break;
            }
            NSLog(@"%@",indexPath);
            // 在路径上则开始移动该路径上的cell
            [self.collectView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            // 移动过程当中随时更新cell位置
            CGPoint point =  [longPressGes locationInView:self.collectView];
            [self.collectView updateInteractiveMovementTargetPosition:point];
        }
          
            break;
            
        case UIGestureRecognizerStateEnded:
            // 移动结束后关闭cell移动
            [self.collectView endInteractiveMovement];
            break;
        default:
            [self.collectView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

- (void)setPhotoArr:(NSMutableArray *)photoArr
{
    if (isUsable(photoArr, [NSArray class])) {
        _photoArr = [[NSMutableArray alloc] initWithArray:photoArr];
    }else if(isUsable(photoArr, [NSMutableArray class])){
        _photoArr = photoArr;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectView reloadData];
         [self layoutSubviews];
    });
}

-(void)setMaxPhoto:(NSInteger)maxPhoto
{
    _maxPhoto = maxPhoto;
}
@end
