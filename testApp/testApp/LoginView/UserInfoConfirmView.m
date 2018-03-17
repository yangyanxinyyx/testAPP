//
//  UserInfoComfirmVIew.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "UserInfoConfirmView.h"

@interface UserInfoConfirmView ()

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *department;
@property (nonatomic,strong) NSString *workNumber;

@end

@implementation UserInfoConfirmView

- (instancetype)initwithName:(NSString *)name department:(NSString *)department worknumber:(NSString *)number
{
    if (self == [super init]) {
        self.name = name?name:@"";
        self.department = department?department:@"";
        self.workNumber = number?number:@"";
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor = COLOR_RGBA_255(0, 0, 0, 0.6);

    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 310)/2, (SCREEN_HEIGHT - 190)/2 -5, 310, 190)];
    [self addSubview:contentView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(118, 15, 74, 15)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"请确认信息";
    [contentView addSubview:titleLabel];

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 310, 1)];
    line1.backgroundColor = COLOR_RGBA_255(229, 229, 229, 1);
    [contentView addSubview:line1];

    NSArray *titles = @[@"姓名",@"部门",@"工号"];
    NSArray *contents = @[self.name,self.department,self.workNumber];
    for (int i=0; i<titles.count; i++) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(line1.frame) + 11 + 28 * i, 26, 13)];
        title.text = titles[i];
        title.font = [UIFont systemFontOfSize:13];
        [contentView addSubview:title];

        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(line1.frame) + 11 + 28 * i, 26, 13)];
        content.text = contents[i];
        content.textAlignment = NSTextAlignmentLeft;
        content.font = [UIFont systemFontOfSize:13];
        [contentView addSubview:content];
    }

    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 143, 310, 1)];
    line2.backgroundColor = COLOR_RGBA_255(229, 229, 229, 1);
    [contentView addSubview:line2];

    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(74, CGRectGetMaxY(line2.frame)+20, 160, 35)];
    confirmBtn.backgroundColor = COLOR_RGB_255(0, 77, 162);
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:confirmBtn];
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(pressConfirmBtn) forControlEvents:UIControlEventTouchUpInside];

}


- (void)pressConfirmBtn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didConfirmUserInfo)]) {
        [self.delegate didConfirmUserInfo];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
