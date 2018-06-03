//
//  XCShopServiceCheckoutViewController.m
//  testApp
//
//  Created by Melody on 2018/5/4.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopServiceCheckoutViewController.h"
#import "PriceUnderwritingImportTableViewCell.h"
#define kimportTableCellID @"importTableCellID"
@interface XCShopServiceCheckoutViewController ()<PriceUnderwritingImportTableViewCellDelegate>

@end

@implementation XCShopServiceCheckoutViewController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureData];
    [self configureSubviews];
}

#pragma mark - Init Method
- (void)configureData
{
    self.dataArrM = [NSMutableArray arrayWithArray:@[@"当前状态:",@"拒绝时间:",@"品牌原价:",
                                                     @"品牌会员价:",@"专属原价:",@"专属会员价:",
                                                     @"服务介绍:",@"拒绝原因:"]];
}

-(void)configureSubviews
{
     [self.tableView registerClass:[PriceUnderwritingImportTableViewCell class] forCellReuseIdentifier:kimportTableCellID];
     [self.tableView registerClass:[XCCheckoutDetailTextCell class] forCellReuseIdentifier:kTextCellID];
     [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (![_serviceModel.status isEqualToString:@"审核不通过"]) {
        return self.dataArrM.count - 1;
    }
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *titleName = self.dataArrM[indexPath.row];

    if ([self isImportTableViewCellWith:indexPath]) {
        PriceUnderwritingImportTableViewCell *cell = (PriceUnderwritingImportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kimportTableCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.labelName.text = titleName;
        cell.textView.text = @"";
        cell.textView.editable = NO ;
        if (indexPath.row == 6) {
            //服务介绍
            if (self.serviceModel) {
                if (isUsableNSString(self.serviceModel.introduction, @"")) {
                    cell.textView.text = self.serviceModel.introduction;

                }
            }
        }
        else if (indexPath.row == 7) {
            cell.shouldShowSpearactorLine = YES;
            //拒绝原因
            if (self.serviceModel) {
                if (isUsableNSString(self.serviceModel.repulseRemark, @"")) {
                    cell.textView.text = self.serviceModel.repulseRemark;
                }
            }
        }
        return cell;
    }
    
    XCCheckoutDetailTextCell *textCell =(XCCheckoutDetailTextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellID];
    textCell.shouldShowSeparator = YES;
    [textCell setTitle:titleName];
    if (self.serviceModel) {
        [textCell setupCellWithShopServiceModel:self.serviceModel];
    }
    
    return textCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isImportTableViewCellWith:indexPath]) {
        return 233 * ViewRateBaseOnIP6;
    }
    return 88 * ViewRateBaseOnIP6;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XCDistributionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFooterViewID];

    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20 * ViewRateBaseOnIP6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - Privacy Method
- (BOOL)isImportTableViewCellWith:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6 || indexPath.row == 7) {
        return YES;
    }
    return NO;
}
#pragma mark - Setter&Getter
- (void)setServiceModel:(XCShopServiceModel *)serviceModel
{
    _serviceModel = serviceModel;
    
    if ([_serviceModel.status isEqualToString:@"审核不通过"]) {
        [self.dataArrM replaceObjectAtIndex:1 withObject:@"拒绝时间:"];
    }
    else if ([_serviceModel.status isEqualToString:@"待审核"])
    {
        [self.dataArrM replaceObjectAtIndex:1 withObject:@"提交时间:"];
    }
    else if ([_serviceModel.status isEqualToString:@"审核通过"])
    {
        [self.dataArrM replaceObjectAtIndex:1 withObject:@"上架时间:"];
    }
    else if ([_serviceModel.status isEqualToString:@"下架"])
    {
        [self.dataArrM replaceObjectAtIndex:1 withObject:@"下架时间:"];
    }
    
}

@end
