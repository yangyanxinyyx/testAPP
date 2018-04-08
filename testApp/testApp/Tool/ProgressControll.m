//
//  BCProgressControll.m
//
//  Created by 杨焱鑫 on 16/10/20.
//  Copyright outPutTeam. All rights reserved.
//

#import "ProgressControll.h"

static CGFloat const animationDuration = 1.0;

static UIImageView *_progressAnimationView;
static UIView *bgView ;
static UIView *containerView ;
static UILabel *textLabel;

@implementation ProgressControll


+ (void)showToastWithText:(NSString *)text
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIFont *textFont = [UIFont systemFontOfSize:18.0];
    CGSize stringSize = [text sizeWithAttributes:@{NSFontAttributeName:textFont}];
    UILabel *HUD = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, stringSize.width + 10.0, stringSize.height + 10.0)];
    HUD.center = CGPointMake(CGRectGetMidX(window.bounds), CGRectGetMidY(window.bounds));
    [window addSubview:HUD];
    HUD.textColor = [UIColor whiteColor];
    HUD.font = textFont;
    HUD.text = text;
    HUD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    HUD.layer.cornerRadius = 5.0;
    HUD.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        HUD.alpha = 0.0;
    } completion:^(BOOL finished) {
        [HUD removeFromSuperview];
    }];
}


#pragma mark - BeautyProgress
+ (void)showProgressNormal
{
   
    [self showProgressWithText:nil];
}

+ (void)onlyShowProgress{
    
    [self showProgressWithText:nil hasBg:NO offsetY:0];
}

+ (void)showProgressNormalWithOffsetY:(float)originY{
    
    [self showProgressWithText:nil hasBg:YES offsetY:originY];
    
}

+ (void)showProgressWithText:(NSString *)text{
    
    [self showProgressWithText:text hasBg:YES offsetY:0];
    
}


+ (void)showProgressWithText:(NSString *)text hasBg:(BOOL)hasBg offsetY:(float)originY{
    
    UIWindow *progressWindow = nil;
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.windowLevel == 0) {
            progressWindow = window;
            break;
        }
    }
    if ([progressWindow.subviews containsObject:containerView]) {
        return ;
    }
    
    CABasicAnimation* rotationAnimation = [self rotationAnimation];
    
    
    if(hasBg){
        
        CGRect frame = SCREEN_FRAME;
        frame.origin.y = originY;
        frame.size.height = SCREEN_HEIGHT - originY;
        containerView = [[UIView alloc] initWithFrame:frame];
        containerView.backgroundColor = [UIColor clearColor];
        [progressWindow addSubview:containerView];
        
        
        UIView *bgView = [self progressViewWithText:text];
        bgView.center = CGPointMake(bgView.center.x, bgView.center.y - originY);
        [containerView addSubview:bgView];
    }
    else{
        
        containerView = [self progressViewWithText:text];
        containerView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2  - originY);
        [progressWindow addSubview:containerView];
    }
    
    [_progressAnimationView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    if (!_progressAnimationView.isAnimating) {
        [_progressAnimationView startAnimating];
    }
}


+ (void)dismissProgress{
    
    UIWindow *progressWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.windowLevel == 0) {
            progressWindow = window;
            break;
        }
    }
    if (containerView && [containerView superview]) {
        
        if (bgView) {
            
            if (_progressAnimationView && [_progressAnimationView superview]) {
                [_progressAnimationView stopAnimating];
                [_progressAnimationView removeFromSuperview];
            }
            
            if(bgView.superview != nil){
                
                [bgView removeFromSuperview];
            }
            bgView = nil;
            
        }
        if (_progressAnimationView) {
            
        }
        if(containerView != nil){
            
           [containerView removeFromSuperview];
        }
        
        containerView = nil;
    }

}


+ (CABasicAnimation *)rotationAnimation{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = animationDuration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    return rotationAnimation;
}

+ (UIView *)progressViewWithText:(NSString *)text
{
    if (!bgView) {
        
        CGRect frame = CGRectMake(0, 0, 60 * kiPadScale, 60 * kiPadScale);
        
        if(text.length > 0){
            
            frame.size.width = 150 * kiPadScale;

        }
        
        bgView = [[UIView alloc] initWithFrame:frame];
        bgView.layer.cornerRadius = 4 * kiPadScale;
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.85;
        bgView.center = CGPointMake(CGRectGetWidth(containerView.frame) / 2, CGRectGetHeight(containerView.frame) / 2);
        
        if(text.length > 0){
            
            textLabel = [[UILabel alloc] init];
            textLabel.text = text;
            textLabel.font = [UIFont systemFontOfSize:14 * kiPadScale];
            CGSize size = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:CGSizeMake(1000, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            textLabel.frame = CGRectMake(CGRectGetWidth(frame) / 2, (CGRectGetHeight(frame) - size.height) / 2, size.width, size.height);
            textLabel.textColor = [UIColor whiteColor];
            textLabel.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:textLabel];
        }
        
        
        UIImage *img = [UIImage imageNamed:@"loading"];
        _progressAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, CGRectGetHeight(frame) / 2, 20 * kiPadScale, 20 * kiPadScale)];
        _progressAnimationView.image = img;
        
        if(text.length > 0){
            
            _progressAnimationView.center = CGPointMake(CGRectGetMinX(textLabel.frame) - 35 * kiPadScale, CGRectGetHeight(frame) / 2);
        }
        else{
            
            _progressAnimationView.center = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetHeight(frame) / 2);
        }
        
        [bgView addSubview:_progressAnimationView];

    }
    
    return bgView;
}






@end
