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
@interface XCCustomerADDViewController ()<PriceCustomerInformEntryTableViewCellDelegate>
@property (nonatomic, strong) NSNotification *notification;
@property (nonatomic, strong) NSMutableDictionary *dictionaryInfo;
@end

@implementation XCCustomerADDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _notification = [NSNotification notificationWithName:@"CustomerNotification" object:nil userInfo:nil];
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
    } else if (textField.tag == 2){
        [self.dictionaryInfo setObject:textField.text forKey:@"sex"];
    } else if (textField.tag == 3){
        [self.dictionaryInfo setObject:textField.text forKey:@"birthday"];
    } else if (textField.tag == 4){
        [self.dictionaryInfo setObject:textField.text forKey:@"area"];
    } else if (textField.tag == 5){
        [self.dictionaryInfo setObject:textField.text forKey:@"address"];
    } else if (textField.tag == 6){
        [self.dictionaryInfo setObject:textField.text forKey:@"identity"];
    } else if (textField.tag == 7){
        [self.dictionaryInfo setObject:textField.text forKey:@"plateNo"];
    } else if (textField.tag == 8){
        [self.dictionaryInfo setObject:textField.text forKey:@"brand"];
    } else if (textField.tag == 9){
        [self.dictionaryInfo setObject:textField.text forKey:@"recordDate"];
    } else if (textField.tag == 10){
        [self.dictionaryInfo setObject:textField.text forKey:@"vinNo"];
    } else if (textField.tag == 11){
        [self.dictionaryInfo setObject:textField.text forKey:@"vinNo"];
    } else if (textField.tag == 12){
        [self.dictionaryInfo setObject:textField.text forKey:@"model"];
    } else {
        [self.dictionaryInfo setObject:textField.text forKey:@"phoneNo"];
    }
    NSLog(@"%@",self.dictionaryInfo);
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 14;
    } else {
       return 1;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"cell";
        PriceCustomerInformEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCustomerInformEntryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.delegate = self;
        cell.textField.tag = indexPath.row;
        if (indexPath.row == 0) {
            cell.labelName.text = @"客户名称:";
        } else if (indexPath.row == 1) {
            cell.labelName.text = @"客户来源:";
        } else if (indexPath.row == 2){
            cell.labelName.text = @"性       别:";
        } else if (indexPath.row == 3){
            cell.labelName.text = @"生       日:";
        } else if (indexPath.row == 4){
            cell.labelName.text = @"区       域:";
        } else if (indexPath.row == 5){
            cell.labelName.text = @"地       址:";;
        } else if (indexPath.row == 6) {
            cell.labelName.text = @"身  份  证:";
        } else if (indexPath.row == 7){
            cell.labelName.text = @"车  牌  号:";
        } else if (indexPath.row == 8){
            cell.labelName.text = @"车  品  牌:";
        } else if (indexPath.row == 9){
            cell.labelName.text = @"初登日期:";
        } else if (indexPath.row == 10){
            cell.labelName.text = @"车  架  号:";;
        } else if (indexPath.row == 11){
            cell.labelName.text = @"发动机号:";
        } else if (indexPath.row == 12){
            cell.labelName.text = @"车型代码:";;
        }  else{
            cell.labelName.text = @"联系方式:";
        }
        return cell;
    } else {
        static NSString *identifier = @"submitIdentifier";
        PriceCustomerInformEntrySubmitTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceCustomerInformEntrySubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * ViewRateBaseOnIP6;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSLog(@"确认");
        [self pressCustomerInformationInput];
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

@end
