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
#import "SelectTiemHoursView.h"
#import "LYZSelectView.h"


@interface PriceCustomerInformEntryViewController ()<UITableViewDelegate,UITableViewDataSource,BaseNavigationBarDelegate,PriceCustomerInformEntryTableViewCellDelegate>

{
    BOOL isHold;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSNotification *notification;
@property (nonatomic, strong) NSMutableDictionary *dictionaryInfo;
@property (nonatomic, strong) UIButton *buttonSubmit;
@property (nonatomic, strong) NSMutableArray *arrayCustSource;
@property (nonatomic, strong) NSMutableArray *arrayEducation;

@end

@implementation PriceCustomerInformEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isHold = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    BaseNavigationBar *topBar = [[BaseNavigationBar alloc] init];
    topBar.delegate = self;

    topBar.title = self.titleName;
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
    isHold = NO;
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    isHold = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isHold = NO;
}

#pragma mark - fundation
- (void)submitCustomerInfo:(UIButton *)button{
    [self pressCustomerInformationInput];
}

#pragma mark - network
- (void)pressCustomerInformationInput{
    if (self.dictionaryInfo) {
        __weak typeof (self)weakSelf = self;
        [RequestAPI getCustomerInformationInput:self.dictionaryInfo header:[UserInfoManager shareInstance].ticketID success:^(id response) {
            NSNumber *result = response[@"result"];
            if (![result isKindOfClass:[NSNull class]] && [result boolValue] == YES) {
                NSLog(@"提交成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"提交成功!" complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                        _requestSucces(weakSelf.dictionaryInfo[@"plateNo"]);
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

- (void)requestPriceContentParameter:(NSString *)Parameter{
   
}

#pragma mark - cell delegate
- (void)textFieldBeginEditing:(UITextField *)textField{
    if (textField.tag > 6) {
        [UIView animateWithDuration:0.25 animations:^{
            self.myTableView.contentOffset = CGPointMake(0, SCREEN_HEIGHT / 4 + textField.tag * 30 * ViewRateBaseOnIP6);
        }];
    }
//    if (textField.tag == 1 || textField.tag == 11) {
//        textField.text = @"";
//        [textField resignFirstResponder];
//
//    }
}

- (void)textFieldendEditing:(UITextField *)textField{
    if (textField.tag > 6) {
        [UIView animateWithDuration:0.25 animations:^{
            self.myTableView.contentOffset = CGPointMake(0, 0);
        }];
    }

    
    if (textField.tag == 0) {
//        if (textField.text.length >0 ) {
//            if (isHold) {
//                BOOL result = [YXTestNumber testingNumberPlate:textField.text];
//                if (!result) {
//                    FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"请输入正确的车牌号码" complete:^{
//                        textField.text = @"";
//                    }];
//                    [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
//                } else {
//                    
//                }
//            }
//        }
        textField.text = [textField.text uppercaseString];
        [self.dictionaryInfo setObject:[textField.text uppercaseString] forKey:@"plateNo"];
    } else if (textField.tag == 2){
        [self.dictionaryInfo setObject:textField.text forKey:@"vinNo"];
    } else if (textField.tag == 3){
        [self.dictionaryInfo setObject:textField.text forKey:@"engineNo"];
    }  else if (textField.tag == 6){
        [self.dictionaryInfo setObject:textField.text forKey:@"brand"];
    }  else if (textField.tag == 7){
        [self.dictionaryInfo setObject:textField.text forKey:@"customerName"];
    } else if (textField.tag == 9){
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
        
        
    } else if (textField.tag == 10){
        if (textField.text.length != 0) {
            if (isHold) {
                BOOL result = [YXTestNumber testingIdentutyCard:textField.text];
                if (!result) {
                    FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"身份证格式不对,请重新输入" complete:^{
                        //                    textField.text = @"";
                    }];
                    [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
                } else {
                    [self.dictionaryInfo setObject:textField.text forKey:@"identity"];
                }
            }
        }
    }  else if (textField.tag == 14) {
        [self.dictionaryInfo setObject:textField.text forKey:@"address"];
    }
    NSLog(@"%@",self.dictionaryInfo);
}

- (void)toucheButtonSearch{
    NSString *plateNO = [self.dictionaryInfo objectForKey:@"plateNo"];
    if (plateNO.length != 0 && ![plateNO isKindOfClass:[NSNull class]] && plateNO) {
        [self pressCustomerVehicleEnquiriesWithCriteria:[self.dictionaryInfo objectForKey:@"plateNo"]];
    }
    
}
- (void)pressCustomerVehicleEnquiriesWithCriteria:(NSString *)criteria{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:criteria forKey:@"criteria"];
    [RequestAPI getCustomerVehicleEnquiries:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *data = response[@"data"];
                NSNumber *customerName = [data objectForKey:@"customerName"];
                if (![customerName isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"customerName"] forKey:@"customerName"];
                }
                NSNumber *birthday = [data objectForKey:@"birthday"];
                if (![birthday isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"birthday"] forKey:@"birthday"];
                }
                
                NSNumber *sex = [data objectForKey:@"sex"];
                if (![sex isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"sex"] forKey:@"sex"];
                }
                
                NSNumber *address = [data objectForKey:@"address"];
                if (![address isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"address"] forKey:@"address"];
                }
                
                NSNumber *brand = [data objectForKey:@"brand"];
                if (![brand isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"brand"] forKey:@"brand"];
                }
                
                NSNumber *vinNo = [data objectForKey:@"vinNo"];
                if (![vinNo isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"vinNo"] forKey:@"vinNo"];
                }
                
                NSNumber *engineNo = [data objectForKey:@"engineNo"];
                if (![engineNo isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"engineNo"] forKey:@"engineNo"];
                }
                
                
                
                if (![[data objectForKey:@"insuranceTime"] isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"insuranceTime"] forKey:@"insuranceTime"];
                }
                
                if (![[data objectForKey:@"jqInsuranceTime"] isKindOfClass:[NSNull class]]) {
                    [self.dictionaryInfo setObject:[data objectForKey:@"jqInsuranceTime"] forKey:@"jqInsuranceTime"];
                }
                
    
                [self.myTableView reloadData];
                
                
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:response[@"errormsg"] complete:nil];
            
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            });
        }
        
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:error complete:nil];
        
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        });
    }];
}

#pragma mark - tabnleview detegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    } else if (section == 1){
        return 8;
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
            [cell setLabelNameText:@"*车牌号 :" isChoose:YES placeholderStr:@"请输入您的车牌号" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"plateNo"]) {
              cell.textField.text = [self.dictionaryInfo objectForKey:@"plateNo"];
            } else {
                cell.textField.text = @"";
            }
            
        } else if (indexPath.row == 1) {
            [cell setLabelNameText:@"*初登日期:" isChoose:YES placeholderStr:@"请输入您的初登日期" isSelect:NO];
            cell.textField.userInteractionEnabled = NO;
            if ([self.dictionaryInfo objectForKey:@"recordDate"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"recordDate"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 2){
            [cell setLabelNameText:@"*车 架  号:" isChoose:YES placeholderStr:@"请输入您的车架号" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"vinNo"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"vinNo"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 3){
            [cell setLabelNameText:@"*发动机号:" isChoose:YES placeholderStr:@"请输入您的发动机号" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"engineNo"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"engineNo"];
            } else {
                cell.textField.text = @"";
            }
        }  else if (indexPath.row == 4){
            [cell setLabelNameText:@"保险到期日期:" isChoose:NO placeholderStr:@"请选择日期" isSelect:YES];
            if ([self.dictionaryInfo objectForKey:@"insuranceTime"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"insuranceTime"];
            } else {
                cell.textField.text = @"";
            }
            cell.textField.userInteractionEnabled = NO;
        } else if (indexPath.row == 5){
            [cell setLabelNameText:@"年审到期日期:" isChoose:NO placeholderStr:@"请选择日期" isSelect:YES];
            cell.textField.userInteractionEnabled = NO;
            if ([self.dictionaryInfo objectForKey:@"motTestTime"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"motTestTime"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 6){
            [cell setLabelNameText:@"*品牌型号:" isChoose:YES placeholderStr:@"请输入您的品牌型号" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"brand"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"brand"];
            } else {
                cell.textField.text = @"";
            }
        }
        return cell;
    } else {
        if (indexPath.row == 0) {
            [cell setLabelNameText:@"*客户名称:" isChoose:YES placeholderStr:@"请输入您的客户名称" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"customerName"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"customerName"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 1) {
            [cell setLabelNameText:@"*客户来源:" isChoose:YES placeholderStr:@"请选择客户来源" isSelect:YES];
            cell.textField.userInteractionEnabled = NO;
            if ([self.dictionaryInfo objectForKey:@"source"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"source"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 2){
            [cell setLabelNameText:@"*联系方式:" isChoose:YES placeholderStr:@"请输入您的联系方式" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"phoneNo"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"phoneNo"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 3){
            [cell setLabelNameText:@"身份证号:" isChoose:NO placeholderStr:@"请输入您的身份证号码" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"identity"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"identity"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 4){
            [cell setLabelNameText:@"性      别:" isChoose:NO placeholderStr:@"请选择性别" isSelect:YES];
            cell.textField.userInteractionEnabled = NO;
            if ([self.dictionaryInfo objectForKey:@"sex"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"sex"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 5){
            [cell setLabelNameText:@"生      日:" isChoose:NO placeholderStr:@"请选择日期" isSelect: YES];
            cell.textField.userInteractionEnabled = NO;
            if ([self.dictionaryInfo objectForKey:@"birthday"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"birthday"];
            } else {
                cell.textField.text = @"";
            }
        } else if (indexPath.row == 6){
            [cell setLabelNameText:@"学      历:" isChoose:NO placeholderStr:@"请选择学历" isSelect:YES];
            cell.textField.userInteractionEnabled = NO;
            if ([self.dictionaryInfo objectForKey:@"education"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"education"];
            } else {
                cell.textField.text = @"";
            }
        }  else if(indexPath.row == 7) {
            [cell setLabelNameText:@"地      址:" isChoose:NO placeholderStr:@"请输入您的地址" isSelect:NO];
            cell.textField.userInteractionEnabled = YES;
            if ([self.dictionaryInfo objectForKey:@"address"]) {
                cell.textField.text = [self.dictionaryInfo objectForKey:@"address"];
            } else {
                cell.textField.text = @"";
            }
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
        
        
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"motTestTime"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"insuranceTime"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if (indexPath.section == 1 && indexPath.row == 5) {
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SelectTimeView *selectTV = [[SelectTimeView alloc] initWithFrame:self.view.frame];
        selectTV.block = ^(NSString * timeString) {
            cell.textField.text = timeString;
            [weakSelf.dictionaryInfo setObject:timeString forKey:@"birthday"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTV];
    } else if (indexPath.section == 1 && indexPath.row == 4){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       LYZSelectView *selectView = [LYZSelectView alterViewWithArray:@[@"男",@"女"] confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
            cell.textField.text = selectStr;
            [weakSelf.dictionaryInfo setObject:selectStr forKey:@"sex"];
        }];
        [self.view addSubview:selectView];
        
    } else if (indexPath.section == 1 && indexPath.row == 1){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        education
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
    } else if (indexPath.section == 1 && indexPath.row == 6){
        PriceCustomerInformEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (self.arrayEducation.count > 0) {
            LYZSelectView *selectView = [LYZSelectView alterViewWithArray:weakSelf.arrayEducation confirmClick:^(LYZSelectView *alertView, NSString *selectStr) {
                cell.textField.text = selectStr;
                [weakSelf.dictionaryInfo setObject:selectStr forKey:@"education"];
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
                            [weakSelf.dictionaryInfo setObject:selectStr forKey:@"education"];
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
        _myTableView.bounces = NO;
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
        if ([self.titleName isEqualToString:@"客户信息录入"]) {
            [_buttonSubmit setTitle:@"确认提交" forState:UIControlStateNormal];
        } else {
            [_buttonSubmit setTitle:@"保存" forState:UIControlStateNormal];
        }
        
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
