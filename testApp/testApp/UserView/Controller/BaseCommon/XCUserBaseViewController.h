//
//  XCUserBaseViewController.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"

@interface XCUserBaseViewController : BaseViewController1<BaseNavigationBarDelegate>

/** 自定义导航栏 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;

- (instancetype)initWithTitle:(NSString *)title;


@end
