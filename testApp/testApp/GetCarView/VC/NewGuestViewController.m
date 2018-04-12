//
//  NewGuestViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "NewGuestViewController.h"

@interface NewGuestViewController ()<BaseNavigationBarDelegate>

@property (nonatomic,assign) BOOL isOrder;

@end

@implementation NewGuestViewController

- (instancetype)initWithType:(BOOL)isOrder
{
    if (self = [super init]) {
        self.isOrder = isOrder;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate  = self;
    topBar.title = self.isOrder ? @"新增订单" : @"新增维修";
    [self.view addSubview:topBar];

    self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);

    []

    // Do any additional setup after loading the view.
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI
{
    for (int i=0; i<; <#increment#>) {
        <#statements#>
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
