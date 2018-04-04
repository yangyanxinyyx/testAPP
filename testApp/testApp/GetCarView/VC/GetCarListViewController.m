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

@end

@implementation GetCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self createUI];

}

- (void)createUI
{
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-50-30) style:UITableViewStylePlain];
    [self.view addSubview:_tab];

    _tab.dataSource = self;
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
