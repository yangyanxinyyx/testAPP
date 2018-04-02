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
@interface PriceViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIView *searchContenView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.myScrollView];
    [self.topView addSubview:self.searchContenView];
    [self.searchContenView addSubview:self.textField];
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_TABBAR_HEIGHT)];
    }
    return _contentView;
}
- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88 * ViewRateBaseOnIP6 , SCREEN_WIDTH, SCREEN_WIDTH -(88 * ViewRateBaseOnIP6 + 22) -SCREEN_TABBAR_HEIGHT)];
        _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
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
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 88 * ViewRateBaseOnIP6, SCREEN_WIDTH, 1 * ViewRateBaseOnIP6)];
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
        _textField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _textField.placeholder = @"车牌号/车架号";
        [_textField setValue:[UIColor colorWithHexString:@"#838383"] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:[UIFont boldSystemFontOfSize:26 * ViewRateBaseOnIP6] forKeyPath:@"_placeholderLabel.font"];
        UIImageView *rightView = [[UIImageView alloc]init];
        rightView.image = [UIImage imageNamed:@"search"];
        rightView.bounds = CGRectMake(-60 * ViewRateBaseOnIP6, 0, 38 * ViewRateBaseOnIP6, 38 * ViewRateBaseOnIP6);
        rightView.contentMode = UIViewContentModeCenter;
        _textField.rightView = rightView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}


@end
