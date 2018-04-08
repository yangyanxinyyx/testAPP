//
//  GetCarViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarViewController.h"

@interface GetCarViewController ()<BaseNavigationBarDelegate>

@end

@implementation GetCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"接车";
    [self.view addSubview:topBar];

    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);

    [self createUI];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI
{
    



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
