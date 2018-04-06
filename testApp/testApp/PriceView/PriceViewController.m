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

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark -network
- (void)getData{
}

- (void)pressCustomerVehicleEnquiries{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.textField.text forKey:@"criteria"];
    [RequestAPI getCustomerVehicleEnquiries:dic header:[UserInfoManager shareInstance].ticketID success:^(id response) {
        
        if (response[@"data"] && [response[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = response[@"data"];
            _nameView.labelContent.text = [data objectForKey:@"customerName"];
            _birthdayView.labelContent.text = [data objectForKey:@""];
            _sexView.labelContent.text = [data objectForKey:@"sex"];
            _addressView.labelContent.text = [data objectForKey:@"address"];
            _brandView.labelContent.text = [data objectForKey:@"brand"];
            _chassisView.labelContent.text = [data objectForKey:@"vinNO"];
            _engineView.labelContent.text = [data objectForKey:@"engineNo"];
            _modelsView.labelContent.text = [data objectForKey:@"model"];
            _bussinessRisksView.labelContent.text = [data objectForKey:@"insuranceTime"];
            NSNumber *jqInsuranceTime = [data objectForKey:@"jqInsuranceTime"] ;
            if (![jqInsuranceTime isKindOfClass:[NSNull class]]) {
              _insuranceView.labelContent.text = [jqInsuranceTime stringValue];
            }
            _salesmanView.labelContent.text = [data objectForKey:@"salesmanName"];
            
        }

    } fail:^(id error) {
        
    }];
}

#pragma mark- UI
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        [self pressCustomerVehicleEnquiries];
    }
    [textField endEditing:YES];
    return YES;
}

- (void)touchButtonPrice:(UIButton *)button{
    PriceCarInsuranceQViewController *priceCarVC = [[PriceCarInsuranceQViewController alloc] init];
    [self.navigationController pushViewController:priceCarVC animated:YES];
}

- (void)toucheButtonEntry:(UIButton *)button{
    PriceCustomerInformEntryViewController *priceCustomerVC = [[PriceCustomerInformEntryViewController alloc] init];
    [self.navigationController pushViewController:priceCustomerVC animated:YES];
}

- (void)createUI{
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.myScrollView];
    [self.topView addSubview:self.searchContenView];
    [self.searchContenView addSubview:self.textField];
    [self.myScrollView addSubview:self.priceButtonView];
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
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_TABBAR_HEIGHT - 20)];
    }
    return _contentView;
}
- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88 * ViewRateBaseOnIP6 , SCREEN_WIDTH, SCREEN_HEIGHT -(88 * ViewRateBaseOnIP6 + 20) - SCREEN_TABBAR_HEIGHT)];
        _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT -(88 * ViewRateBaseOnIP6 + 20) - SCREEN_TABBAR_HEIGHT);
        _myScrollView.bounces = NO;
        _myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.delegate = self;
        
    }
    return _myScrollView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88 * ViewRateBaseOnIP6)];
        _topView.backgroundColor = [UIColor whiteColor];
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 87 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
        segmentView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [_topView addSubview:segmentView];
    }
    return _topView;
}

- (UIView *)searchContenView {
    if (!_searchContenView) {
        _searchContenView = [[UIView alloc] initWithFrame:CGRectMake(105 * ViewRateBaseOnIP6, 16 * ViewRateBaseOnIP6, 540 * ViewRateBaseOnIP6, 56 * ViewRateBaseOnIP6)];
        _searchContenView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _searchContenView.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        _searchContenView.layer.masksToBounds = YES;
    }
    return _searchContenView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 500 * ViewRateBaseOnIP6, 38 * ViewRateBaseOnIP6)];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _textField.placeholder = @"车牌号/车架号";
        [_textField setValue:[UIColor colorWithHexString:@"#838383"] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:[UIFont boldSystemFontOfSize:26 * ViewRateBaseOnIP6] forKeyPath:@"_placeholderLabel.font"];
        UIImageView *rightView = [[UIImageView alloc]init];
        rightView.image = [UIImage imageNamed:@"search"];
        rightView.bounds = CGRectMake(-60 * ViewRateBaseOnIP6, 0, 38 * ViewRateBaseOnIP6, 38 * ViewRateBaseOnIP6);
        rightView.contentMode = UIViewContentModeCenter;
        _textField.rightView = rightView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 652 * ViewRateBaseOnIP6)];
        _infoView.backgroundColor = [UIColor whiteColor];
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
    if (!_modelsView) {
        _modelsView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.engineView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"车型代码:"];
    }
    return _modelsView;
}

- (PriceInfoCellView *)bussinessRisksView{
    if (!_bussinessRisksView) {
        _bussinessRisksView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.modelsView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"商业险起保日期:"];
    }
    return _bussinessRisksView;
}

- (PriceInfoCellView *)insuranceView{
    if (!_insuranceView) {
        _insuranceView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bussinessRisksView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"交强险起保日期:"];
    }
    return _insuranceView;
}

- (PriceInfoCellView *)salesmanView{
    if (!_salesmanView) {
        _salesmanView = [[PriceInfoCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.insuranceView.frame) + 30 * ViewRateBaseOnIP6, SCREEN_WIDTH, 26 * ViewRateBaseOnIP6) withLabelNameText:@"所属携创业务员:"];
        _salesmanView.labelContent.text = @"老王";
    }
    return _salesmanView;
}

- (UIView *)priceButtonView{
    if (!_priceButtonView) {
        _priceButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.myScrollView.frame))];
        _priceButtonView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
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
        _buttonPrice.backgroundColor = [UIColor colorWithHexString:@"#004da2"];
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
