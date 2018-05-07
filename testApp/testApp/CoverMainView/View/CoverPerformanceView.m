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

- (instancetype)initWithTitle:(NSString *)title carAchie:(NSString *)carAchie carRank:(NSString *)carRank repairAchie:(NSString *)repairAchie repairRank:(NSString *)repairRank
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUIWithTitle:title carAchie:carAchie carRank:carRank repairAchie:repairAchie repairRank:repairRank];
    }
    return self;
}

- (void)createUIWithTitle:(NSString *)title carAchie:(NSString *)carAchie carRank:(NSString *)carRank repairAchie:(NSString *)repairAchie repairRank:(NSString *)repairRank
{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    line1.backgroundColor = COLOR_RGB_255(242, 242, 242);
    [self addSubview:line1];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 15, 32)];
    titleLabel.text = title;
    titleLabel.textColor = COLOR_RGB_255(131, 131, 131);
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:titleLabel];

    NSArray *textArrays = @[@"车险业绩",@"维修业绩"];

    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, 10+31, SCREEN_WIDTH-30, 1)];
    line2.backgroundColor = COLOR_RGBA_255(204, 204, 204, 0.5);
    [self addSubview:line2];

    for (int i=0; i<2; i++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, CGRectGetMaxY(line2.frame)+15, SCREEN_WIDTH/2, 14)];
        if (i == 0) {
            textLabel.text = [NSString getTheCorrectMoneyNum:carAchie];
        }else{
            textLabel.text = [NSString getTheCorrectMoneyNum:repairAchie];
        }
        textLabel.textColor = COLOR_RGB_255(248, 21, 21);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:textLabel];

        UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, CGRectGetMaxY(textLabel.frame)+7, SCREEN_WIDTH/2, 12)];
        if (i == 0) {
            textLabel2.text = [NSString stringWithFormat:@"%@名",carRank];
        }else{
            textLabel2.text = [NSString stringWithFormat:@"%@名",repairRank];
        }
        textLabel2.textColor = COLOR_RGB_255(57, 174, 57);
        textLabel2.textAlignment = NSTextAlignmentCenter;
        textLabel2.backgroundColor = [UIColor whiteColor];
        textLabel2.font = [UIFont systemFontOfSize:12];
        [self addSubview:textLabel2];

        UILabel *textLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, CGRectGetMaxY(textLabel2.frame)+10, SCREEN_WIDTH/2, 10)];
        textLabel3.text = textArrays[i];
        textLabel3.textColor = COLOR_RGB_255(68, 68, 68);
        textLabel3.textAlignment = NSTextAlignmentCenter;
        textLabel3.backgroundColor = [UIColor whiteColor];
        textLabel3.font = [UIFont systemFontOfSize:10];
        [self addSubview:textLabel3];
    }

    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 69, 1, 32)];
    line3.backgroundColor = COLOR_RGBA_255(204, 204, 204, 0.5);
    [self addSubview:line3];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
