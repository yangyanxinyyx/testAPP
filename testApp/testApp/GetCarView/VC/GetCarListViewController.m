//
//  GetCarListViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarListViewController.h"

@interface GetCarListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) UIView *forbidTipsView;

@end

@implementation GetCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self createUI];

}

- (void)createUI
{

    if (![UserInfoManager shareInstance].isStore) {
        [self.view addSubview:self.forbidTipsView];
        return;
    }

    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44) style:UITableViewStylePlain];
    [self.view addSubview:_tab];

    _tab.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return nil;
}

- (UIView *)forbidTipsView
{
    if (!_forbidTipsView) {
        _forbidTipsView = [[UIView alloc] initWithFrame:CGRectMake(0 , kHeightForNavigation , SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation) - kBottomMargan - 44)];
        _forbidTipsView.backgroundColor = COLOR_RGB_255(242, 242, 242);


        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:@"禁止.png"];
        imageView.center = CGPointMake(SCREEN_WIDTH/2, _forbidTipsView.bounds.size.height/2);
        [_forbidTipsView addSubview:imageView];


        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 72)/2, CGRectGetMaxY(imageView.frame) +12, 72, 11)];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"业务员不可用!";
        label.textColor = COLOR_RGB_255(165, 165, 165);
        [_forbidTipsView addSubview:label];


    }
    return _forbidTipsView;
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
