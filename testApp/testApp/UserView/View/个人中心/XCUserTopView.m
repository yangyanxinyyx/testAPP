//
//  XCUserTopView.m
//  testApp
//
//  Created by Melody on 2018/3/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserTopView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XCUserTopView()

@property (nonatomic, strong) UIImageView * bgImageView ;
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UIView * innerView ; //白色框

@property (nonatomic, strong) UIImageView * iconImageView ;
@property (nonatomic, strong) UILabel * nameLable ;
@property (nonatomic, strong) UIView * separator ;
@property (nonatomic, strong) UIButton * myCommissionBtn ;
@property (nonatomic, strong) UIButton * modifyPasswordBtn ;
@end

@implementation XCUserTopView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        self.userInteractionEnabled = YES;
        [self addSubview:self.bgImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.innerView];
        [self.innerView addSubview:self.iconImageView];
        [self.innerView addSubview:self.nameLable];
        [self.innerView addSubview:self.myCommissionBtn];
        [self.innerView addSubview:self.modifyPasswordBtn];
        [self.innerView addSubview:self.separator];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.bgImageView setFrame:CGRectMake(0, 0, self.bounds.size.width, 330 * ViewRateBaseOnIP6)];
    [self.titleLabel sizeToFit];
    [self.titleLabel setFrame:CGRectMake((self.frame.size.width  - self.titleLabel.frame.size.width) * 0.5, 35 * ViewRateBaseOnIP6, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];

    NSInteger innerWidth = 690 * ViewRateBaseOnIP6;
    NSInteger innerHeight = 310 * ViewRateBaseOnIP6;
    
    [self.innerView setFrame:CGRectMake((self.bounds.size.width - innerWidth) * 0.5,self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 30 * ViewRateBaseOnIP6 , innerWidth,innerHeight)];
    [self.iconImageView setFrame:CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6)];
    [self.nameLable setFrame:CGRectMake(200 * ViewRateBaseOnIP6, 86 * ViewRateBaseOnIP6,self.innerView.frame.size.width - 200 * ViewRateBaseOnIP6 , 28 * ViewRateBaseOnIP6)];

    CGFloat btnWidth= (self.innerView.frame.size.width - 1) * 0.5;
    CGFloat btnHeight = 80 * ViewRateBaseOnIP6;
    CGFloat btImageViewWidth = 46 * ViewRateBaseOnIP6;
    CGFloat btImageViewHeight = 46 * ViewRateBaseOnIP6;
    CGFloat btTitleWidth = 110 * ViewRateBaseOnIP6;
    CGFloat btTitleHeight = 27 * ViewRateBaseOnIP6;
    [self.myCommissionBtn setFrame:CGRectMake(0, (self.innerView.frame.size.height - (80 + 30) * ViewRateBaseOnIP6),btnWidth, btnHeight)];
    self.myCommissionBtn.imageView.frame = CGRectMake(0, 0, btImageViewWidth, btImageViewHeight);
    self.myCommissionBtn.titleLabel.frame = CGRectMake(0, 0, btTitleWidth, btTitleHeight);
    [self.myCommissionBtn setImageEdgeInsets:UIEdgeInsetsMake((btnHeight - btImageViewHeight - 30 * ViewRateBaseOnIP6) * 0.5 , 74 * ViewRateBaseOnIP6,0,0)];
    [self.myCommissionBtn setTitleEdgeInsets:UIEdgeInsetsMake((btnHeight - btTitleHeight - 30 * ViewRateBaseOnIP6) * 0.5, 143 * ViewRateBaseOnIP6 - btImageViewWidth, 0, 0)];
    CGFloat mdBTImageViewWidth = 39 * ViewRateBaseOnIP6;
    CGFloat mdBTImageViewHeight = 46 * ViewRateBaseOnIP6;
    [self.modifyPasswordBtn setFrame:CGRectMake(self.innerView.frame.size.width - btnWidth - 1, (self.innerView.frame.size.height - (80 + 30) * ViewRateBaseOnIP6),btnWidth , btnHeight)];
    self.modifyPasswordBtn.imageView.frame = CGRectMake(0, 0, mdBTImageViewWidth, mdBTImageViewHeight);
    self.modifyPasswordBtn.titleLabel.frame = CGRectMake(0, 0, btTitleWidth, btTitleHeight);
    [self.modifyPasswordBtn setImageEdgeInsets:UIEdgeInsetsMake((btnHeight - btImageViewHeight - 30 * ViewRateBaseOnIP6) * 0.5 , 91 * ViewRateBaseOnIP6,0,0)];
    [self.modifyPasswordBtn setTitleEdgeInsets:UIEdgeInsetsMake((btnHeight - btTitleHeight - 30 * ViewRateBaseOnIP6) * 0.5, (91 + 22) * ViewRateBaseOnIP6 , 0, 0)];
    [self.separator setFrame:CGRectMake(344 * ViewRateBaseOnIP6, 200 * ViewRateBaseOnIP6, 1, 80 * ViewRateBaseOnIP6)];
}

#pragma mark - Action Method
//防止冲突
- (void)clickCommissionAndModifyPasswordBtn:(UIButton *)button
{
    NSLog(@"======>");
    if (self.myCommissionBtn == button) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserTopViewMyCommissionButtonClickHandler:)]) {
            [self.delegate XCUserTopViewMyCommissionButtonClickHandler:button];
        }else {
            XCLog(@"Error: class:%@ XCUserTopViewMyCommissionButtonClickHandler delegate was No",[self class]);
        }
    }else if(self.modifyPasswordBtn == button) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(XCUserTopViewModifyPasswordButtonClickHandler:)]) {
            [self.delegate XCUserTopViewModifyPasswordButtonClickHandler:button];
        }else {
            XCLog(@"Error: class:%@ XCUserTopViewModifyPasswordButtonClickHandler delegate was No",[self class]);
        }
    }
}

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (UIImage *)circleOldImage:(UIImage *)originalImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = originalImage;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Setter&Getter

- (void)setUserIconUrlString:(NSString *)userIconUrlString
{
//    NSURL *iconURL = [NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201503/21/20150321114038_fJyMS.jpeg"];
    if (isUsable(userIconUrlString,[NSString class])) {
        UIImage *userIcon = [self circleOldImage:[UIImage imageNamed:@"个人中心"] borderWidth:1.0 borderColor:COLOR_RGB_255( 104.0, 153.0, 232.0)];
        NSURL *iconURL = [NSURL URLWithString:userIconUrlString];
        if (iconURL) {
            _userIconUrlString = userIconUrlString;
            __weak typeof (self)weakSelf = self;
            [self.iconImageView sd_setImageWithURL:iconURL placeholderImage:userIcon completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (weakSelf.iconImageView) {
                    [weakSelf.iconImageView setImage:image];
                    weakSelf.iconImageView.layer.borderWidth = 1;
                    weakSelf.iconImageView.layer.borderColor = COLOR_RGB_255(104.0, 153.0, 232.0).CGColor;
                    weakSelf.iconImageView.layer.cornerRadius = _iconImageView.frame.size.width/2.0;
                    weakSelf.iconImageView.layer.masksToBounds = YES;
                }
            }];
        }else {
            NSLog(@"class:%s setUserIconUrlString: url was nil",__func__);
        }
        
    }else {
        NSLog(@"class:%s setUserIconUrlString: urlStr is not Usable",__func__);
    }
}

- (void)setUserName:(NSString *)userName
{
    if (!userName) {
        return;
    }
    _userName = userName;
    [self.nameLable setText:_userName];
    [self.nameLable sizeToFit];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        UIImage *bgImage = [UIImage imageNamed:@"背景"];
        _bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    }
    return _bgImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"个人中心"];
        [_titleLabel setTextColor:[UIColor whiteColor]];
    }
    return _titleLabel;
}

- (UIView *)innerView
{
    if (!_innerView) {
        _innerView = [[UIView alloc] init];
        _innerView.backgroundColor = [UIColor whiteColor];
        _innerView.layer.cornerRadius = 3;
        _innerView.layer.shadowOffset = CGSizeMake(0, 3);
        _innerView.layer.shadowOpacity = 1;
        _innerView.layer.shadowRadius = 3;
        _innerView.layer.shadowColor = [UIColor colorWithHexString:@"#cecece"].CGColor;

    }
    return _innerView;
}

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        UIImage *userIcon = [UIImage imageNamed:@"个人中心"];
        _iconImageView = [[UIImageView alloc] initWithImage:userIcon];

    }
    return _iconImageView;
}

- (UILabel *)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(200 * ViewRateBaseOnIP6, 86 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6)];
        NSString *name = @"未知用户";
        [_nameLable setText:name];
        [_nameLable setTextColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0f]];
        [_nameLable setFont:[UIFont systemFontOfSize:30 * ViewRateBaseOnIP6]];
        [_nameLable setTextAlignment:NSTextAlignmentLeft];
        [_nameLable sizeToFit];
    }
    return _nameLable;
}

- (UIButton *)myCommissionBtn
{
    if (!_myCommissionBtn) {
        UIImage *commissionIcon = [UIImage imageNamed:@"我的佣金"];
        
    
        UIColor * textColor = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
        UIFont *commonFont = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
        _myCommissionBtn = [UIButton buttonWithType:0];
        [_myCommissionBtn setImage:commissionIcon forState:UIControlStateNormal];
        [_myCommissionBtn setTitle:@"我的佣金" forState:UIControlStateNormal];
        [_myCommissionBtn setTitleColor:textColor forState:UIControlStateNormal];
        [_myCommissionBtn.titleLabel setFont:commonFont];
        [_myCommissionBtn addTarget:self action:@selector(clickCommissionAndModifyPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myCommissionBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
   
        //修改密码按钮 初始化
        if (!_modifyPasswordBtn) {
            UIImage *modifyIcon = [UIImage imageNamed:@"修改密码"];
            _modifyPasswordBtn = [UIButton buttonWithType:0];
            [_modifyPasswordBtn setImage:modifyIcon forState:UIControlStateNormal];
            [_modifyPasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
            [_modifyPasswordBtn setTitleColor:textColor forState:UIControlStateNormal];
            [_modifyPasswordBtn.titleLabel setFont:commonFont];
            [_modifyPasswordBtn addTarget:self action:@selector(clickCommissionAndModifyPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_modifyPasswordBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        }

    }
    return _myCommissionBtn;
}

- (UIView *)separator
{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        [_separator setBackgroundColor:[UIColor colorWithRed:229.0f/255.0f green:229.0f/255.0f blue:229.0f/255.0f alpha:1.0f]];
    }
    return _separator;
}

@end
