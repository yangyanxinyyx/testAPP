//
//  XCCheckoutPhotoPreViewController.h
//  testApp
//
//  Created by Melody on 2018/4/20.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"
typedef void(^myBlock)(void);

@interface XCCheckoutPhotoPreViewController : BaseViewController1<BaseNavigationBarDelegate>

/**  */
@property (nonatomic, strong) NSURL * sourceURL ;

/**
 自定义导航栏
 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;
/** 是否显示删除 默认NO*/
@property (nonatomic, assign) BOOL shouldShowDeleteBtn ;
/** <# 注释 #> */
@property (nonatomic, copy) myBlock deleteHandler;


- (instancetype)initWithTitle:(NSString *)title;

@end
