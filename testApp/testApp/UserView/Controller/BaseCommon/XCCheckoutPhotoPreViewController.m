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
#import "LYZAlertView.h"
@interface XCCheckoutPhotoPreViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * clipView ;
@property (nonatomic, strong) UIImageView * preView ;
/** <# 注释 #> */
@property (nonatomic, assign) CGRect origianFrame ;

@end

@implementation XCCheckoutPhotoPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    _origianFrame = CGRectZero;
    self.clipView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation- kBottomMargan)];
    self.preView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.clipView.backgroundColor = [UIColor blackColor];
    [self addGestureRecognizerToView];
    [self.preView setUserInteractionEnabled:YES];
    [self.view addSubview:_clipView];
    [_clipView addSubview:_preView];
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_shouldShowDeleteBtn) {
        [_topBar setFinishBtnTitle:@"删除"];
    }

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

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
        _shouldShowDeleteBtn = NO;
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
    __weak __typeof(self) weakSelf = self;
    LYZAlertView *alterView = [LYZAlertView alterViewWithTitle:@"确认要删除吗?" content:nil confirmStr:@"是" cancelStr:@"否" confirmClick:^(LYZAlertView *alertView) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        if (strongSelf.deleteHandler) {
            strongSelf.deleteHandler();
        }
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:alterView];
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
    if (frame.origin.x+frame.size.width < _clipView.frame.size.width - 1) {
        frame = CGRectMake(_clipView.frame.size.width - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    }
    if (frame.origin.y > 1) {
        frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
    }
    if (frame.origin.y+frame.size.height < _clipView.frame.size.height - 1) {
        frame = CGRectMake(frame.origin.x, (_clipView.frame.size.height  - frame.size.height ) * 0.5, frame.size.width, frame.size.height);
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
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolder"];
    [self.preView sd_setImageWithURL:sourceURL placeholderImage:placeHolderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        UIImage *sourceImage = image;
        if (!sourceImage) {
            return ;
        }
        CGSize clipSize = weakSelf.clipView.frame.size;
        CGFloat puzzleRadio = (float)sourceImage.size.width / sourceImage.size.height;
        CGFloat screenRadio = (float)clipSize.width / clipSize.height;
        CGFloat newWidth = 0.0;
        CGFloat newHeight = 0.0;
        if (puzzleRadio > screenRadio) {
            newWidth = clipSize.width ;
            newHeight = newWidth / puzzleRadio;
        }else {
            newHeight = clipSize.height;
            newWidth = newHeight * puzzleRadio;
        }
        if (newWidth > clipSize.width ) {
            newWidth = clipSize.width ;
            newHeight = newWidth / puzzleRadio;
        }
        if (newHeight > clipSize.height) {
            newHeight = clipSize.height;
            newWidth = newHeight * puzzleRadio;
        }
        CGRect prewViewFrame = CGRectZero;
        
        if (newWidth == clipSize.width) {
            prewViewFrame = CGRectMake(0 , (clipSize.height - newHeight) * 0.5,
                                       newWidth,
                                       newHeight);
        }else {
            
            prewViewFrame = CGRectMake(0 + (clipSize.width - newWidth) * 0.5,
                                       (clipSize.height - newHeight) * 0.5,
                                       newWidth,
                                       newHeight);
        }

        [strongSelf.preView setContentMode:UIViewContentModeScaleAspectFit];
        [strongSelf.preView setFrame:prewViewFrame];
        strongSelf.origianFrame = prewViewFrame;
    }];
}

@end
