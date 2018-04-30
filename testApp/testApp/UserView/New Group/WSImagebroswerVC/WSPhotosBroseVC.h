//
//  GoodsImageBroseVC.h
//  doucui
//
//  Created by 吴振松 on 16/10/12.
//  Copyright © 2016年 lootai. All rights reserved.
//

#import "WSImageBroswerVC.h"

@interface WSPhotosBroseVC : WSImageBroswerVC<BaseNavigationBarDelegate>

/** 自定义导航栏 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;

@property (nonatomic, copy) void(^completion)(NSArray <UIImage *> *array);

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithTitle:(NSString *)title
                      sources:(NSMutableArray<WSImageModel *> *)imageArrM;
@end
