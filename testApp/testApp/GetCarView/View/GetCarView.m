//
//  GetCarView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarView.h"


@implementation GetCarView

- (instancetype)initWithFrame:(CGRect)frame model:(GetCarDetailModel *)model isFix:(BOOL)isFix
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        CGFloat height = 312;
        if (isFix) {
            height = 312 - 68 +34;
        }else{
            height = 312 ;
        }

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        scrollView.contentSize = CGSizeMake(0, isFix ? 312-34 : 312- 68 +34*model.detailList.count);
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = !isFix;
        scrollView.delegate = self;

        NSArray *titleArray1 = @[@"客户名称:",@"车  牌  号:",@"车  型  号:",@"联系电话:"];
        NSArray *titleArray2 = @[[NSString stringWithFormat:@"%@",model.customerName],[NSString stringWithFormat:@"%@",model.plateNo],[NSString stringWithFormat:@"%@",model.model],[NSString stringWithFormat:@"%@",model.phone]];
        for (int i=0 ; i<4; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40*i, 68, 40)];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = COLOR_RGB_255(68, 68, 68);
            label.text = titleArray1[i];
            [scrollView addSubview:label];

            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(82, 40*i, 200, 40)];
            label2.font = [UIFont systemFontOfSize:13];
            label2.textColor = COLOR_RGB_255(165, 165, 165);
            label2.text = titleArray2[i];
            [scrollView addSubview:label2];

            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 39*(i+1), SCREEN_WIDTH-30, 1)];
            line.backgroundColor = COLOR_RGB_255(229, 229, 229);
            [scrollView addSubview:line];
        }

        UIView *seqline = [[UIView alloc] initWithFrame:CGRectMake(0, 200-44, SCREEN_WIDTH, 5)];
        seqline.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [scrollView addSubview:seqline];

        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 205-44, SCREEN_WIDTH - 15, 40)];
        itemLabel.font = [UIFont systemFontOfSize:14];
        itemLabel.textColor = COLOR_RGB_255(68, 68, 68);
        itemLabel.text = @"项目";
        [scrollView addSubview:itemLabel];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(itemLabel.frame), SCREEN_WIDTH, isFix ? 34 : 34 * model.detailList.count)];
        [scrollView addSubview:view];
        view.layer.borderWidth = 1;
        view.layer.borderColor = COLOR_RGB_255(242, 242, 242).CGColor;
        if (isFix) {
            UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 34)];
            item.font = [UIFont systemFontOfSize:14];
            item.textColor = COLOR_RGB_255(68, 68, 68);
            item.text = @"没有数据";
            [view addSubview:item];
        }else{
            for (int i=0; i<model.detailList.count; i++) {
                NSDictionary *dic = model.detailList[i];
                UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(15, i*34, 200, 34)];
                item.font = [UIFont systemFontOfSize:14];
                item.textColor = COLOR_RGB_255(68, 68, 68);
                item.text = dic[@"serviceName"];
                [view addSubview:item];

                UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(15, i*34, SCREEN_WIDTH - 15, 40)];
                money.font = [UIFont systemFontOfSize:14];
                money.textColor = COLOR_RGB_255(68, 68, 68);
                money.text = [NSString stringWithFormat:@"￥ %@",dic[@"servicePrice"]];
                [money sizeToFit];
                money.frame = CGRectMake(SCREEN_WIDTH - money.frame.size.width - 12, ((34 - money.frame.size.height)/2)+i*34, money.frame.size.width, money.frame.size.height);
                [view addSubview:money];
            }
        }


        UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, CGRectGetMaxY(view.frame), SCREEN_WIDTH - 240, 40)];
        lastLabel.font = [UIFont systemFontOfSize:12];
        lastLabel.textColor = COLOR_RGB_255(68, 68, 68);
        if (isFix) {
            lastLabel.text = [NSString stringWithFormat:@"共0项      合计￥ 0"];
        }else{
            lastLabel.text = [NSString stringWithFormat:@"共%ld项      合计￥ %@",model.detailList.count,model.orderPrice];
        }

        [scrollView addSubview:lastLabel];


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
