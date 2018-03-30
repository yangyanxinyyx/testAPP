//
//  XCCheckoutDetailBaseTableViewController.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailBaseTableViewController.h"

@interface XCCheckoutDetailBaseTableViewController ()

@end

@implementation XCCheckoutDetailBaseTableViewController

#pragma mark - lifeCycle



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ktableCellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Table viewdata source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ktableCellID forIndexPath:indexPath];
    
    return cell;
    
}


#pragma mark - Privacy Method

#pragma mark - Setter&Getter
-(void)setBottomHeight:(CGFloat)bottomHeight
{
    _bottomHeight = bottomHeight;
    CGFloat tableViewH = SCREEN_HEIGHT - 64 -  _bottomHeight ;
    [self.tableView setFrame:CGRectMake(0,  64, SCREEN_WIDTH, tableViewH)];
}



@end
