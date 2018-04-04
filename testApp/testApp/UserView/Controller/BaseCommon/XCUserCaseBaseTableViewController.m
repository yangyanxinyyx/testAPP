//
//  XCUserCaseBaseTableViewController.m
//  testApp
//
//  Created by Melody on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseBaseTableViewController.h"

@interface XCUserCaseBaseTableViewController ()

@end

@implementation XCUserCaseBaseTableViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kmyCellID];
    [self.tableView registerClass:[XCUserCaseListCell class] forCellReuseIdentifier:kcaseListCelID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
 
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, 64 + 20 * ViewRateBaseOnIP6, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 20 * ViewRateBaseOnIP6)];

}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kmyCellID forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130 * ViewRateBaseOnIP6;
}
#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
