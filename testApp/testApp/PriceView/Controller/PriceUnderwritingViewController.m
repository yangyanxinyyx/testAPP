//
//  PriceUnderwritingViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//  提交核保

#import "PriceUnderwritingViewController.h"
#import "PriceUnderwritingTableViewCell.h"
#import "PriceUnderwritingChooseTableViewCell.h"
#import "PriceUnderwritingTextTableViewCell.h"
#import "PriceUnderwritingRenewalTableViewCell.h"
@interface PriceUnderwritingViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PriceUnderwritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"提交核保";
    [self.view addSubview:topBar];
    [self createUI];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 5) {
        static NSString *identifier = @"identifierInfo";
        PriceUnderwritingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if (indexPath.row == 0) {
            cell.labelName.text = @"投保人:";
            cell.labelInfo.text = @"刘某某";
        } else if (indexPath.row == 1) {
            cell.labelName.text = @"身份证:";
            cell.labelInfo.text = @"347725198802060621";
        } else if (indexPath.row == 2){
            cell.labelName.text = @"初登日期:";
            cell.labelInfo.text = @"2017年09月19日";
        } else if (indexPath.row == 3) {
            cell.labelName.text = @"出单人:";
            cell.labelInfo.text = @"梁某某";
        } else {
            cell.labelName.text = @"出单日期:";
            cell.labelInfo.text = @"2018年01月6日";
        }
        return cell;
        
    } else if (indexPath.row < 9 && indexPath.row > 4){
        static NSString *identifeir = @"identifierchoose";
        PriceUnderwritingChooseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifeir];
        if (!cell) {
            cell = [[PriceUnderwritingChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifeir];
        }
        if (indexPath.row == 5) {
            cell.labelName.text = @"（商业）起保日期";
            cell.labelTag.text = @"2018-01-6";
        } else if (indexPath.row == 6) {
            cell.labelName.text = @"（交强）起保日期";
            cell.labelTag.text = @"2018-01-6";
        } else if (indexPath.row == 7){
            cell.labelName.text = @"保险公司";
            cell.labelTag.text = @"广州平安";
        } else {
            cell.labelName.text = @"出单机构";
            cell.labelTag.text = @"广州分公司";
        }
        
        
        
        
        return cell;
        
    } else if (indexPath.row < 11 && indexPath.row > 8){
        static NSString *identifier= @"identififerText";
        PriceUnderwritingTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.row == 9) {
            cell.labelName.text = @"交强险(业务员)金额:";
            
        } else {
            cell.labelName.text = @"商业险(业务员)金额:";
        }
        return cell;
    } else if (indexPath.row == 11) {
        static NSString *identifier = @"identifierRenewal";
        PriceUnderwritingRenewalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingRenewalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        } 
        return cell;
    } else {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * ViewRateBaseOnIP6;
}

#pragma mark0 UI
- (void)createUI{
    [self.view addSubview:self.viewContent];
    [self.viewContent addSubview:self.myTableView];
}
- (UIView *)viewContent{
    if (!_viewContent) {
        _viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _viewContent.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    }
    return _viewContent;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}





@end
