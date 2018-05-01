//
//  GoodsImageBroseVC.m
//  doucui
//
//  Created by 吴振松 on 16/10/12.
//  Copyright © 2016年 lootai. All rights reserved.
//

typedef enum {
    NavigationBarItemTypeBack,
    NavigationBarItemTypeLeft,
    NavigationBarItemTypeRight,
} NavigationBarItemType;

#import "WSPhotosBroseVC.h"

@implementation WSPhotosBroseVC
@synthesize showIndex = _showIndex;
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setStatusBarBackgroundColor:[UIColor blackColor]];
    if (self.navigationController.viewControllers.count > 1) {
        WSImageBroswerVC *VC = (WSImageBroswerVC *)[self.navigationController.viewControllers lastObject];
        VC.tabBarController.tabBar.hidden = YES;
        VC.tabBarController.tabBar.frame = CGRectZero;
        
    }else{
        WSImageBroswerVC *VC = (WSImageBroswerVC *)[self.navigationController.viewControllers lastObject];
        VC.tabBarController.tabBar.hidden = NO;
        VC.tabBarController.tabBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44 - kBottomMargan, SCREEN_WIDTH, 44);
    }
}

////来自父类
//- (void)initializeView {
//    [super initializeView];
//    //    [self setBarButtonWithText:@"删除" target:self action:@selector(onClickDel) type:NavigationBarItemTypeRight];
//    //    [self setBarButtonWithText:@"返回" target:self action:@selector(onClickBack) type:NavigationBarItemTypeLeft];
//}

#pragma mark - Init Method
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        NSLog(@"===========>initWithTitle");

        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
        _topBar = [[BaseNavigationBar alloc] init];
        _topBar.delegate  = self;
        _topBar.title = title;
        self.navTitle = title;
        [self.view addSubview:_topBar];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      sources:(NSMutableArray<WSImageModel *> *)imageArrM ;
{
    self = [self initWithTitle:title];
    self.imageArray = imageArrM;
    
    return self;
}

- (void)refreshTitle {
    NSInteger index = self.collectionView.contentOffset.x/self.collectionView.frame.size.width;
    self.showIndex = index;
    index += 1;
    if(index >= 0 && index <= self.imageArray.count) {
         _topBar.title = [NSString stringWithFormat:@"%@/%@",@(index),@(self.imageArray.count)];
    }
}


#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self onClickBack];
    }
}

- (void)baseNavigationDidPressDeleteBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self onClickDel];
    }
}

- (void)onClickDel {
    if(self.showIndex >= 0 && self.showIndex < self.imageArray.count) {
        [self.imageArray removeObjectAtIndex:self.showIndex];
        [self.collectionView reloadData];
    }
    [self refreshTitle];
    if(self.imageArray.count == 0) {
        [self onClickBack];
    }
}

- (void)onClickBack {
    if(self.completion) {
        NSMutableArray *array = [NSMutableArray new];
        for (WSImageModel *model in self.imageArray) {
            [array addObject:model.image];
        }
        self.completion(array);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Privacy Method
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
    
}
#pragma mark - Setter&Getter


//-(UIBarButtonItem *)setBarButtonWithText:(NSString*)text
//                                  target:(id)target
//                                  action:(SEL)action
//                                    type:(NavigationBarItemType)type
//{
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    [button setTitle:text forState:UIControlStateNormal];
//    [button sizeToFit];
//    
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space.width = -8;
//    
//    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    if (type == NavigationBarItemTypeLeft) {
//        self.navigationItem.leftBarButtonItems = @[space,buttonItem];
//    }
//    else if(type == NavigationBarItemTypeRight) {
//        self.navigationItem.rightBarButtonItems = @[space,buttonItem];
//    }
//    else {
//        self.navigationItem.backBarButtonItem = buttonItem;
//    }
//    
//    return buttonItem;
//}

@end
