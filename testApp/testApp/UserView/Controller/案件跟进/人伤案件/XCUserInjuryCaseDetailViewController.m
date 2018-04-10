//
//  XCUserInjuryCaseDetailViewController.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserInjuryCaseDetailViewController.h"
#import "XCUserCaseDetailTextCell.h"
#import "XCUserCaseScrollerViewCell.h"
#define kCaseTextCellID @"CaseTextCellID"
#define kScrollViewCellID @"ScrollViewCellID"
@interface XCUserInjuryCaseDetailViewController ()

@end

@implementation XCUserInjuryCaseDetailViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[XCUserCaseDetailTextCell class] forCellReuseIdentifier:kCaseTextCellID];
    [self.tableView registerClass:[XCUserCaseScrollerViewCell class] forCellReuseIdentifier:kScrollViewCellID];
   
}

#pragma privary Method
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    XCUserCaseDetailTextCell *cell = (XCUserCaseDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kCaseTextCellID forIndexPath:indexPath];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    if (indexPath.row %2 == 0) {
//        cell.isMutableTextType = YES;
//    }else {
//        cell.isMutableTextType = NO;
//    }
//    return cell;
    XCUserCaseScrollerViewCell *cell = (XCUserCaseScrollerViewCell *)[tableView dequeueReusableCellWithIdentifier:kScrollViewCellID forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height;
//
//    if (indexPath.row %2 == 0) {
//        NSString *longString = @"描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中描述中......";
//
//        height = [self getHeightLineWithString:longString withWidth:645 * ViewRateBaseOnIP6 withFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]];
//        height  = (20 + 88) * ViewRateBaseOnIP6 +  30 * ViewRateBaseOnIP6 * 2 + height;
//    }else {
//        CGFloat count = 22;
//        if (count > 0) {
//         height  = ((20 + 88) + (30 + 24))* ViewRateBaseOnIP6  + (24 + 24) * ViewRateBaseOnIP6  * (count - 1) + 30 * ViewRateBaseOnIP6 ;
//        }else {
//            height  = (20 + 88) * ViewRateBaseOnIP6 +  30 * ViewRateBaseOnIP6 * 2;
//
//        }
//    }
//    return height;

    return (20 + 88 + 140 + 30) * ViewRateBaseOnIP6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
