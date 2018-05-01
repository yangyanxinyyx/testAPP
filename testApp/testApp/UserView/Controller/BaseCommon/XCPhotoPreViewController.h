//
//  XCPhotoPreViewController.h
//  testApp
//
//  Created by Melody on 2018/4/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"
#import "WSImageModel.h"
@interface XCPhotoPreViewController : BaseViewController1<BaseNavigationBarDelegate>
/// 自定义导航栏
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;
/** 显示删除按钮 默认NO*/
@property (nonatomic, assign) BOOL shouldShowDeleBtm ;
@property (nonatomic, copy) void(^completion)(NSArray <NSURL *> *deleArray);


/**
 预览照片

 @param title 默认标题
 @param imageArrM 图片URL数组
 @return ->self
 */
- (instancetype)initWithTitle:(NSString *)title
                      sources:(NSArray<NSURL *> *)imageArrM;

- (void)updatePositionWithIndex:(NSUInteger)index;

@end
