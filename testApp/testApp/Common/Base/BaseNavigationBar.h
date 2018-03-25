//
//  BaseNavigationBar.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/21.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseNavigationBarDelegate <NSObject>

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel;
@end

@interface BaseNavigationBar : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *finishBtnTitle;
@property (nonatomic,strong) UIImage *finishBtnImage;
@property (nonatomic,strong) UIColor *bgColor;

@property (nonatomic,weak) id<BaseNavigationBarDelegate>delegate;

@end
