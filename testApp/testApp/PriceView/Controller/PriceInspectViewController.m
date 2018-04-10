//
//  PriceInspectViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInspectViewController.h"
#import "PriceInspectTableViewCell.h"
#import "PriceInfoViewController.h"

@interface PriceInspectViewController ()<UITableViewDelegate,UITableViewDataSource,PriceInspectTableViewCellDelegate,BaseNavigationBarDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceInspectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"查看报价";
    [self.view addSubview:topBar];
    
    [self createUI];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    if (indexPath.row == 0) {
        cell.labelName.text = @"PICC人保";
    } else {
        cell.labelName.text = @"平安保险";
    }
    cell.buttoninspect.tag = indexPath.row;
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 * ViewRateBaseOnIP6;
}
#pragma mark - cell Delegate
- (void)inspectPriceDelegateWith:(NSInteger)tag{
    PriceInfoViewController *priceInfoVC = [[PriceInfoViewController alloc] init];
    if (tag == 0) {
        priceInfoVC.quoteGroup = @"2";
    } else{
        priceInfoVC.quoteGroup = @"4";
    }
   
    [self.navigationController pushViewController:priceInfoVC animated:YES];
}
#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
@end
