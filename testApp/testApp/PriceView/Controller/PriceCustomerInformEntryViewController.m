//
//  PriceCustomerInformEntryViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCustomerInformEntryViewController.h"
#import "PriceCustomerInformEntryTableViewCell.h"
#import "PriceCustomerInformEntrySubmitTableViewCell.h"
#import "YXTestNumber.h"
#import "SelectTimeView.h"
#import "LYZSelectView.h"
@interface PriceCustomerInformEntryViewController ()<UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate,PriceCustomerInformEntryTableViewCellDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSNotification *notification;
@property (nonatomic, strong) NSMutableDictionary *dictionaryInfo;
@property (nonatomic, strong) UIButton *buttonSubmit;
@end

@implementation PriceCustomerInformEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;
    topBar.title = @"客户信息录入";
    [self.view addSubview:topBar];
    _notification = [NSNotification notificationWithName:@"CustomerNotification" object:nil userInfo:nil];
    [self createUI];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}

- (void)viewTapped:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - fundation
- (void)submitCustomerInfo:(UIButton *)button{
    [self pressCustomerInformationInput];
}

#pragma mark - network
- (void)pressCustomerInformationInput{
    if (self.dictionaryInfo) {
        [RequestAPI getCustomerInformationInput:self.dictionaryInfo header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            NSNumber *result = response[@"result"];
            if (![result isKindOfClass:[NSNull class]] && [result boolValue] == YES) {
                NSLog(@"提交成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"提交成功,待审核" complete:^{
                        
                    }];
                    [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"%@",response[@"errormsg"]] complete:^{
                        
                    }];
                    [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
                });
            }
            
        } fail:^(id error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:[NSString stringWithFormat:@"%@",error] complete:^{
                    
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            });
        }];
    }
}


#pragma mark - cell delegate
- (void)textFieldBeginEditing:(UITextField *)textField{
    if (textField.tag > 6) {
        [UIView animateWithDuration:0.25 animations:^{
            self.myTableView.contentOffset = CGPointMake(0, SCREEN_HEIGHT / 4 + textField.tag * 12 * ViewRateBaseOnIP6);
        }];
    }
    if (textField.tag == 1 || textField.tag == 11) {
        textField.text = @"";
        [textField resignFirstResponder];
        
    }
}

- (void)textFieldendEditing:(UITextField *)textField{
    if (textField.tag > 6) {
        [UIView animateWithDuration:0.25 animations:^{
            self.myTableView.contentOffset = CGPointMake(0, 0);
        }];
    }

    
    if (textField.tag == 0) {
        [self.dictionaryInfo setObject:textField.text forKey:@"plateNo"];
    } else if (textField.tag == 2){
        [self.dictionaryInfo setObject:textField.text forKey:@"vinNo"];
    } else if (textField.tag == 3){
        [self.dictionaryInfo setObject:textField.text forKey:@"recordDate"];
    } else if (textField.tag == 4){
        [self.dictionaryInfo setObject:textField.text forKey:@"model"];
    } else if (textField.tag == 5){
        [self.dictionaryInfo setObject:textField.text forKey:@"brand"];
    } else if (textField.tag == 6){
        NSString *prompt = [YXTestNumber testingMobile:textField.text];
        if (prompt&&prompt.length > 0) {
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:prompt complete:^{
                textField.text = @"";
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        } else {
           [self.dictionaryInfo setObject:textField.text forKey:@"phoneNo"];
        }
        
    } else if (textField.tag == 7){
        [self.dictionaryInfo setObject:textField.text forKey:@"customerName"];
    } else if (textField.tag == 8){
        [self.dictionaryInfo setObject:textField.text forKey:@"source"];
    } else if (textField.tag == 9){
        BOOL result = [YXTestNumber testingIdentutyCard:textField.text];
        if (!result) {
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"身份证格式不对,请重新输入" complete:^{
                textField.text = @"";
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        } else {
           [self.dictionaryInfo setObject:textField.text forKey:@"identity"];
        }
    } else if (textField.tag == 10){
        [self.dictionaryInfo setObject:textField.text forKey:@"sex"];
    } else if (textField.tag == 12){
        [self.dictionaryInfo setObject:textField.text forKey:@"quyv"];
    } else {
        [self.dictionaryInfo setObject:textField.text forKey:@"address"];
    }
    NSLog(@"%@",self.dictionaryInfo);
}

#pragma mark - tabnleview detegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    } else {
        return 7;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 20 * ViewRateBaseOnIP6;
}
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view;
    if (section == 2) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60 * ViewRateBaseOnIP6)];
    } else {
        view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20 * ViewRateBaseOnIP6)];
    }
    view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"cell";
    PriceCustomerInformEntryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PriceCustomerInformEntryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    cell.textField.tag = indexPath.section * 7 +indexPath.row;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setLabelNameText:@"*车牌号 :"];
        } else if (indexPath.row == 1) {
            cell.labelName.text = @"初登日期:";
//            [cell setLabelNameText:@"*初登日期:"]
            cell.textField.userInteractionEnabled = NO;
        } else if (indexPath.row == 2){
            cell.labelName.text = @"车 架 号:";
        } else if (indexPath.row == 3){
            cell.labelName.text = @"发动机号:";
        } else if (indexPath.row == 4){
            cell.labelName.text = @"车型代码:";
        } else if (indexPath.row == 5){
            cell.labelName.text = @"品       牌:";;
        }  else{
            cell.labelName.text = @"联系方式:";
        }
        return cell;
    } else {
        if (indexPath.row == 0) {
            cell.labelName.text = @"客户名称:";
        } else if (indexPath.row == 1) {
            cell.labelName.text = @"客户来源:";
        } else if (indexPath.row == 2){
            cell.labelName.text = @"身份证号:";
        } else if (indexPath.row == 3){
            cell.labelName.text = @"性      别:";
            cell.textField.userInteractionEnabled = NO;
        } else if (indexPath.row == 4){
            cell.labelName.text = @"生      日:";
            cell.textField.userInteractionEnabled = NO;
        } else if (indexPath.row == 5){
            cell.labelName.text = @"区      域:";;
        }  else{
            cell.labelName.text = @"地      址:";
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf = self;
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"recordDate"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if (indexPath.section == 1 && indexPath.row == 4) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"birthday"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if (indexPath.section == 1 && indexPath.row == 3){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       LYZSelectView *selectView = [LYZSelectView alterViewWithArray:@[@"男",@"女"] confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
            cell.textField.text = selectStr;
            [weakSelf.dictionaryInfo setObject:selectStr forKey:@"birthday"];
        }];
        [self.view addSubview:selectView];
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:_notification];
}
#pragma marik - UI
- (void)createUI{
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.buttonSubmit];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 88 * ViewRateBaseOnIP6) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (UIButton *)buttonSubmit{
    if (!_buttonSubmit) {
        _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonSubmit.frame = CGRectMake(0, SCREEN_HEIGHT - 88 * ViewRateBaseOnIP6, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6);
        _buttonSubmit.backgroundColor = [UIColor colorWithHexString:@"#004da2"];
        [_buttonSubmit.titleLabel setFont:[UIFont systemFontOfSize:36 * ViewRateBaseOnIP6]];
        [_buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonSubmit setTitle:@"确认提交" forState:UIControlStateNormal];
        [_buttonSubmit addTarget:self action:@selector(submitCustomerInfo:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonSubmit;
}

- (NSMutableDictionary *)dictionaryInfo{
    if (!_dictionaryInfo) {
        _dictionaryInfo = [NSMutableDictionary dictionary];
    }
    return _dictionaryInfo;
}







@end
