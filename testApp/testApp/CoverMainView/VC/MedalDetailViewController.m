//
//  MedalDetailViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "MedalDetailViewController.h"
#import "MedalDetailCell.h"

static NSString *identifier = @"listCell";

@interface MedalDetailViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *openArray;
@property (nonatomic,strong) NSString *navTitle;

@end

@implementation MedalDetailViewController

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);

        BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
        topBar.delegate  = self;
        topBar.title = title;
        self.navTitle = title;
        [self.view addSubview:topBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];

    // Do any additional setup after loading the view.
}

- (void)createUI
{
    self.dataSource = [NSMutableArray array];
    self.openArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, 360) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MedalDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];

        if ([self.navTitle isEqualToString:@"年度勋章"]) {
            if (indexPath.row == 0) {
                cell.label1.text = @"年冠军勋章";
                cell.label2.text = @"业绩年度第一名";
                cell.label3.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_year_one_bonus];
                cell.label5.text = @"1、个人在公司年度业绩排名第一名";
                cell.label6.text = [NSString stringWithFormat:@"2、业绩最低要求%@起",[UserInfoManager shareInstance].userMedal.medal_type_year_one_performance];
                cell.label7.text = [NSString stringWithFormat:@"3、奖金%@元/次，可重复领取",[UserInfoManager shareInstance].userMedal.medal_type_year_one_bonus];
                cell.imageV.image = [UIImage imageNamed:@"年度冠军.png"];
                
            }else if (indexPath.row == 1){
                cell.label1.text = @"年亚军勋章";
                cell.label2.text = @"业绩年度第二名";
                cell.label3.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_year_two_bonus];
                cell.label5.text = @"1、个人在公司年度业绩排名第二名";
                cell.label6.text = [NSString stringWithFormat:@"2、业绩最低要求%@起",[UserInfoManager shareInstance].userMedal.medal_type_year_two_performance];
                cell.label7.text = [NSString stringWithFormat:@"3、奖金%@元/次，可重复领取",[UserInfoManager shareInstance].userMedal.medal_type_year_two_bonus];
                cell.imageV.image = [UIImage imageNamed:@"年度亚军.png"];
            }else{
                cell.label1.text = @"年季军勋章";
                cell.label2.text = @"业绩年度第三名";
                cell.label3.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_year_three_bonus];
                cell.label5.text = @"1、个人在公司年度业绩排名第三名";
                cell.label6.text = [NSString stringWithFormat:@"2、业绩最低要求%@起",[UserInfoManager shareInstance].userMedal.medal_type_year_three_performance];
                cell.label7.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_year_three_bonus];
                cell.imageV.image = [UIImage imageNamed:@"年度季军.png"];
            }

        }else{
            if (indexPath.row == 0) {
                cell.label1.text = @"月冠军勋章";
                cell.label2.text = @"业绩月度第一名";
                cell.label3.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_month_one_bonus];
                cell.label5.text = @"1、个人在公司月度业绩排名第一名";
                cell.label6.text = [NSString stringWithFormat:@"2、业绩最低要求%@起",[UserInfoManager shareInstance].userMedal.medal_type_month_one_performance];
                cell.label7.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_month_one_bonus];
                cell.imageV.image = [UIImage imageNamed:@"个人冠军.png"];

            }else if (indexPath.row == 1){
                cell.label1.text = @"月亚军勋章";
                cell.label2.text = @"业绩月度第二名";
                cell.label3.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_month_two_bonus];
                cell.label5.text = @"1、个人在公司月度业绩排名第二名";
                cell.label6.text = [NSString stringWithFormat:@"2、业绩最低要求%@起",[UserInfoManager shareInstance].userMedal.medal_type_month_two_performance];
                cell.label7.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_month_two_bonus];
                cell.imageV.image = [UIImage imageNamed:@"个人亚军.png"];
            }else{
                cell.label1.text = @"月季军勋章";
                cell.label2.text = @"业绩月度第三名";
                cell.label3.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_month_three_bonus];
                cell.label5.text = [NSString stringWithFormat:@"2、业绩最低要求%@起",[UserInfoManager shareInstance].userMedal.medal_type_month_three_performance];
                cell.label6.text = @"2、业绩最低要求5万起";
                cell.label7.text = [NSString stringWithFormat:@"奖金%@元",[UserInfoManager shareInstance].userMedal.medal_type_month_three_bonus];
                cell.imageV.image = [UIImage imageNamed:@"个人季军.png"];
            }
        }





    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = SCREEN_HEIGHT - kHeightForNavigation;
    height = height < 204*_openArray.count + 120*(3-_openArray.count) ? height : 204*_openArray.count + 120*(3-_openArray.count);
    self.tableView.frame = CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, height);
    if ([self.openArray containsObject:indexPath]) {
        return 204;
    }else{
        return 120;
    }


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedalDetailCell *cell = (MedalDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.isOpen ==YES) {
        cell.isOpen = NO;
    }else{
        cell.isOpen = YES;
    }

    if ([self.openArray containsObject:indexPath]) {
        [self.openArray removeObject:indexPath];
    }else{
        [self.openArray addObject:indexPath];
    }
    [self.tableView reloadData];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
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
