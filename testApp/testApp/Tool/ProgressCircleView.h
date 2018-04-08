//
//  ProgressCircleView.h
//
//  Created by 杨焱鑫 on 17/3/9.
//  Copyright © 2017年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressCircleView : UIView

@property (nonatomic,assign) float      radius;
@property (nonatomic,assign) float      lineWidth;
@property (nonatomic,assign) BOOL       isShowCircleBg;
@property (nonatomic,strong) UIColor   *circleBgColor;

- (id)initWithFrame:(CGRect)frame percent:(float)percent color:(UIColor *)color clockwise:(BOOL)clockwise;

-(void)createPercentLayer;

-(void)reloadViewWithPercent:(float)percent;

- (void)creatByVideo;

@end
