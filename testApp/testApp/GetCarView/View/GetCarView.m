//
//  GetCarView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarView.h"


@implementation GetCarView

- (instancetype)initWithFrame:(CGRect)frame model:(GetCarDetailModel *)model
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        NSArray *titleArray1 = @[@"客户名称:",@"车  牌  号:",@"车  型  号:",@"联系电话:",@"公  里  数:"];
        NSArray *titleArray2 = @[model.customerName,model.plateNo,model.model,model.phone,@"99999"];
        for (int i=0 ; i<5; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40*i, 68, 40)];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = COLOR_RGB_255(68, 68, 68);
            label.text = titleArray1[i];
            [self addSubview:label];

            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(68, 40*i, 200, 40)];
            label2.font = [UIFont systemFontOfSize:13];
            label2.textColor = COLOR_RGB_255(165, 165, 165);
            label2.text = titleArray2[i];
            [self addSubview:label2];

            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 39*(i+1), SCREEN_WIDTH-30, 1)];
            line.backgroundColor = COLOR_RGB_255(229, 229, 229);
            [self addSubview:line];
        }

        UIView *seqline = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 5)];
        seqline.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self addSubview:seqline];

        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 205, SCREEN_WIDTH - 15, 40)];
        itemLabel.font = [UIFont systemFontOfSize:14];
        itemLabel.textColor = COLOR_RGB_255(68, 68, 68);
        itemLabel.text = @"项目";
        [self addSubview:itemLabel];

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-1, 245, SCREEN_WIDTH+2, 68)];
        scrollView.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self addSubview:scrollView];
        scrollView.contentSize = CGSizeMake(0, 34*model.detailList.count);
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.layer.borderWidth = 1;
        scrollView.layer.borderColor = COLOR_RGB_255(242, 242, 242).CGColor;

        for (int i=0; i<model.detailList.count; i++) {
            NSDictionary *dic = model.detailList[i];
            UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(15, i*34, 60, 34)];
            item.font = [UIFont systemFontOfSize:14];
            item.textColor = COLOR_RGB_255(68, 68, 68);
            item.text = dic[@"serviceName"];
            [scrollView addSubview:item];

            UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(15, i*34, SCREEN_WIDTH - 15, 40)];
            money.font = [UIFont systemFontOfSize:14];
            money.textColor = COLOR_RGB_255(68, 68, 68);
            money.text = [NSString stringWithFormat:@"￥ %@",dic[@"serviceName"]];
            [money sizeToFit];
            money.frame = CGRectMake(SCREEN_WIDTH - money.frame.size.width - 12, (34 - money.frame.size.height)/2, money.frame.size.width, money.frame.size.height);
            [scrollView addSubview:money];
        }

        UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 312, SCREEN_WIDTH - 240, 40)];
        lastLabel.font = [UIFont systemFontOfSize:12];
        lastLabel.textColor = COLOR_RGB_255(68, 68, 68);
        lastLabel.text = [NSString stringWithFormat:@"共%ld项      合计￥ %@",model.detailList.count,model.orderPrice];
        [self addSubview:lastLabel];


    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
