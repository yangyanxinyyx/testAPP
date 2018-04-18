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
#import "SelectSheetView.h"
#import "InsuranceCompanyModel.h"
@interface PriceUnderwritingViewController ()<BaseNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,PriceUnderwritingImportTableViewCellDelegate,PriceUnderwritingTextTableViewCellDelegate,PriceUnderwritingSureTableViewCellDelegate,PriceUnderwritingRenewalTableViewCellDelegate,PriceUnderwritingTableViewCellDelegate>
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSNotification *notification;
@property (nonatomic, strong) SelectSheetView *selectSheetVCompany;
@property (nonatomic, strong) SelectSheetView *selectSheetVInstitution;
@property (nonatomic, strong) NSString *syEffectDate; //商业起保时间;
@property (nonatomic, strong) NSString *jqEffectDate; //交强起保时间;
@property (nonatomic, strong) NSString *isContinue; //是否续保
@property (nonatomic, strong) NSString *exportUnitName; //出单机构名单
@property (nonatomic, strong) NSString *insurerId; //保险公司id
@property (nonatomic, strong) NSString *insurerName; //保险公司名称
@property (nonatomic, strong) NSMutableArray *arrayBillingAgency;
@property (nonatomic, strong) NSMutableArray *arrayInsuranceCompany;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *onwerIdentify;
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
    [self setStatus];
    [self createUI];
}

- (void)setStatus{
    _isContinue = @"N";
}

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark method
- (void)setFinishTVWithTitle:(NSString *)titile{
    FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:titile complete:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
}



#pragma mark - getNetWork
//获取出单机构
- (void)requestBillingAgency{
    if (self.arrayBillingAgency.count > 0) {
        _selectSheetVCompany.hidden = NO;
        return;
    }
    NSDictionary *dic = @{
                          @"dictCode":@"export_policy_org_unit"
                          };
    __block typeof(self) weakSelf = self;
    [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = response[@"data"];
            for (NSDictionary *dic in data) {
                [weakSelf.arrayBillingAgency addObject:[dic objectForKey:@"content"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_selectSheetVCompany setDataWithDataArray:weakSelf.arrayBillingAgency];
                _selectSheetVCompany.hidden = NO;
            });
        }
    } fail:^(id error) {
        
    }];
}

// 获取保险公司
- (void)requestInsuranceCompany{
    if (!_exportUnitName&&_exportUnitName.length == 0) {
        FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"请先选择出单机构" complete:nil];
        [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        return;
    }
    [self.arrayInsuranceCompany removeAllObjects];
    __block typeof(self) weakSelf = self;
    NSDictionary *dic = @{
                          @"dictCode":_exportUnitName
                          };
    [RequestAPI getInsuredrice:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = response[@"data"];
            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                InsuranceCompanyModel *model = [[InsuranceCompanyModel alloc] init];
                NSNumber *insureID = [dic objectForKey:@"id"];
                if (![insureID isKindOfClass:[NSNull class]]) {
                    model.insurerId = [NSString stringWithFormat:@"%ld", [insureID longValue]];
                }
                model.insurerName = [dic objectForKey:@"content"];
                [weakSelf.arrayInsuranceCompany addObject:model];
                [dataArray addObject:[dic objectForKey:@"content"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_selectSheetVInstitution setDataWithDataArray:dataArray];
                _selectSheetVInstitution.hidden = NO;
            });
        }
    } fail:^(id error) {
        
    }];
}


- (void)submitUnderwriting{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserInfoManager shareInstance].customerId forKey:@"customerId"];
    [dic setObject:[UserInfoManager shareInstance].customerName forKey:@"customerName"];
    [dic setObject:[UserInfoManager shareInstance].carID forKey:@"carId"];
    [dic setObject:_onwerIdentify forKey:@"onwerIdentify"];
    NSString *string ;
    if (_syEffectDate) {
        [dic setObject:_syEffectDate forKey:@"syEffectDate"];
    } else {
        string = @"请填写商业险起保时间";
        [self setFinishTVWithTitle:string];
        return;
    }
    
    if (_jqEffectDate) {
        [dic setObject:_jqEffectDate forKey:@"jqEffectDate"];
    } else {
        string = @"请填写交强险起保时间";
        [self setFinishTVWithTitle:string];
        return;
    }
    
    if (_isContinue) {
        [dic setObject:_isContinue forKey:@"isContinue"];
    }
    
    if (_exportUnitName) {
        [dic setObject:_exportUnitName forKey:@"exportUnitName"];
    } else {
        string = @"请选择出单机构";
        [self setFinishTVWithTitle:string];
        return;
    }
    
    if (_insurerId) {
        [dic setObject:_insurerId forKey:@"insurerId"];
    } else {
        string = @"请选择保险公司";
        [self setFinishTVWithTitle:string];
        return;
    }
    
    
    if (_insurerName) {
        [dic setObject:_insurerName forKey:@"insurerName"];
    } else {
        string = @"请填写商业险金额";
        [self setFinishTVWithTitle:string];
        return;
    }
    
    if (_bussiseNum) {
        [dic setObject:self.bussiseNum forKey:@"syMoney"];
    } else {
        string = @"请填写交强险金额";
        [self setFinishTVWithTitle:string];
        return;
    }
    
    if (_remark) {
        [dic setObject:_remark forKey:@"remark"];
    } else {
        [dic setObject:@"" forKey:@"remark"];
    }
    
    
    
    //交强险
    PriceInfoModel *jqModel = [self.dataArray firstObject];
    [dic setObject:[NSString stringWithFormat:@"%f",jqModel.number] forKey:@"jqMoney"];
    [dic setObject:jqModel.isToubao forKey:@"jqIsSelect"];

    //车损
    PriceInfoModel *csModel = [self.dataArray objectAtIndex:1];
    [dic setObject:csModel.isToubao forKey:@"csIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",csModel.priceValue] forKey:@"csValue"];
    [dic setObject:csModel.isMianpei forKey:@"csWithout"];
    
    //第三者
    PriceInfoModel *szModel = [self.dataArray objectAtIndex:2];
    [dic setObject:szModel.isToubao forKey:@"szIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",szModel.priceValue] forKey:@"szValue"];
    [dic setObject:szModel.isMianpei forKey:@"szWithout"];
    
    //车上司机
    PriceInfoModel *sjModel = [self.dataArray objectAtIndex:3];
    [dic setObject:sjModel.isToubao forKey:@"cssjIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",sjModel.priceValue] forKey:@"cssjValue"];
    [dic setObject:sjModel.isMianpei forKey:@"cssjWithout"];
    
    //车上乘客
    PriceInfoModel *ckModel = [self.dataArray objectAtIndex:4];
    [dic setObject:ckModel.isToubao forKey:@"csckIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",ckModel.priceValue] forKey:@"csckValue"];
    [dic setObject:ckModel.isMianpei forKey:@"csckWithout"];
    
    //车身划痕
    PriceInfoModel *hhModel = [self.dataArray objectAtIndex:5];
    [dic setObject:hhModel.isToubao forKey:@"cshhIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",hhModel.priceValue] forKey:@"cshhValue"];
    [dic setObject:hhModel.isMianpei forKey:@"cshhWithout"];
    
    //盗抢
    PriceInfoModel *dqModel = [self.dataArray objectAtIndex:6];
    [dic setObject:dqModel.isToubao forKey:@"dqIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",dqModel.priceValue] forKey:@"dqValue"];
    [dic setObject:dqModel.isMianpei forKey:@"dqWithout"];

    //发动机涉水险
    PriceInfoModel *fdjssModel = [self.dataArray objectAtIndex:7];
    [dic setObject:fdjssModel.isToubao forKey:@"fdjssIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",fdjssModel.priceValue] forKey:@"fdjssValue"];
    [dic setObject:fdjssModel.isMianpei forKey:@"fdjssWithout"];
    
    
    //自燃险
    PriceInfoModel *zrModel = [self.dataArray objectAtIndex:8];
    [dic setObject:zrModel.isToubao forKey:@"zrxIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f",zrModel.priceValue] forKey:@"zrxValue"];
    [dic setObject:zrModel.isMianpei forKey:@"zrxWithout"];
    
    //玻璃
    PriceInfoModel *blModel = [self.dataArray objectAtIndex:9];
    [dic setObject:blModel.isToubao forKey:@"blpsIsSelect"];
    [dic setObject:[NSString stringWithFormat:@"%f", blModel.priceValue] forKey:@"blpsValue"];
    
    //无法找到第三方
    PriceInfoModel *wsModel = [self.dataArray objectAtIndex:10];
    [dic setObject:wsModel.isToubao forKey:@"wfzddsfIsSelect"];
    
    
    [RequestAPI getUnderwriting:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        if ([response[@"reult"] isEqualToString:@"1"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:@"提交成功,待审核" complete:^{
                    
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:response[@"errormsg"] complete:^{
                    
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

#pragma mark- cell delegate

//身份证
- (void)getUnderwritingTextField:(UITextField *)textField{
    if ([UserInfoManager shareInstance].identity.length == 0 || ![UserInfoManager shareInstance].identity) {
        _onwerIdentify = [UserInfoManager shareInstance].identity;
    } else {
        _onwerIdentify = textField.text;
    }
    
}

- (void)textViewChangeWithTextView:(UITextView *)textView{
    _remark = textView.text;
    NSLog(@"%@",textView.text);
}

- (void)textViewBeginWithTextView:(UITextView *)textView{
    _remark = textView.text;
    [UIView animateWithDuration:0.2 animations:^{
      self.myTableView.contentOffset = CGPointMake(0, 520 * ViewRateBaseOnIP6);
    }];
}

-(void)textViewENDWithTextView:(UITextView *)textView{
    _remark = textView.text;
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

//是否续保
- (void)getRenewalStatus:(BOOL)status{
    if (!status) {
        _isContinue = @"Y";
    } else {
        _isContinue = @"N";
    }
}

- (void)comfirmToSubmit{
    NSLog(@"确认提交");
    [self submitUnderwriting];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 4) {
        static NSString *identifier = @"identifierInfo";
        PriceUnderwritingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if (indexPath.row == 0) {
            cell.labelName.text = @"投保人:";
            cell.labelInfo.text = [UserInfoManager shareInstance].customerName;
            [cell setTextFieldInfoHidden:YES];
            
        } else if (indexPath.row == 1) {
            cell.labelName.text = @"身份证:";
            cell.textFieldInfo.text = [UserInfoManager shareInstance].identity;
            [cell setTextFieldInfoHidden:NO];
            _onwerIdentify = [UserInfoManager shareInstance].identity;
            cell.delegate = self;
        } else if (indexPath.row == 2) {
            cell.labelName.text = @"出单人:";
            cell.labelInfo.text = [UserInfoManager shareInstance].employeeName;
            [cell setTextFieldInfoHidden:YES];
        } else {
            cell.labelName.text = @"出单日期:";
            cell.labelInfo.text = @"2018年01月6日";
            [cell setTextFieldInfoHidden:YES];
        }
        return cell;
        
    } else if (indexPath.row < 8 && indexPath.row > 3){
        static NSString *identifeir = @"identifierchoose";
        PriceUnderwritingChooseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifeir];
        if (!cell) {
            cell = [[PriceUnderwritingChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifeir];
        }
        if (indexPath.row == 4) {
            cell.labelName.text = @"(商业)起保日期";
        } else if (indexPath.row == 5) {
            cell.labelName.text = @"(交强)起保日期";
        } else if (indexPath.row == 6){
            cell.labelName.text = @"出单机构";
        } else {
            cell.labelName.text = @"保险公司";
        }
          
        return cell;
        
    } else if (indexPath.row < 10 && indexPath.row > 7){
        static NSString *identifier= @"identififerText";
        PriceUnderwritingTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.delegate = self;
        if (indexPath.row == 9) {
            cell.labelName.text = @"交强险(业务员)金额:";
            PriceInfoModel *inforModel = [self.dataArray objectAtIndex:0];
            cell.textFieldMoney.text = [NSString stringWithFormat:@"%0.2f", inforModel.number];
            
        } else {
            cell.labelName.text = @"商业险(业务员)金额:";
            cell.textFieldMoney.text = self.bussiseNum;
        }
        return cell;
    } else if (indexPath.row == 10) {
        static NSString *identifier = @"identifierRenewal";
        PriceUnderwritingRenewalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PriceUnderwritingRenewalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.delegate = self;
        return cell;
    } else if (indexPath.row == 11){
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
    if (indexPath.row == 11) {
        return 233 * ViewRateBaseOnIP6;
    } else if (indexPath.row == 12 ){
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
   __block typeof(self) weakSelf = self;
    
    if (indexPath.row == 3) {
        SelectTimeView *busSelectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow addSubview:busSelectTimeV];
        busSelectTimeV.block = ^(NSString *timeStr) {
            PriceUnderwritingTableViewCell *cell = [weakSelf.myTableView cellForRowAtIndexPath:indexPath];
            cell.labelInfo.text = timeStr;
            _syEffectDate = timeStr;
        };
    }
    
    if (indexPath.row == 4) {
        SelectTimeView *busSelectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow addSubview:busSelectTimeV];
        busSelectTimeV.block = ^(NSString *timeStr) {
            PriceUnderwritingChooseTableViewCell *cell = [weakSelf.myTableView cellForRowAtIndexPath:indexPath];
            cell.labelTag.text = timeStr;
            _syEffectDate = timeStr;
        };
    }
    if (indexPath.row == 5) {
        SelectTimeView *jqSelectTimeV = [[SelectTimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow addSubview: jqSelectTimeV];
        jqSelectTimeV.block = ^(NSString *timeStr) {
            PriceUnderwritingChooseTableViewCell *cell = [weakSelf.myTableView cellForRowAtIndexPath:indexPath];
            cell.labelTag.text = timeStr;
            _jqEffectDate = timeStr;

        };
    }
    
    if (indexPath.row == 6) {
        _selectSheetVCompany.block = ^(NSInteger tag) {
            weakSelf.exportUnitName = [weakSelf.arrayBillingAgency objectAtIndex:tag];
            PriceUnderwritingChooseTableViewCell *cell = [weakSelf.myTableView cellForRowAtIndexPath:indexPath];
            cell.labelTag.text = weakSelf.exportUnitName;
        };
        [self requestBillingAgency];
    }
    
    if (indexPath.row == 7) {
        _selectSheetVInstitution.block = ^(NSInteger tag) {
            InsuranceCompanyModel *model = [weakSelf.arrayInsuranceCompany objectAtIndex:tag];
            PriceUnderwritingChooseTableViewCell *cell = [weakSelf.myTableView cellForRowAtIndexPath:indexPath];
            cell.labelTag.text = model.insurerName;
            _insurerId = model.insurerId;
            _insurerName = model.insurerName;
            
        };
        [self requestInsuranceCompany];
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

#pragma mark- UI
- (void)createUI{
    [self.view addSubview:self.viewContent];
    [self.viewContent addSubview:self.myTableView];
    
    _selectSheetVCompany = [[SelectSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_selectSheetVCompany];
    _selectSheetVCompany.hidden = YES;
    
    _selectSheetVInstitution = [[SelectSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_selectSheetVInstitution];
    _selectSheetVInstitution.hidden = YES;
}
- (UIView *)viewContent{
    if (!_viewContent) {
        _viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _viewContent.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    }
    return _viewContent;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorColor = [UIColor colorWithHexString:@"#f2f2f2"];
        //取消滚动条的显示
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.bounces = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (NSMutableArray *)arrayBillingAgency{
    if (!_arrayBillingAgency) {
        _arrayBillingAgency = [NSMutableArray array];
    }
    return _arrayBillingAgency;
}

- (NSMutableArray *)arrayInsuranceCompany{
    if (!_arrayInsuranceCompany) {
        _arrayInsuranceCompany = [NSMutableArray array];
    }
    return _arrayInsuranceCompany;
}



@end
