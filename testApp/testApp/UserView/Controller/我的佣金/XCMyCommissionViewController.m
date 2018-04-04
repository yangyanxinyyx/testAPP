//
//  XCMyCommissionViewController.m
//  testApp
//
//  Created by Melody on 2018/3/22.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionViewController.h"
#import "RequestAPI.h"
@interface XCMyCommissionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView ;
@end

@implementation XCMyCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"我的佣金";
    NSDictionary *param = @{
                            @"user_id":[UserInfoManager shareInstance].userID,
                            };
    [RequestAPI getMyCommission:param header:[UserInfoManager shareInstance].ticketID  success:^(id response) {
        NSLog(@"%@",response);
    } fail:^(id error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}

#pragma mark - UITableViewDelegate&DateSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *signCell = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:signCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:signCell];
    }
    
    return cell;
    
}

@end
