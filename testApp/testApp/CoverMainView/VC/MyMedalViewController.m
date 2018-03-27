//
//  MyMedalViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/16.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "MyMedalViewController.h"
#import "BaseNavigationBar.h"
#import "MyMedalView.h"
#import "MedalDetailViewController.h"

@interface MyMedalViewController ()<BaseNavigationBarDelegate,MyMedalViewDelegate>



@end

@implementation MyMedalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = @"我的勋章";
    [self.view addSubview:topBar];

    [self createUI];

}

- (void)createUI
{
    MyMedalView *presonMedal = [[MyMedalView alloc] initWithInfo:@[@"X1",@"X2",@"X3"] title:@"个人勋章"];
    presonMedal.frame = CGRectMake(0, 10 + kHeightForNavigation, SCREEN_WIDTH, 181);
    presonMedal.delegate = self;
    [self.view addSubview:presonMedal];

    MyMedalView *yearMedal = [[MyMedalView alloc] initWithInfo:@[@"X3",@"X2",@"X1"] title:@"年度勋章"];
    yearMedal.frame = CGRectMake(0, 10 + 181 +10+ kHeightForNavigation, SCREEN_WIDTH, 181);
    yearMedal.delegate = self;
    [self.view addSubview:yearMedal];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)MyMedalViewDidSelectToDetail:(NSString *)title
{
    MedalDetailViewController *detailVC = [[MedalDetailViewController alloc] initWithTitle:title];
    [self.navigationController pushViewController:detailVC animated:YES];
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
