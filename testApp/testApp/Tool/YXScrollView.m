//
//  YXScrollView.m
//  YXScrollView
//
//  Created by admin on 16/4/15.
//  Copyright © 2016年 yangyanxin. All rights reserved.
//

#import "YXScrollView.h"

typedef enum {
    DirecNone,
    DirecLeft,
    DirecRight

}Direction;

@interface YXScrollView ()<UIScrollViewDelegate>
//显示的imageView
@property (nonatomic, strong) UIImageView *currImageView;
//辅助滚动的imageView
@property (nonatomic, strong) UIImageView *otherImageView;
//当前显示图片的索引
@property (nonatomic, assign) NSInteger currIndex;
//将要显示图片的索引
@property (nonatomic, assign) NSInteger nextIndex;
//滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
//定时器
@property (nonatomic, strong) NSTimer *timer;
//任务队列
@property (nonatomic, strong) NSOperationQueue *queue;
//滚动方向
@property (nonatomic, assign) Direction direction;
//轮播的图片数组
@property (nonatomic, strong) NSMutableArray *images;




@end

@implementation YXScrollView

#pragma mark 初始化方法
-(UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        _currImageView = [[UIImageView alloc] init];
        _currImageView.userInteractionEnabled = YES;
        [_currImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        [_scrollView addSubview:_currImageView];
        
        _otherImageView = [[UIImageView alloc] init];
        [_scrollView addSubview:_otherImageView];
        [self addSubview:_scrollView];
        
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

-(CGFloat)height
{
    return self.scrollView.frame.size.height;
}

-(CGFloat)width
{
    return self.scrollView.frame.size.width;
}


#pragma mark- 构造方法
-(instancetype)initWithImageArray:(NSArray *)imageArray imageClick:(ClickBlock)imageClickBlock
{
    if (self = [super init]) {
        self.imageArray = imageArray;
        self.imageClickBlock = imageClickBlock;
    }
    return self;
}

+(instancetype)carouselViewWithImageArray:(NSArray *)imageArray imageClickBlock:(ClickBlock)imageClickBlock
{
    return [[self alloc] initWithImageArray:imageArray imageClick:imageClickBlock];
}


#pragma mark- 设置控件的fream
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.scrollView.frame = self.bounds;
    self.pageControl.center = CGPointMake(self.width * 0.5, self.height -40);
    [self setScrollViewContentSize];
}

#pragma mark 设置图片数组
- (void)setImageArray:(NSArray *)imageArray{
    if (!imageArray.count) return;
 
    _imageArray = imageArray;
    _images = [NSMutableArray array];
    for (int i = 0; i < imageArray.count; i++) {
        if ([imageArray[i] isKindOfClass:[UIImage class]]) {
            [_images addObject:imageArray[i]];
        } else if ([imageArray[i] isKindOfClass:[NSString class]]){
            [_images addObject:[UIImage imageNamed:@"placeholder"]];
        }
    }
    self.currImageView.image = _images.firstObject;
    self.pageControl.numberOfPages = _images.count;
    [self setScrollViewContentSize];
}

#pragma mark 设置滚动方向
-(void)setDirection:(Direction)direction
{
    if (_direction == direction) {
        return;
    }
    _direction = direction;
    if (_direction == DirecNone) {
        return;
    }
    if (_direction == DirecRight) {
        self.otherImageView.frame = CGRectMake(0, 0, self.width, self.height);
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex<0) {
            self.nextIndex = _images.count - 1;
        }
    }else if (_direction == DirecLeft)
    {
        self.otherImageView.frame = CGRectMake(self.width*2, 0, self.width, self.height);
        self.nextIndex = (self.currIndex+1)%_images.count;
        
    }
    self.otherImageView.image = self.images[self.nextIndex];
    
}


#pragma mark 设置scrollView的contentSize
-(void)setScrollViewContentSize
{
    if (_images.count > 1) {
        self.scrollView.contentSize = CGSizeMake(self.width*3, 0);
        self.scrollView.contentOffset = CGPointMake(self.width, 0);
        self.currImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
        [self startTimer];
    }else
    {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currImageView.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

#pragma mark 设置定时器时间
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    [self startTimer];
}

#pragma mark- --------定时器相关方法--------
- (void)startTimer {
    //如果只有一张图片，则直接返回，不开启定时器
    if (_images.count <= 1) return;
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:_time < 1? 5 : _time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
}

#pragma mark 图片点击事件
- (void)imageClick {
    if (self.imageClickBlock) {
        self.imageClickBlock(self.currIndex);
    }
}

#pragma mark 当图片滚动过半时就修改当前页码
- (void)changeCurrentPageWithOffset:(CGFloat)offsetX {
    if (offsetX < self.width * 0.5) {
        NSInteger index = self.currIndex - 1;
        if (index < 0) index = self.images.count - 1;
        _pageControl.currentPage = index;
    } else if (offsetX > self.width * 1.5){
        _pageControl.currentPage = (self.currIndex + 1) % self.images.count;
    } else {
        _pageControl.currentPage = self.currIndex;
    }
}

#pragma mark- --------UIScrollViewDelegate--------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.direction = offsetX > self.width? DirecLeft : offsetX < self.width? DirecRight : DirecNone;
    [self changeCurrentPageWithOffset:offsetX];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)pauseScroll {
    //等于1表示没滚动
    if (self.scrollView.contentOffset.x / self.width == 1) return;
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
    self.currImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
    self.currImageView.image = self.otherImageView.image;
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
