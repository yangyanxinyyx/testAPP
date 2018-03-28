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
#import "PriceUnderwritingImportTableViewCell.h"
#import "PriceUnderwritingSureTableViewCell.h"
#import "SelectTimeView.h"
@interface PriceUnderwritingViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,PriceUnderwritingImportTableViewCellDelegate,PriceUnderwritingTextTableViewCellDelegate,PriceUnderwritingSureTableViewCellDelegate>
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSNotification *notification;
@property (nonatomic, strong) SelectTimeView *selectTimeV;
@end

@implementation PriceUnderwritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"提交核保";
    [self.view addSubview:topBar];
    
    // 创建通知
    _notification = [NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
  
    [self createUI];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark- cell delegate
- (void)textViewChangeWithTextView:(UITextView *)textView{
    NSLog(@"%@",textView.text);
}

- (void)textViewBeginWithTextView:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
      self.myTableView.contentOffset = CGPointMake(0, 520 * ViewRateBaseOnIP6);
    }];
}

-(void)textViewENDWithTextView:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
        self.myTableView.contentOffset = CGPointMake(0,0);
    }];
}

- (void)textFieldBeginWithTextField:(UITextField *)textField{
    [UIView animateWithDuration:0.2 animations:^{
        self.myTableView.contentOffset = CGPointMake(0, 400 * ViewRateBaseOnIP6);
    }];
}

- (void)textFieldENDWithTextField:(UITextField *)textField{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.myTableView.contentOffset = CGPointMake(0, 0 * ViewRateBaseOnIP6);
    }];
}

- (void)comfirmToSubmit{
    NSLog(@"确认提交");
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 14;
    
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
        cell.delegate = self;
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
    } else if (indexPath.row == 12){
        static NSString *identifier = @"identifierImport";
        PriceUnderwritingImportTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingImportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.delegate = self;
        return cell;
    } else {
        static NSString *identifier = @"identifierCombit";
        PriceUnderwritingSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingSureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.delegate = self;
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 12) {
        return 233 * ViewRateBaseOnIP6;
    } else if (indexPath.row == 13 ){
        return 158 *  ViewRateBaseOnIP6;
    } else {
        
        return 80 * ViewRateBaseOnIP6;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20 * ViewRateBaseOnIP6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20 * ViewRateBaseOnIP6)];
    view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        _selectTimeV.hidden = NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:_notification];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:_notification];
    
}

#pragma mark0 UI
- (void)createUI{
    [self.view addSubview:self.viewContent];
    [self.viewContent addSubview:self.myTableView];
    
    _selectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _selectTimeV.block = ^(NSString *timeStr){
        if (timeStr) {
            NSLog(@"%@",timeStr);
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:_selectTimeV];
    _selectTimeV.hidden = YES;
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
        _myTableView.bounces = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}





@end
