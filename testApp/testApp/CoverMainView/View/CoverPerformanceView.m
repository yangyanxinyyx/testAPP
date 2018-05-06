//
//  CoverPerformanceView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/20.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "CoverPerformanceView.h"
#import "NSString+MoneyString.h"

@implementation CoverPerformanceView

- (instancetype)initWithTitle:(NSString *)title UserData:(NSArray *)data
{
    if (self = [super init]) {
        [self createUIWithTitle:title UserData:data];
    }
    return self;
}

- (void)createUIWithTitle:(NSString *)title UserData:(NSArray *)data
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 35)];
    titleLabel.text = title;
    titleLabel.textColor = COLOR_RGB_255(131, 131, 131);
    titleLabel.backgroundColor = COLOR_RGB_255(242, 242, 242);

    titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:titleLabel];

    NSArray *textArrays = @[@"上年业绩",@"上月业绩",@"本月业绩",@"上年排名",@"上月排名",@"本月排名"];
    NSArray *contentArrays = nil;
    if (data) {
        contentArrays = [NSArray arrayWithArray:data];
    }

    for (int i=0; i<6; i++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35 + 40*i, SCREEN_WIDTH/2, 40)];
        textLabel.text = textArrays[i];
        textLabel.textColor = COLOR_RGB_255(68, 68, 68);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:textLabel];

        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 35 + 40*i, SCREEN_WIDTH/2, 40)];
        UIColor *color;
        if (contentArrays.count == 6) {
            contentLabel.text = [NSString getTheCorrectMoneyNum:contentArrays[i]];
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.backgroundColor = [UIColor whiteColor];
            if ([contentArrays[i] isEqualToString:@"1"] && i>2) {
                color = COLOR_RGB_255(248, 21, 21);
            }else if ([contentArrays[i] isEqualToString:@"2"] && i>2){
                color = COLOR_RGB_255(57, 174, 54);
            }else if ([contentArrays[i] isEqualToString:@"3"] && i>2){
                color = COLOR_RGB_255(0, 77, 162);
            }else{
                color = COLOR_RGB_255(68, 68, 68);
            }
            contentLabel.textColor = color;
        }
        contentLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:contentLabel];

        if (i > 2) {
            textLabel.frame = CGRectMake(0, 35 + 40*i + 5, SCREEN_WIDTH/2, 40);
            contentLabel.frame = CGRectMake(SCREEN_WIDTH/2, 35 + 40*i + 5, SCREEN_WIDTH/2, 40);
        }
        if (i == 0 || i == 1 ) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 40*(i+1)+35-1, SCREEN_WIDTH - 30, 1)];
            line.backgroundColor = COLOR_RGB_255(242, 242, 242);
            [self addSubview:line];
        }else if (i == 2) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 40*3+35, SCREEN_WIDTH - 30, 5)];
            line.backgroundColor = COLOR_RGB_255(242, 242, 242);
            [self addSubview:line];
        }else if (i == 3 || i == 4){
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 40*(i+1)+35 + 4, SCREEN_WIDTH - 30, 1)];
            line.backgroundColor = COLOR_RGB_255(242, 242, 242);
            [self addSubview:line];
        }


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
