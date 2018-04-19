//
//  XCCustomerShopListView.m
//  testApp
//
//  Created by Melody on 2018/4/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCustomerShopListView.h"
#import "UILabel+createLabel.h"
#import "XCCustomerShopSrcollerViewCell.h"
@interface XCCustomerShopListView ()<XCCustomerShopSrcollerViewCellDelegate>
@property (nonatomic, strong) UIView * topView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLable ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * cancelBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * comfirmBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) UIScrollView * scrollView ;
@property (nonatomic, copy) confirmBlock confirmblock;

@end
@implementation XCCustomerShopListView

#pragma mark - lifeCycle
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_topView setFrame:CGRectMake(0, 629 * ViewRateBaseOnIP6, self.bounds.size.width, 88 *ViewRateBaseOnIP6)];
    [_cancelBtn sizeToFit];
    [_cancelBtn setFrame:CGRectMake(30 *ViewRateBaseOnIP6, (88 - 30) * ViewRateBaseOnIP6 * 0.5 , _cancelBtn.frame.size.width, 30 * ViewRateBaseOnIP6)];
    [_titleLable sizeToFit];
    [_titleLable setFrame:CGRectMake((self.bounds.size.width - _titleLable.frame.size.width) * 0.5, (88 - 32) * ViewRateBaseOnIP6 * 0.5,  _titleLable.frame.size.width, 32 * ViewRateBaseOnIP6)];
    [_comfirmBtn sizeToFit];
    [_comfirmBtn setFrame:CGRectMake(self.bounds.size.width - 30 * ViewRateBaseOnIP6 - _comfirmBtn.frame.size.width, _cancelBtn.frame.origin.y, _comfirmBtn.frame.size.width, 30 * ViewRateBaseOnIP6)];
    [_scrollView setFrame:CGRectMake(0, 717 * ViewRateBaseOnIP6, self.bounds.size.width, self.bounds.size.height -  717 * ViewRateBaseOnIP6)];
    
    CGFloat cellHeight = 88 * ViewRateBaseOnIP6;
    if (self.dataArr) {
        [self.scrollView setContentSize:CGSizeMake(0, cellHeight * (self.dataArr.count + 1))];
        for (int i = 0 ; i < self.dataArr.count; i++) {
            XCCustomerShopSrcollerViewCell *cell = [[XCCustomerShopSrcollerViewCell alloc] initWithFrame:CGRectMake(0, i * cellHeight, _scrollView.frame.size.width, cellHeight)];
            [cell setModel:self.dataArr[i]];
            cell.delegate = self;
            [_scrollView addSubview:cell];
        }
    }
    
}

#pragma mark - Init Method
- (instancetype)init
{
    self = [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    
    return self;
}

- (instancetype)initWithDataArr:(NSArray *)dataArr confirmBlock:(confirmBlock)confirmBlock
{
    self = [self init];
    if (self) {
        self.dataArr = dataArr;
        self.confirmblock = confirmBlock;
    }
    return self;
}

- (void)creatUI
{
    self.topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.topView setBackgroundColor:[UIColor whiteColor]];
    
    self.titleLable = [UILabel createLabelWithTextFontSize:34 textColor:COLOR_RGB_255(68, 68, 68)];
    [self.titleLable setText:@"请选择"];
    self.cancelBtn = [self creatNormalButtonWithTitle:@"取消" titleColor:COLOR_RGB_255(68, 148, 240) FontSize:32 target:@selector(clickCancelBtn:)];
    self.comfirmBtn = [self creatNormalButtonWithTitle:@"确定" titleColor:COLOR_RGB_255(68, 148, 240) FontSize:32 target:@selector(clickConfirmBtn:)];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self setBackgroundColor:COLOR_RGBA_255(0.0, 0.0, 0.0, 0.4)];
    [self addSubview:_topView];
    [self.topView addSubview:_cancelBtn];
    [self.topView addSubview:_titleLable];
    [self.topView addSubview:_comfirmBtn];

    [self addSubview:_scrollView];
}

#pragma mark - Action Method

- (void)clickCancelBtn:(UIButton *)button
{
    [self removeFromSuperview];
}

- (void)clickConfirmBtn:(UIButton *)button
{
     [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
#pragma mark - Delegates & Notifications
#pragma mark - XCCustomerShopSrcollerViewCellDelegate
- (void)XCCustomerShopSrcollerViewCellClickWithModel:(XCCustomerShopModel *)model
{
    self.confirmblock(model);
    [self removeFromSuperview];

}

#pragma mark - Privacy Method



- (UIButton *)creatNormalButtonWithTitle:(NSString *)title
                              titleColor:(UIColor *)color
                                FontSize:(CGFloat)size
                                  target:(SEL)selecter
{
    UIButton *button  = [UIButton buttonWithType:0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:size * ViewRateBaseOnIP6]];
    [button addTarget:self action:selecter forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}
#pragma mark - Setter&Getter
- (void)setDataArr:(NSArray<XCCustomerShopModel *> *)dataArr
{
    _dataArr = dataArr;
    
}

@end
