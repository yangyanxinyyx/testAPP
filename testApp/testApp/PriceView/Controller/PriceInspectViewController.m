//
//  PriceInspectViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInspectViewController.h"
#import "PriceInspectTableViewCell.h"

@interface PriceInspectViewController ()<UITableViewDelegate,UITableViewDataSource,PriceInspectTableViewCellDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceInspectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"查看报价";
    [self createUI];
}
#pragma mark- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    PriceInspectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PriceInspectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    cell.labelName.text = @"PICC人保";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 * ViewRateBaseOnIP6;
}
#pragma mark - cell Delegate
- (void)inspectPriceDelegate{
    NSLog(@"查看报价");
}
#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorColor = [UIColor purpleColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
@end
