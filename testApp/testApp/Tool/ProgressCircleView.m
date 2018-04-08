//
//  ProgressCircleView.m
//
//  Created by 杨焱鑫 on 17/3/9.
//  Copyright © 2017年 outPutTeam. All rights reserved.
//

#import "ProgressCircleView.h"

@interface ProgressCircleView ()
{
    NSTimer *_timer;
    BOOL _flag;
}
@property (nonatomic,assign) BOOL       clockwise;
@property (nonatomic,assign) float      percent;
@property (nonatomic,assign) float      duration;
@property (nonatomic,assign) CGPoint    centerPoint;
@property (nonatomic,strong) CAShapeLayer *circleLayer;
@property (nonatomic,strong) CAShapeLayer *circleBgLayer;
@property (nonatomic,strong) UIColor    *circleColor;

@end

@implementation ProgressCircleView

- (id)initWithFrame:(CGRect)frame percent:(float)percent color:(UIColor *)color clockwise:(BOOL)clockwise{
    
    self = [super initWithFrame:frame];
    self.clockwise = clockwise;
    self.percent = percent;
    self.radius = CGRectGetWidth(frame) / 2.0;
    self.lineWidth = CGRectGetHeight(frame);
    self.circleColor = color;
    self.centerPoint = CGPointMake(CGRectGetWidth(frame) / 2.0,CGRectGetWidth(frame) / 2.0);
    self.isShowCircleBg = NO;
    self.circleBgColor = COLOR_RGB_255(77.0, 77.0, 77.0);
    [self createPercentLayer];
    
    return self;
}

- (void)creatByVideo
{
    UIView *redView = [UIView new];
    redView.backgroundColor = COLOR_RGB_255(255, 62, 62);
    redView.frame = CGRectMake(0, 0, 24, 24);
    redView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:redView];
    redView.layer.cornerRadius = 3.0f;
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(redViewAlphaChanged:) userInfo:redView repeats:YES];
//    _flag = YES;
}

- (void)redViewAlphaChanged:(NSTimer *)timer
{
    UIView *redView = timer.userInfo;
    
    if (_flag == YES) {
        redView.alpha -= 0.1;
        if (redView.alpha <= 0) {
            _flag = NO;
        }
    }else
    {
        redView.alpha += 0.1;
        if (redView.alpha >= 1.3) {
            _flag = YES;
        }
    }
}


-(void)createPercentLayer {
    
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.lineWidth = self.lineWidth;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer.strokeColor = [self.circleColor CGColor];
    
    if(self.radius > self.lineWidth){
        
        self.circleLayer.lineCap = kCALineCapRound;
    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint
                                                        radius:self.radius
                                                    startAngle: - M_PI / 2.0
                                                      endAngle:M_PI * 2 * self.percent - M_PI / 2.0
                                                     clockwise:self.clockwise];
    
    self.circleLayer.path = path.CGPath;
    
    [self.layer addSublayer:self.circleLayer];
}

- (void)createCircleBgLayer{
    
    self.circleBgLayer = ({
        
        CAShapeLayer *circleBgLayer = [CAShapeLayer layer];
        circleBgLayer.lineWidth = self.lineWidth;
        circleBgLayer.lineCap = kCALineCapRound;
        circleBgLayer.strokeColor =  self.circleBgColor.CGColor;
        circleBgLayer.fillColor =  [[UIColor clearColor] CGColor];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint
                                                            radius:self.radius
                                                        startAngle: 0
                                                          endAngle:M_PI * 2
                                                         clockwise:NO];
        
        circleBgLayer.path = path.CGPath;
        
        [self.layer addSublayer:circleBgLayer];
        circleBgLayer;
    });
    
}


-(void)reloadViewWithPercent:(float)percent {
    self.percent = percent;
    CALayer *aLayer = self.circleLayer;
    [self createPercentLayer];
    [aLayer removeFromSuperlayer];
}

- (void)setIsShowCircleBg:(BOOL)isShowCircleBg{
    
    _isShowCircleBg = isShowCircleBg;
    if(isShowCircleBg){
        
        if(self.circleBgLayer == nil){
            
            [self createCircleBgLayer];
        }
        
    }
    else if(self.circleBgLayer != nil){
        
        [self.circleBgLayer removeFromSuperlayer];
        self.circleBgLayer = nil;
    }
    
}

@end
