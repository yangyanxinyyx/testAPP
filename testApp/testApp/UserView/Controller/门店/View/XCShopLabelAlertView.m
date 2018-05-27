//
//  XCShopLabelAlertView.m
//  testApp
//
//  Created by Melody on 2018/5/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopLabelAlertView.h"
#import "XCShopLabelChildView.h"
@interface XCShopLabelAlertView()

@property (nonatomic, strong) UIView *centerView ;

/** <# 注释 #> */
@property (nonatomic, strong) UIScrollView * contentScrollView ;
@property (nonatomic, strong) UIView * topSeparator;
@property (nonatomic, strong) UIView * verticalSparator;
@property (nonatomic, strong) UIButton * comfirmBtn;
@property (nonatomic, strong) UIButton * cancelBtn ;

/** <# 注释 #> */
@property (nonatomic, strong) NSArray * dataArr ;
/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * selectArrM ;
@end

@implementation XCShopLabelAlertView

#pragma mark - lifeCycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.centerView setFrame:CGRectMake(0, 0, 540 * ViewRateBaseOnIP6, 437 * ViewRateBaseOnIP6)];
    self.centerView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    
    //centerView subViews
    [_contentScrollView setFrame:CGRectMake(0, 0, _centerView.frame.size.width, _centerView.frame.size.height - (38 + 38 + 32) * ViewRateBaseOnIP6)];
    
    [_topSeparator setFrame:CGRectMake(0, CGRectGetMaxY(_contentScrollView.frame), _centerView.bounds.size.width, 1)];
    
    CGFloat btnWidth = self.centerView.bounds.size.width * 0.5;
    CGFloat btnHeight =  80 * ViewRateBaseOnIP6;
    [self.comfirmBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.topSeparator.frame) + 14.5 * ViewRateBaseOnIP6 , btnWidth,btnHeight)];
    [self.cancelBtn setFrame:CGRectMake(btnWidth , self.comfirmBtn.frame.origin.y, btnWidth, btnHeight)];
    [self.verticalSparator setFrame:CGRectMake(self.centerView.bounds.size.width * 0.5 ,CGRectGetMaxY(self.topSeparator.frame) +(self.centerView.bounds.size.height - self.topSeparator.frame.origin.y  - btnHeight ) * 0.5 , 1, btnHeight)];
    
}
#pragma mark - Init Method

+(instancetype)alterViewWithDataArr:(NSArray *)dataArr
                          selectArr:(NSMutableArray *)selectedArr
                       confirmClick:(confirmLabelBlock)confirmblock
{
    XCShopLabelAlertView *alterView = [[XCShopLabelAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:alterView];
    alterView.selectArrM = selectedArr;
    alterView.dataArr = dataArr;
    alterView.confirmblock = confirmblock;
    return alterView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:COLOR_RGBA_255(0, 0, 0, 0.6)];
        //提示框
        _centerView = [[UIView alloc] initWithFrame:CGRectZero];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = 5;
        _centerView.layer.masksToBounds = YES;
        [self addSubview:_centerView];
        
        //滚动View
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_contentScrollView setUserInteractionEnabled:YES];
        [_centerView addSubview:_contentScrollView];

        _topSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        [_topSeparator setBackgroundColor: COLOR_RGB_255(229, 229, 229)];
        [_centerView addSubview:_topSeparator];
        
        //确定按钮
        _comfirmBtn =[UIButton buttonWithType:0];
        [_comfirmBtn setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
        [_comfirmBtn addTarget:self action:@selector(clickComfirmButton:) forControlEvents:UIControlEventTouchUpInside];
        [_comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_centerView addSubview:_comfirmBtn];
        
        _verticalSparator = [[UIView alloc] initWithFrame:CGRectZero];
        [_verticalSparator setBackgroundColor: COLOR_RGB_255(229, 229, 229)];
        [_centerView addSubview:_verticalSparator];
        
        //取消按钮
        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectZero];
        [_cancelBtn setTitleColor:COLOR_RGB_255(68, 68, 68) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_centerView addSubview:_cancelBtn];
    }
    
    return self;
}

#pragma mark - Action Method
- (void)clickComfirmButton:(UIButton *)button
{
    if (self.confirmblock) {
        NSMutableArray *tmpselectArrM = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < _contentScrollView.subviews.count; i++) {
            XCShopLabelChildView *subView = [_contentScrollView viewWithTag:1000 + i];
            if (subView) {
                if (subView.isSelected) {
                    [tmpselectArrM addObject:subView.title];
                }
            }
        }
        self.confirmblock(self, tmpselectArrM);
    }
    [self removeFromSuperview];
}

- (void)clickCancelButton:(UIButton *)button
{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (void)setDataArr:(NSArray *)dataArr
{
  [self layoutSubviews];
  _dataArr = [[NSArray alloc] init];
  if (isUsable(dataArr,[NSArray class]) || isUsable(dataArr,[NSMutableArray class])) {
      _dataArr = dataArr;
      for (int i = 0 ; i < _dataArr.count; i++) {
          NSString *title = _dataArr[i];
          BOOL isSelected = NO ;
          for (NSString *selectTitle in _selectArrM) {
              if ([title isEqualToString:selectTitle]) {
                  isSelected = YES;
              }
          }
          if (isUsableNSString(title, @"")) {
              NSMutableString *mutalString = [[NSMutableString alloc] initWithString:title];
              if (mutalString.length == 2) {
                  [mutalString insertString:@"  " atIndex:1];
                  title = mutalString;
              }
          }
          XCShopLabelChildView *childView = [[XCShopLabelChildView alloc] initWithFrame:CGRectMake(0, i * [XCShopLabelChildView getViewHeight],_centerView.frame.size.width, [XCShopLabelChildView getViewHeight]) Title:title Selected:isSelected];
          childView.tag = 1000 + i;
          [_contentScrollView addSubview:childView];
      }
  }
    [_contentScrollView setContentSize:CGSizeMake(_centerView.frame.size.width, _dataArr.count * [XCShopLabelChildView getViewHeight] + 40 * ViewRateBaseOnIP6)];
}


@end
