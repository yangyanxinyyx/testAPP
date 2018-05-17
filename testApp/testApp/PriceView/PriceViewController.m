//
//  PriceViewController.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceViewController.h"
#import "PriceInfoViewController.h"
#import "PriceInspectViewController.h"
#import "PriceCarInsuranceQViewController.h"
#import "PriceCustomerInformEntryViewController.h"
#import "PriceUnderwritingViewController.h"
#import "PriceAdjustViewController.h"
#import "PriceInfoCellView.h"
#import "PriceCustomerInformEntryViewController.h"
#import "PriceCarInsuranceQViewController.h"
#import "PriceCustomerModel.h"
#import <MJRefresh/MJRefresh.h>
@interface PriceViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIView *searchContenView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) PriceInfoCellView *nameView;
@property (nonatomic, strong) PriceInfoCellView *birthdayView;
@property (nonatomic, strong) PriceInfoCellView *sexView;
@property (nonatomic, strong) PriceInfoCellView *addressView;
@property (nonatomic, strong) PriceInfoCellView *brandView;
@property (nonatomic, strong) PriceInfoCellView *chassisView;
@property (nonatomic, strong) PriceInfoCellView *engineView;
@property (nonatomic, strong) PriceInfoCellView *modelsView;
@property (nonatomic, strong) PriceInfoCellView *bussinessRisksView;
@property (nonatomic, strong) PriceInfoCellView *insuranceView;
@property (nonatomic, strong) PriceInfoCellView *salesmanView;

@property (nonatomic, strong) UIView *priceButtonView;
@property (nonatomic, strong) UIButton *buttonPrice;
@property (nonatomic, strong) UIButton *buttonInfoEntry;
@property (nonatomic, strong) NSString *carID;
@property (nonatomic, strong) NSString *customerId;

@property (nonatomic, strong) UIView *backView;

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:kNOTIFICATION_LOGINOUT object:nil];

}


- (void)InfoNotificationAction:(NSNotification *)notification{
    
    self.textField.text = @"";
    [self pressCustomerVehicleEnquiriesWithCriteria:@""];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:self];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)toucheSearch:(UIButton *)button{
    if (_textField.text.length > 0) {
        [self pressCustomerVehicleEnquiriesWithCriteria:_textField.text];
    }
    [_textField endEditing:YES];
}

#pragma mark -network


- (void)pressCustomerVehicleEnquiriesWithCriteria:(NSString *)criteria{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:criteria forKey:@"criteria"];
    [RequestAPI getCustomerVehicleEnquiries:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _buttonPrice.backgroundColor = [UIColor colorWithHexString:@"#004da2"];
                _buttonPrice.userInteractionEnabled = YES;
                _infoView.hidden = NO;
                NSDictionary *data = response[@"data"];
                NSNumber *customerName = [data objectForKey:@"customerName"];
                if (![customerName isKindOfClass:[NSNull class]]) {
                   _nameView.labelContent.text = [data objectForKey:@"customerName"];
                }
                
                NSNumber *birthday = [data objectForKey:@"birthday"];
                if (![birthday isKindOfClass:[NSNull class]]) {
                    _birthdayView.labelContent.text = [data objectForKey:@"birthday"];
                }
                
                NSNumber *sex = [data objectForKey:@"sex"];
                if (![sex isKindOfClass:[NSNull class]]) {
                    _sexView.labelContent.text = [data objectForKey:@"sex"];
                }
                
                NSNumber *address = [data objectForKey:@"address"];
                if (![address isKindOfClass:[NSNull class]]) {
                    _addressView.labelContent.text = [data objectForKey:@"address"];
                }
                
                NSNumber *brand = [data objectForKey:@"brand"];
                if (![brand isKindOfClass:[NSNull class]]) {
                    _brandView.labelContent.text = [data objectForKey:@"brand"];
                }
                
                NSNumber *vinNo = [data objectForKey:@"vinNo"];
                if (![vinNo isKindOfClass:[NSNull class]]) {
                    _chassisView.labelContent.text = [data objectForKey:@"vinNo"];
                }
                
                NSNumber *engineNo = [data objectForKey:@"engineNo"];
                if (![engineNo isKindOfClass:[NSNull class]]) {
                    _engineView.labelContent.text = [data objectForKey:@"engineNo"];
                }
                
                NSNumber *model = [data objectForKey:@"model"];
                if (![model isKindOfClass:[NSNull class]]) {
                    _modelsView.labelContent.text = [data objectForKey:@"model"];
                }
            
                if (![[data objectForKey:@"insuranceTime"] isKindOfClass:[NSNull class]]) {
                    _bussinessRisksView.labelContent.text = [data objectForKey:@"insuranceTime"];
                }
                
                if (![[data objectForKey:@"jqInsuranceTime"] isKindOfClass:[NSNull class]]) {
                    _insuranceView.labelContent.text = [data objectForKey:@"jqInsuranceTime"];
                }
                NSNumber *salesmanName = [data objectForKey:@"salesmanName"];
                if (![salesmanName isKindOfClass:[NSNull class]] ) {
                    _salesmanView.labelContent.text = [data objectForKey:@"salesmanName"];
                }
                
                NSNumber *carIDNumber = [data objectForKey:@"carId"];
                if (![carIDNumber isKindOfClass:[NSNull class]] && [carIDNumber stringValue].length != 0) {
                    self.carID = [NSString stringWithFormat:@"%ld",[carIDNumber longValue]];
                }
                NSNumber *customerIdNumber = [data objectForKey:@"customerId"];
                if (![customerIdNumber isKindOfClass:[NSNull class]] && [customerIdNumber stringValue].length != 0) {
                    self.customerId = [NSString stringWithFormat:@"%ld",[customerIdNumber longValue]];
                }
                
                NSNumber *carID = [data objectForKey:@"carId"];
                if (![carID isKindOfClass:[NSNull class]]) {
                    [UserInfoManager shareInstance].carID = [NSString stringWithFormat:@"%ld",[carID longValue]];
                }
                
                NSNumber *customerId = [data objectForKey:@"customerId"];
                if (![customerId isKindOfClass:[NSNull class]]){
                    [UserInfoManager shareInstance].customerId = [NSString stringWithFormat:@"%ld",[customerId longValue]];
                }
                
                if (![customerName isKindOfClass:[NSNull class]]){
                    [UserInfoManager shareInstance].customerName = [data objectForKey:@"customerName"];
                }
                NSNumber *identity = [data objectForKey:@"identity"];
                if (![identity isKindOfClass:[NSNull class]]){
                    [UserInfoManager shareInstance].identity = [data objectForKey:@"identity"];
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:response[@"errormsg"] complete:nil];
                _infoView.hidden = YES;
                _buttonPrice.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
                _buttonPrice.userInteractionEnabled = NO;
                [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
            });
        }

    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FinishTipsView *finishTV = [[FinishTipsView alloc] initWithTitle:error complete:nil];
            _infoView.hidden = YES;
            _buttonPrice.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
            _buttonPrice.userInteractionEnabled = NO;
            [[UIApplication sharedApplication].keyWindow addSubview:finishTV];
        });
    }];
}

#pragma mark - function
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        [self pressCustomerVehicleEnquiriesWithCriteria:textField.text];
    } else {
        _infoView.hidden = YES;
    }
    [textField endEditing:YES];
    return YES;
}

- (void)touchButtonPrice:(UIButton *)button{
    if (!self.carID) {
        return;
    }
    PriceCarInsuranceQViewController *priceCarVC = [[PriceCarInsuranceQViewController alloc] init];
    priceCarVC.carID = self.carID;
    priceCarVC.customerId = self.customerId;
    [self.navigationController pushViewController:priceCarVC animated:YES];
}

- (void)toucheButtonEntry:(UIButton *)button{
    PriceCustomerInformEntryViewController *priceCustomerVC = [[PriceCustomerInformEntryViewController alloc] init];
    priceCustomerVC.titleName = @"客户信息录入";
    __weak typeof (self)weakSelf = self;
    priceCustomerVC.requestSucces = ^(NSString * planNO) {
        [weakSelf pressCustomerVehicleEnquiriesWithCriteria:planNO];
    };
    [self.navigationController pushViewController:priceCustomerVC animated:YES];
}

- (void)refresh{
    if (_textField.text.length > 0) {
        [self pressCustomerVehicleEnquiriesWithCriteria:_textField.text];
    } else {
        _infoView.hidden = YES;
        _buttonPrice.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
        _buttonPrice.userInteractionEnabled = NO;
    }
    [_textField endEditing:YES];
    [self.myScrollView.mj_header endRefreshing];
    
}
#pragma mark- UI

- (void)createUI{
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.myScrollView];
    [self.topView addSubview:self.searchContenView];
    [self.searchContenView addSubview:self.textField];
    [self.myScrollView addSubview:self.priceButtonView];
    [self.myScrollView addSubview:self.backView];
    [self.myScrollView addSubview:self.infoView];
    [self.infoView addSubview:self.nameView];
    [self.infoView addSubview:self.birthdayView];
    [self.infoView addSubview:self.sexView];
    [self.infoView addSubview:self.addressView];
    [self.infoView addSubview:self.brandView];
    [self.infoView addSubview:self.chassisView];
    [self.infoView addSubview:self.engineView];
    [self.infoView addSubview:self.modelsView];
    [self.infoView addSubview:self.bussinessRisksView];
    [self.infoView addSubview:self.insuranceView];
    [self.infoView addSubview:self.salesmanView];
    [self.priceButtonView addSubview:self.buttonPrice];
    [self.priceButtonView addSubview:self.buttonInfoEntry];
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation - 44, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_TABBAR_HEIGHT - 20)];
        _contentView.backgroundColor = [UIColor whiteColor];

    }
    return _contentView;
}

- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SCREEN_TABBAR_HEIGHT)];
        _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SCREEN_TABBAR_HEIGHT);
        _myScrollView.bounces = YES;
        _myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.delegate = self;
        _myScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
    }
    return _myScrollView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 )];
        _topView.backgroundColor = [UIColor whiteColor];
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 87 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1)];
        segmentView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [_topView addSubview:segmentView];
    }
    return _topView;
}

- (UIView *)searchContenView {
    if (!_searchContenView) {
        _searchContenView = [[UIView alloc] initWithFrame:CGRectMake(105 * ViewRateBaseOnIP6, 16 * ViewRateBaseOnIP6, 540 * ViewRateBaseOnIP6, 28)];
        _searchContenView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _searchContenView.layer.cornerRadius = 5;
        _searchContenView.layer.masksToBounds = YES;
    }
    return _searchContenView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 500 * ViewRateBaseOnIP6, 19 )];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.returnKeyType = UIReturnKeyGo;
        _textField.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _textField.placeholder = @"车牌号/车架号";
        [_textField setValue:[UIColor colorWithHexString:@"#838383"] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:[UIFont boldSystemFontOfSize:26 * ViewRateBaseOnIP6] forKeyPath:@"_placeholderLabel.font"];
        UIButton *rightView = [[UIButton alloc]init];
        [rightView setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        rightView.bounds = CGRectMake(-60 * ViewRateBaseOnIP6, 0, 18, 18);
        rightView.contentMode = UIViewContentModeCenter;
        [rightView addTarget:self action:@selector(toucheSearch:) forControlEvents:UIControlEventTouchDown];
        _textField.rightView = rightView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.delegate = self;
//        _textField.text = @"粤AS5665";
//        _textField.text = @"粤A785XQ";
    }
    return _textField;
}


- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavMargan, SCREEN_WIDTH, 652 * ViewRateBaseOnIP6)];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(325 * ViewRateBaseOnIP6, 400 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6)];
        imageView.image = [UIImage imageNamed:@"noClient"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 * ViewRateBaseOnIP6, 520 * ViewRateBaseOnIP6, SCREEN_WIDTH, 23 * ViewRateBaseOnIP6)];
        label.text = @"无客户信息";
        label.textColor = [UIColor colorWithHexString:@"#a5a5a5"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:23 * ViewRateBaseOnIP6];
        [_backView addSubview:imageView];
        [_backView addSubview:label];
        
        
    }
    return _backView;
}
- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 652 * ViewRateBaseOnIP6)];
        _infoView.backgroundColor = [UIColor whiteColor];
        _infoView.hidden = YES;
    }
    return _infoView;
}


- (PriceInfoCellView *)nameView{
    if (!_nameView) {
        _nameView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"客户名称:"];
        _nameView.labelContent.text = @"刘某某";
    }
    return _nameView;
}

- (PriceInfoCellView *)birthdayView{
    if (!_birthdayView) {
        _birthdayView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"客户生日:"];
    }
    return _birthdayView;
}

- (PriceInfoCellView *)sexView{
    if (!_sexView) {
        _sexView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.birthdayView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"性       别:"];
    }
    return _sexView;
}

- (PriceInfoCellView *)addressView{
    if (!_addressView) {
        _addressView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sexView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"地       址:"];
    }
    return _addressView;
}

- (PriceInfoCellView *)brandView{
    if (!_brandView) {
        _brandView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"车  品  牌:"];
    }
    return _brandView;
}

- (PriceInfoCellView *)chassisView{
    if (!_chassisView) {
        _chassisView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.brandView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"车  架  号:"];
    }
    return _chassisView;
}

- (PriceInfoCellView *)engineView{
    if (!_engineView) {
        _engineView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chassisView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"发动机号:"];
    }
    return _engineView;
}


- (PriceInfoCellView *)modelsView{
    if (_modelsView) {
        _modelsView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.engineView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"车型代码:"];
    }
    return _modelsView;
}

- (PriceInfoCellView *)bussinessRisksView{
    if (!_bussinessRisksView) {
        _bussinessRisksView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.engineView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"保险到期日期:"];
    }
    return _bussinessRisksView;
}

- (PriceInfoCellView *)insuranceView{
    if (!_insuranceView) {
        _insuranceView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bussinessRisksView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"年审到期日期:"];
    }
    return _insuranceView;
}

- (PriceInfoCellView *)salesmanView{
    if (!_salesmanView) {
        _salesmanView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.insuranceView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"所属携创业务员:"];
        
    }
    return _salesmanView;
}

- (UIView *)priceButtonView{
    if (!_priceButtonView) {
        _priceButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.myScrollView.frame))];
        _priceButtonView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    }
    return _priceButtonView;
}
- (UIButton *)buttonPrice{
    if (!_buttonPrice) {
        _buttonPrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonPrice.frame = CGRectMake(30 * ViewRateBaseOnIP6, 926 * ViewRateBaseOnIP6, SCREEN_WIDTH - 60 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
        [_buttonPrice setTitle:@"报价" forState:UIControlStateNormal];
        [_buttonPrice.titleLabel setFont:[UIFont systemFontOfSize:34 * ViewRateBaseOnIP6]];
        _buttonPrice.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        _buttonPrice.layer.masksToBounds = YES;
        _buttonPrice.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
        _buttonPrice.userInteractionEnabled = NO;
        [_buttonPrice addTarget:self action:@selector(touchButtonPrice:) forControlEvents:UIControlEventTouchDown];
    }
    return _buttonPrice;
}

- (UIButton *)buttonInfoEntry{
    if (!_buttonInfoEntry) {
        _buttonInfoEntry = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonInfoEntry.frame = CGRectMake(566 * ViewRateBaseOnIP6, 20 * ViewRateBaseOnIP6 + CGRectGetMaxY(self.buttonPrice.frame), 155 * ViewRateBaseOnIP6, 25 * ViewRateBaseOnIP6);
        _buttonInfoEntry.titleLabel.font = [UIFont systemFontOfSize:25 * ViewRateBaseOnIP6];
        [_buttonInfoEntry setTitleColor:[UIColor colorWithHexString:@"#004da2"] forState:UIControlStateNormal];
        [_buttonInfoEntry addTarget:self action:@selector(toucheButtonEntry:) forControlEvents:UIControlEventTouchDown];
        [_buttonInfoEntry setTitle:@"客户信息录入" forState:UIControlStateNormal];
//        _buttonInfoEntry.backgroundColor = [UIColor clearColor];
    }
    return _buttonInfoEntry;
}


@end
