//
//  XCShopServiceDetailListViewController.h
//  testApp
//
//  Created by Melody on 2018/4/13.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"
@class XCShopServiceModel;
@interface XCShopServiceDetailListViewController : BaseViewController1<BaseNavigationBarDelegate>
/**
 自定义导航栏
 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;

///** <# 注释 #> */
//@property (nonatomic, strong) XCShopServiceModel * currentModel ;
/** <# 注释 #> */
@property (nonatomic, strong) NSArray * dataArr ;
- (instancetype)initWithTitle:(NSString *)title;
@end
