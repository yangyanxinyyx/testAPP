//
//  YXScrollView.h
//  YXScrollView
//
//  Created by admin on 16/4/15.
//  Copyright © 2016年 yangyanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSInteger index);

@interface YXScrollView : UIView

//分页控件
@property(nonatomic,strong)UIPageControl *pageControl;

//轮播图片数组
@property(nonatomic,strong)NSArray *imageArray;

//停留时间
@property(nonatomic,assign)NSTimeInterval time;

//点击图片后要执行的操作，会返回图片在数组中的索引
@property (nonatomic, copy) ClickBlock imageClickBlock;

-(instancetype)initWithImageArray:(NSArray*)imageArray imageClick:(ClickBlock)imageClickBlock;
+ (instancetype)carouselViewWithImageArray:(NSArray *)imageArray imageClickBlock:(ClickBlock)imageClickBlock;

-(void)startTimer;

-(void)stopTimer;

@end
