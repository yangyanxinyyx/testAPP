//
//  XCCheckoutPhotoPreViewController.m
//  testApp
//
//  Created by Melody on 2018/4/20.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutPhotoPreViewController.h"
#import "CGAffineTransformFun.h"
#import "UIImage+Resize.h"
#import <UIImageView+WebCache.h>
@interface XCCheckoutPhotoPreViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * clipView ;
@property (nonatomic, strong) UIImageView * preView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * deleteBtn ;

@end

@implementation XCCheckoutPhotoPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.clipView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation- kBottomMargan)];
    self.preView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addGestureRecognizerToView];
    [self.preView setUserInteractionEnabled:YES];
    [self.view addSubview:_clipView];
    [_clipView addSubview:_preView];
    

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    
    if (self.preView.image) {
        UIImage *sourceImage = self.preView.image;
        CGFloat puzzleRadio = (float)sourceImage.size.width / sourceImage.size.height;
        CGFloat screenRadio = (float)SCREEN_WIDTH / SCREEN_HEIGHT;
        CGFloat newWidth;
        CGFloat newHeight;
        if (puzzleRadio > screenRadio) {
            newWidth = SCREEN_WIDTH;
            newHeight = newWidth / puzzleRadio;
        }else {
            newHeight = SCREEN_HEIGHT;
            newWidth = newHeight * puzzleRadio;
        }
        if (newWidth > SCREEN_WIDTH) {
            newWidth = SCREEN_WIDTH;
            newHeight = newWidth / puzzleRadio;
        }
        if (newHeight > self.clipView.frame.size.height) {
            newHeight = self.clipView.frame.size.height;
            newWidth = newHeight * puzzleRadio;
        }
        CGRect prewViewFrame = CGRectZero;
        
        if (newWidth == SCREEN_WIDTH) {
            prewViewFrame = CGRectMake(0 , (SCREEN_HEIGHT - newHeight) * 0.5,
                                       newWidth,
                                       newHeight);
        }else {
            
            prewViewFrame = CGRectMake(0 + (self.clipView.frame.size.width - newWidth) * 0.5,
                                       (SCREEN_HEIGHT - newHeight) * 0.5,
                                       newWidth,
                                       newHeight);
        }
        //    [self.clipView setFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImage *newImage = [sourceImage resizedImage:prewViewFrame.size interpolationQuality:kCGInterpolationHigh];
        CGFloat clipWidth = self.clipView.frame.size.width ;
        CGFloat clipHeight = self.clipView.frame.size.height;
        //    [self.clipView setFrame:CGRectMake(0, (SCREEN_HEIGHT - clipHeight) * 0.5, clipWidth, clipHeight)];
        CGFloat clipRadio = clipWidth/ clipHeight;
        
        CGFloat newOffsetx;
        CGFloat newOffsety;
        if (clipRadio > puzzleRadio) {
            newOffsetx = 0;
            newWidth = clipWidth;
            newHeight = newWidth / puzzleRadio;
            newOffsety = (newHeight - clipHeight) * 0.5;
        }else {
            newOffsety = 0;
            newHeight = clipHeight;
            newWidth = newHeight * puzzleRadio;
            newOffsetx = (newWidth - clipWidth) * 0.5;
        }
        [self.preView setContentMode:UIViewContentModeScaleAspectFit];
        [self.preView setFrame:CGRectMake(newOffsetx, newOffsety, newWidth, newHeight)];
    }
  
    
    //    [self.preView setFrame:CGRectMake(0, 0, prewViewFrame.size.width, prewViewFrame.size.height)];
    
    //    [self.preView sizeToFit];
}

#pragma mark - lifeCycle

#pragma mark - Init Method
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
        _topBar = [[BaseNavigationBar alloc] init];
        _topBar.delegate  = self;
        _topBar.title = title;
        [_topBar setFinishBtnTitle:@"删除"];
        self.navTitle = title;
        [self.view addSubview:_topBar];
    }
    return self;
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - BaseNavigationBarDelegate
- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)baseNavigationDidPressDeleteBtn:(BOOL)isCancel
{
    self.deleteHandler();
    
}


#pragma mark - Privacy Method
-(void)addGestureRecognizerToView{
    // 移动手势
    UIPanGestureRecognizer *_panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    _panGestureRecognizer.delegate = self;
    [self.preView addGestureRecognizer:_panGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *_pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self.preView addGestureRecognizer:_pinchGestureRecognizer];
    _pinchGestureRecognizer.delegate = self;
}


// 处理移动手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *panView = panGestureRecognizer.view;
    CGPoint translation = [panGestureRecognizer translationInView:panView.superview];
    panView.center = CGPointMake(panView.center.x + translation.x, panView.center.y+translation.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:panView.superview];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self limitMoveRect];
    }
    
    return;
    
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *pinchView = pinchGestureRecognizer.view;
    CGFloat scale = pinchGestureRecognizer.scale;
    pinchView.transform = CGAffineTransformScale(pinchView.transform, scale, scale);
    pinchGestureRecognizer.scale = 1.0f;
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat scalex = [CGAffineTransformFun scaleXWithCGAffineTransform:pinchView.transform];
        if (scalex < 1) {
            [UIView animateWithDuration:0.3 animations:^{
                pinchView.transform = CGAffineTransformIdentity;
            }];
        }
        else if (scalex > 3) {
            [UIView animateWithDuration:0.3 animations:^{
                pinchView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 3, 3);
            }];
        }
        
        [self limitMoveRect];
    }
    return;
    
}

- (void)limitMoveRect
{
    CGRect frame = self.preView.frame;
    if (frame.origin.x > 1) {
        frame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height);
    }
    if (frame.origin.x+frame.size.width < SCREEN_WIDTH - 1) {
        frame = CGRectMake(SCREEN_WIDTH - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    }
    if (frame.origin.y > 1) {
        frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
    }
    if (frame.origin.y+frame.size.height < SCREEN_HEIGHT - 1) {
        frame = CGRectMake(frame.origin.x, SCREEN_HEIGHT - frame.size.height, frame.size.width, frame.size.height);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.preView.frame = frame;
    }];
}


#pragma mark - Setter&Getter

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    [_topBar setTitle:navTitle];
}


- (void)setSourceURL:(NSURL *)sourceURL
{
    _sourceURL = sourceURL;
    __weak __typeof(self) weakSelf = self;
    
    [self.preView sd_setImageWithURL:sourceURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakSelf viewWillLayoutSubviews];
    }];


}

- (void)setSourceImage:(UIImage *)sourceImage
{
    if (!sourceImage) {
        return;
    }


}

@end
