//
//  XCMyCommissionViewController.m
//  testApp
//
//  Created by Melody on 2018/3/22.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionViewController.h"

@interface XCMyCommissionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView ;
@end

@implementation XCMyCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate&DateSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
