//
//  GetCarView.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarView.h"
#import "GetCarImageCell.h"
#import <UIImageView+WebCache.h>
#import "NSString+MoneyString.h"

@implementation GetCarView

- (instancetype)initWithFrame:(CGRect)frame model:(GetCarDetailModel *)model isFix:(BOOL)isFix orderCategory:(NSString *)orderCategory
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];


        CGFloat height = 530;
        if (isFix) {
            height = 495;
        }else{
            height = 530 ;
        }

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        scrollView.contentSize = CGSizeMake(0, isFix ? 495 : 530- 72 +36*model.detailList.count);
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = !isFix;
        scrollView.delegate = self;

        NSArray *titleArray1 = @[@"客户名称:",@"车  牌  号:",@"车  型  号:",@"联系电话:",@"预约时间:",@"项      目:"];
        NSArray *titleArray2 = @[[NSString stringWithFormat:@"%@",model.customerName],[NSString stringWithFormat:@"%@",model.plateNo],[NSString stringWithFormat:@"%@",model.brand],[NSString stringWithFormat:@"%@",model.phone],[NSString stringWithFormat:@"%@",model.appointmentTime],[NSString stringWithFormat:@"%@",orderCategory]];
        for (int i=0 ; i<6; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40*i, 68, 44)];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = COLOR_RGB_255(68, 68, 68);
            label.text = titleArray1[i];
            [scrollView addSubview:label];

            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(82, 40*i, SCREEN_WIDTH - 82 - 15, 44)];
            label2.font = [UIFont systemFontOfSize:13];
            label2.textColor = COLOR_RGB_255(165, 165, 165);
            label2.text = titleArray2[i];
            [scrollView addSubview:label2];

            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label2.frame), SCREEN_WIDTH-30, 1)];
            line.backgroundColor = COLOR_RGB_255(242, 242, 242);
            [scrollView addSubview:line];
        }

        UIView *seqline = [[UIView alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, 5)];
        seqline.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [scrollView addSubview:seqline];

        UILabel *requireLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 245, 150, 40)];
        requireLabel.font = [UIFont systemFontOfSize:14];
        requireLabel.textColor = COLOR_RGB_255(68, 68, 68);
        requireLabel.text = @"要求描述";
        [scrollView addSubview:requireLabel];

        UILabel *requireLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 285, SCREEN_WIDTH-30, 80)];
        requireLabel2.font = [UIFont systemFontOfSize:13];
        requireLabel2.textColor = COLOR_RGB_255(165, 165, 165);
        requireLabel2.numberOfLines = 0;
        NSString *text = [NSString stringWithFormat:@"%@",model.remark];
        requireLabel2.text = [text isEqualToString:@"(null)"] ? @"暂无描述" : model.remark;
        [scrollView addSubview:requireLabel2];

        UIView *seqline2 = [[UIView alloc] initWithFrame:CGRectMake(0, 365, SCREEN_WIDTH, 5)];
        seqline2.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [scrollView addSubview:seqline2];


        if (isFix) {
            //维修
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 365, SCREEN_WIDTH - 15, 35)];
            itemLabel.font = [UIFont systemFontOfSize:14];
            itemLabel.textColor = COLOR_RGB_255(68, 68, 68);
            itemLabel.text = @"相关照片";
            [scrollView addSubview:itemLabel];

            self.dataSource = [NSMutableArray array];
            if (isUsableNSString(model.url1, @"")) {
                [self.dataSource addObject:model.url1];
            }
            if (isUsableNSString(model.url2, @"")) {
                [self.dataSource addObject:model.url2];
            }
            if (isUsableNSString(model.url3, @"")) {
                [self.dataSource addObject:model.url3];
            }
            if (isUsableNSString(model.url4, @"")) {
                [self.dataSource addObject:model.url4];
            }

            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.itemSize = CGSizeMake(70, 70);
            flowLayout.minimumLineSpacing = 17*kScaleWidth;

            //设置上下左右四个边的边距
            UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(itemLabel.frame), SCREEN_WIDTH, 90) collectionViewLayout:flowLayout];
            [scrollView addSubview:collection];
            collection.contentInset = UIEdgeInsetsMake(10, 15, 10, 0);
            collection.delegate = self;
            collection.dataSource = self;
            collection.backgroundColor = [UIColor whiteColor];

            //注册cell
            [collection registerClass:[GetCarImageCell class] forCellWithReuseIdentifier:@"cell"];


        }else{
            //接车
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 365, SCREEN_WIDTH - 15, 44)];
            itemLabel.font = [UIFont systemFontOfSize:14];
            itemLabel.textColor = COLOR_RGB_255(68, 68, 68);
            itemLabel.text = @"服务";
            [scrollView addSubview:itemLabel];

            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(itemLabel.frame), SCREEN_WIDTH, isFix ? 36 : 36 * model.detailList.count)];
            [scrollView addSubview:view];
            view.layer.borderWidth = 1;
            view.layer.borderColor = COLOR_RGB_255(242, 242, 242).CGColor;
            for (int i=0; i<model.detailList.count; i++) {
                NSDictionary *dic = model.detailList[i];
                UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(15, i*36, 200, 36)];
                item.font = [UIFont systemFontOfSize:14];
                item.textColor = COLOR_RGB_255(68, 68, 68);
                item.text = [NSString stringWithFormat:@"%@",dic[@"serviceName"]];
                [view addSubview:item];

                UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(15, i*36, SCREEN_WIDTH - 15, 36)];
                money.font = [UIFont systemFontOfSize:14];
                money.textColor = COLOR_RGB_255(68, 68, 68);
                money.text = [NSString stringWithFormat:@"￥ %@",dic[@"servicePrice"]];
                [money sizeToFit];
                money.frame = CGRectMake(SCREEN_WIDTH - money.frame.size.width - 12, ((36 - money.frame.size.height)/2)+i*36, money.frame.size.width, money.frame.size.height);
                [view addSubview:money];
            }

            UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), SCREEN_WIDTH -10, 44)];
            lastLabel.font = [UIFont systemFontOfSize:12];
            lastLabel.textAlignment = NSTextAlignmentRight;
            lastLabel.textColor = COLOR_RGB_255(68, 68, 68);
            lastLabel.text = [NSString stringWithFormat:@"共%ld项      合计￥ %@",model.detailList.count,[NSString getTheCorrectMoneyNum:[NSString stringWithFormat:@"%@",model.orderPrice]]];

            [scrollView addSubview:lastLabel];
        }

    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GetCarImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    NSString *str = self.dataSource[indexPath.row];
    if (isUsableNSString(str, nil)) {
        NSURL *url = [NSURL URLWithString:str];
        [cell.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate GetCarViewDidSelectImageIndex:indexPath.row source:self.dataSource];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
