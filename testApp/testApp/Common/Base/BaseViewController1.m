//
//  BaseViewController1.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"

@interface BaseViewController1 ()

@end

@implementation BaseViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setStatusBarBackgroundColor:[UIColor blackColor]];
    if (self.navigationController.viewControllers.count > 1) {
        BaseViewController1 *VC = (BaseViewController1 *)[self.navigationController.viewControllers lastObject];
        VC.tabBarController.tabBar.hidden = YES;
        VC.tabBarController.tabBar.frame = CGRectZero;

    }else{
        BaseViewController1 *VC = (BaseViewController1 *)[self.navigationController.viewControllers lastObject];
        VC.tabBarController.tabBar.hidden = NO;
        VC.tabBarController.tabBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44 - kBottomMargan, SCREEN_WIDTH, 44);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
