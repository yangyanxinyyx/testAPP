//
//  XCCustomerADDViewController.m
//  testApp
//
//  Created by 严玉鑫 on 2018/4/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerADDViewController.h"
#import "PriceCustomerInformEntryTableViewCell.h"
#import "PriceCustomerInformEntrySubmitTableViewCell.h"
#import "YXTestNumber.h"
@interface XCCustomerADDViewController ()<PriceCustomerInformEntryTableViewCellDelegate>
{
    BOOL isHold;
}
@property (nonatomic, strong) NSNotification *notification;
@property (nonatomic, strong) NSMutableDictionary *dictionaryInfo;
@property (nonatomic, strong) UIButton *buttonSubmit;
@property (nonatomic, strong) NSMutableArray *arrayCustSource;
@property (nonatomic, strong) NSMutableArray *arrayEducation;
@end

@implementation XCCustomerADDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isHold = YES;
    [self.view addSubview:self.buttonSubmit];
    _notification = [NSNotification notificationWithName:@"CustomerNotification" object:nil userInfo:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    isHold = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isHold = NO;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - (kHeightForNavigation + safeAreaBottom ) - 80 * ViewRateBaseOnIP6);
}

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
            self.tableView.contentOffset = CGPointMake(0, SCREEN_HEIGHT / 4 + textField.tag * 15 * ViewRateBaseOnIP6);
        }];
    }
}

- (void)textFieldendEditing:(UITextField *)textField{
    if (textField.tag > 6) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentOffset = CGPointMake(0, 0);
        }];
    }
    
    if (textField.tag == 0) {
        [self.dictionaryInfo setObject:textField.text forKey:@"customerName"];
    } else if (textField.tag == 1) {
        [self.dictionaryInfo setObject:textField.text forKey:@"source"];
    } else if (textField.tag == 3){
        [self.dictionaryInfo setObject:textField.text forKey:@"birthday"];
    } else if (textField.tag == 4){
        [self.dictionaryInfo setObject:textField.text forKey:@"area"];
    } else if (textField.tag == 5){
        [self.dictionaryInfo setObject:textField.text forKey:@"address"];
    } else if (textField.tag == 6){
        if (isHold) {
            BOOL result = [YXTestNumber testingIdentutyCard:textField.text];
            if (!result) {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"身份证格式不对,请重新输入" complete:^{
                    textField.text = @"";
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            } else {
                [self.dictionaryInfo setObject:textField.text forKey:@"identity"];
            }
        }
        
    } else if (textField.tag == 7){
        [self.dictionaryInfo setObject:textField.text forKey:@"plateNo"];
    } else if (textField.tag == 8){
        [self.dictionaryInfo setObject:textField.text forKey:@"brand"];
    } else if (textField.tag == 9){
        [self.dictionaryInfo setObject:textField.text forKey:@"recordDate"];
    } else if (textField.tag == 10){
        [self.dictionaryInfo setObject:textField.text forKey:@"vinNo"];
    } else if (textField.tag == 11){
        [self.dictionaryInfo setObject:textField.text forKey:@"engineNo"];
    } else if (textField.tag == 12){
        [self.dictionaryInfo setObject:textField.text forKey:@"model"];
    } else {
        if (isHold) {
            NSString *prompt = [YXTestNumber testingMobile:textField.text];
            if (prompt&&prompt.length > 0) {
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:prompt complete:^{
                    textField.text = @"";
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            } else {
                [self.dictionaryInfo setObject:textField.text forKey:@"phoneNo"];
            }
        }
        
    }
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 14;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    PriceCustomerInformEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PriceCustomerInformEntryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    cell.textField.tag = indexPath.row;
    if (indexPath.row == 0) {
       [cell setLabelNameText:@"*客户名称:" isChoose:YES placeholderStr:@"请输入您的客户名称" isSelect:NO];
    } else if (indexPath.row == 1) {
       [cell setLabelNameText:@"*客户来源:" isChoose:YES placeholderStr:@"请选择客户来源" isSelect:YES];
        cell.textField.userInteractionEnabled = NO;
    } else if (indexPath.row == 2){
        [cell setLabelNameText:@"性      别:" isChoose:NO placeholderStr:@"请选择性别" isSelect:YES];
        cell.textField.userInteractionEnabled = NO;
    } else if (indexPath.row == 3){
        [cell setLabelNameText:@"生      日:" isChoose:NO placeholderStr:@"请选择日期" isSelect: YES];
        cell.textField.userInteractionEnabled = NO;
    } else if (indexPath.row == 4){
        [cell setLabelNameText:@"学      历:" isChoose:NO placeholderStr:@"请选择学历" isSelect:YES];
        cell.textField.userInteractionEnabled = NO;
    } else if (indexPath.row == 5){
        [cell setLabelNameText:@"地      址:" isChoose:NO placeholderStr:@"请输入您的地址" isSelect:NO];
    } else if (indexPath.row == 6) {
        [cell setLabelNameText:@"*身份证号:" isChoose:YES placeholderStr:@"请输入您的身份证号码" isSelect:NO];
    } else if (indexPath.row == 7){
        [cell setLabelNameText:@"*车牌号 :" isChoose:YES placeholderStr:@"请输入您的车牌号" isSelect:NO];
    } else if (indexPath.row == 8){
        [cell setLabelNameText:@"*车 品 牌:" isChoose:YES placeholderStr:@"请输入您的车辆品牌" isSelect:NO];
    } else if (indexPath.row == 9){
        [cell setLabelNameText:@"*初登日期:" isChoose:YES placeholderStr:@"请输入您的初登日期" isSelect:NO];
        cell.textField.userInteractionEnabled = NO;
    } else if (indexPath.row == 10){
        [cell setLabelNameText:@"*车 架 号:" isChoose:YES placeholderStr:@"请输入您的车架号" isSelect:NO];
    } else if (indexPath.row == 11){
        [cell setLabelNameText:@"*发动机号:" isChoose:YES placeholderStr:@"请输入您的发动机号" isSelect:NO];
    } else if (indexPath.row == 12){
        [cell setLabelNameText:@"车型型号:" isChoose:NO placeholderStr:@"请输入您的车型型号" isSelect:NO];
    }  else{
        [cell setLabelNameText:@"*联系方式:" isChoose:YES placeholderStr:@"请输入您的联系方式" isSelect:NO];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * ViewRateBaseOnIP6;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
    }
    __weak __typeof(self) weakSelf = self;
    if (indexPath.row == 9) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"recordDate"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if ( indexPath.row == 3) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"birthday"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if (indexPath.row == 2){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        LYZSelectView *selectView = [LYZSelectView alterViewWithArray:@[@"男",@"女"] confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
            cell.textField.text = selectStr;
            [weakSelf.dictionaryInfo setObject:selectStr forKey:@"birthday"];
        }];
        [self.view addSubview:selectView];
        
    } else if (indexPath.row == 3){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (self.arrayCustSource.count > 0) {
            LYZSelectView *selectView = [LYZSelectView alterViewWithArray:weakSelf.arrayCustSource confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                cell.textField.text = selectStr;
                [weakSelf.dictionaryInfo setObject:selectStr forKey:@"source"];
            }];
            [self.view addSubview:selectView];
        } else {
            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"customer_source",@"dictCode", nil];
            [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *data = response[@"data"];
                    for (NSDictionary *dic in data) {
                        [weakSelf.arrayCustSource addObject:[dic objectForKey:@"value"]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        LYZSelectView *selectView = [LYZSelectView alterViewWithArray:weakSelf.arrayCustSource confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                            cell.textField.text = selectStr;
                            [weakSelf.dictionaryInfo setObject:selectStr forKey:@"source"];
                        }];
                        [self.view addSubview:selectView];
                    });
                }
            } fail:^(id error) {
                
            }];
        }
    } else if (indexPath.row == 4){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (self.arrayEducation.count > 0) {
            LYZSelectView *selectView = [LYZSelectView alterViewWithArray:weakSelf.arrayEducation confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                cell.textField.text = selectStr;
                [weakSelf.dictionaryInfo setObject:selectStr forKey:@"area"];
            }];
            [self.view addSubview:selectView];
        } else {
            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"education",@"dictCode", nil];
            [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
                if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *data = response[@"data"];
                    for (NSDictionary *dic in data) {
                        [weakSelf.arrayEducation addObject:[dic objectForKey:@"value"]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        LYZSelectView *selectView = [LYZSelectView alterViewWithArray:weakSelf.arrayEducation confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                            cell.textField.text = selectStr;
                            [weakSelf.dictionaryInfo setObject:selectStr forKey:@"area"];
                        }];
                        [self.view addSubview:selectView];
                    });
                }
            } fail:^(id error) {
                
            }];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:_notification];
}

#pragma mark -  get&&set
- (NSMutableDictionary *)dictionaryInfo{
    if (!_dictionaryInfo) {
        _dictionaryInfo = [NSMutableDictionary dictionary];
    }
    return _dictionaryInfo;
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

- (NSMutableArray *)arrayEducation{
    if (!_arrayEducation) {
        _arrayEducation = [NSMutableArray array];
    }
    return _arrayEducation;
}

- (NSMutableArray *)arrayCustSource{
    if (!_arrayCustSource) {
        _arrayCustSource = [NSMutableArray array];
    }
    return _arrayCustSource;
}

@end
