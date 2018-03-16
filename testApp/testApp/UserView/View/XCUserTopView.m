//
//  XCUserTopView.m
//  testApp
//
//  Created by Melody on 2018/3/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserTopView.h"

@interface XCUserTopView()

@property (nonatomic, strong) UIView * innerView ;

@property (nonatomic, strong) UIImageView * iconImageView ;
@property (nonatomic, strong) UILabel * nameLable ;

/** 分割线 */
@property (nonatomic, strong) UIView * separator ;
@property (nonatomic, strong) UIButton * myCommissionBtn ;
@property (nonatomic, strong) UIButton * modifyPasswordBtn ;
@end

@implementation XCUserTopView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"背景"];
        
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"背景"ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.layer.contents = (id)image.CGImage;
        [self addSubview:self.innerView];
        
        
    }
    return self;
}

#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
- (UIView *)innerView
{
    if (_innerView == nil) {
        NSInteger width = 345;
        NSInteger height = self.bounds.size.height;
        
        _innerView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - width) * 0.5,StatusBarHeight +  NAVIGATION_BAR_HEIGHT, width,height)];
        _innerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _innerView;
}

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        
        UIImage *userIcon = [UIImage imageNamed:@"个人中心"];
        if (self.userIcon) {
            userIcon = self.userIcon;
        }
        _iconImageView = [[UIImageView alloc] initWithImage:userIcon];
        [_iconImageView setFrame:CGRectMake(15, 15, 70, 70)];
        
    }
    return _iconImageView;
}

@end
