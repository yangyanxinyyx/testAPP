//
//  XCCheckoutDetailTextCell.m
//  testApp
//
//  Created by Melody on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutDetailTextCell.h"
#import "XCCheckoutDetailBaseModel.h"
#import "XCCustomerDetailModel.h"
#import "UILabel+createLabel.h"
#import "XCShopServiceModel.h"
@interface XCCheckoutDetailTextCell()

//@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UILabel * placeholderLabel ;
@property (nonatomic, strong) UIView * separtatorLine ;

@end

@implementation XCCheckoutDetailTextCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _shouldShowSeparator = NO;
        _shouldTPRightMargin = NO;
        [self configSubVies];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    CGFloat labeH = 24 * ViewRateBaseOnIP6;
//    [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, (self.bounds.size.height - labeH) * 0.5, labelSize.width,labeH)];
       [_titleLabel setFrame:CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6 , labelSize.width,labeH)];
    
    [_placeholderLabel sizeToFit];
    labelSize = _placeholderLabel.frame.size;
    if (_shouldTPRightMargin) {
         [_placeholderLabel setFrame:CGRectMake(self.bounds.size.width - labelSize.width  - 30 * ViewRateBaseOnIP6, _titleLabel.frame.origin.y, labelSize.width, labeH)];
    }else {
         [_placeholderLabel setFrame:CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 16 * ViewRateBaseOnIP6, _titleLabel.frame.origin.y, labelSize.width, labeH)];
    }
   
    if (_shouldShowSeparator) {
        [_separtatorLine setFrame:CGRectMake(30 * ViewRateBaseOnIP6 , self.bounds.size.height - 1, self.bounds.size.width - 30 * ViewRateBaseOnIP6, 1)];
    }
}

#pragma mark - Action Method

- (void)setupCellWithDetailPolicyModel:(XCCheckoutDetailBaseModel *)model
{
    if ([self.title isEqualToString:@"投保人:"]) {
        if (isUsableNSString(model.customerName,@"")) {
            [_placeholderLabel setText:model.customerName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"身份证:"]  ) {
        if (isUsableNSString(model.onwerIdentify,@"")&&isUsableNSString(model.onwerIdentify,@"null")) {
            [_placeholderLabel setText:model.onwerIdentify];
        }else {
             [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"车牌号:"] ) {
       if (isUsableNSString(model.plateNo,@"")) {
           [_placeholderLabel setText:model.plateNo];
       }else {
           [_placeholderLabel setText:@" "];
       }
   }else if ([self.title isEqualToString:@"车架号:"] ) {
       if (isUsableNSString(model.vinNo,@"")) {
           [_placeholderLabel setText:model.vinNo];
       }else {
           [_placeholderLabel setText:@" "];
       }
   }else if ([self.title isEqualToString:@"初登日期:"] ) {
       if (isUsableNSString(model.recordDate,@"")) {
//           NSMutableString *tmpDate = [NSMutableString stringWithString:model.recordDate];
//           NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
           [_placeholderLabel setText:model.recordDate];
           
       }else {
           [_placeholderLabel setText:@" "];
       }
   }else if ([self.title isEqualToString:@"发动机号:"] ) {
       if (isUsableNSString(model.engineNo,@"")) {
           [_placeholderLabel setText:model.engineNo];
       }else {
           [_placeholderLabel setText:@" "];
       }
    }else if ([self.title isEqualToString:@"品牌型号:"]) {
        if (isUsableNSString(model.brand,@"")) {
            [_placeholderLabel setText:model.brand];
        }else {
            [_placeholderLabel setText:@" "];
        }
//    }else if ([self.title isEqualToString:@"车型代码:"]) {
//        if (isUsableNSString(model.model,@"")) {
//            [_placeholderLabel setText:model.model];
//        }else {
//            [_placeholderLabel setText:@" "];
//        }
    }else if ([self.title isEqualToString:@"(商业)起保日期:"]) {
        if (isUsableNSString(model.syEffectDate,@"")) {
//            NSMutableString *tmpDate = [NSMutableString stringWithString:model.syEffectDate];
//            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_placeholderLabel setText:model.syEffectDate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"(交强)起保日期:"]) {
        if (isUsableNSString(model.jqEffectDate,@"")) {
//            NSMutableString *tmpDate = [NSMutableString stringWithString:model.jqEffectDate];
//            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_placeholderLabel setText:model.jqEffectDate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"保险公司:"] ) {
        if (isUsableNSString(model.insurerName,@"")) {
            [_placeholderLabel setText:model.insurerName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"缴费通知单号:"]) {
        if (isUsableNSString(model.payNoticeNo,@"")) {
            [_placeholderLabel setText:model.payNoticeNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"交强险(业务员)金额:"] ) {
        if (isUsable(model.jqMoney, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.jqMoney doubleValue]]];
//            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.jqMoney doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"商业险(业务员)金额:"]) {
        if (isUsable(model.syMoney, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.syMoney doubleValue]]];
//            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.syMoney doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"交强险(出单员)金额:"]) {
        if (isUsable(model.jqMoneyExport, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.jqMoneyExport doubleValue]]];
//            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.jqMoneyExport doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"商业险(出单员)金额:"]) {
        if (isUsable(model.syMoneyExport, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.syMoneyExport doubleValue]]];
//            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.syMoneyExport doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"出单员:"] ) {
        if (isUsableNSString(model.exportmanName,@"")) {
            [_placeholderLabel setText:model.exportmanName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"交强险:"] ) {
        if ( isUsable(model.jqValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.jqValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"机动车损险:"] ) {
        if (isUsable(model.csValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.csValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"第三责任险:"] ) {
        if (isUsable(model.szValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.szValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"车上(司机)险:"]) {
        if (isUsable(model.cssjValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.cssjValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"车上(乘客)险:"] ) {
        if (isUsable(model.csckValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.csckValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"出单员:"] ) {
        if (isUsableNSString(model.exportmanName,@"")) {
            [_placeholderLabel setText:model.exportmanName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
}

- (void)setupCellWithCustomerDetailModel:(XCCustomerDetailModel *)model
{
    if ([self.title isEqualToString:@"客户名称:"]) {
        if (isUsableNSString(model.customerName,@"")) {
            [_placeholderLabel setText:model.customerName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"客户来源:"]) {
        if (isUsableNSString(model.source,@"")) {
            [_placeholderLabel setText:model.source];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"性别:"] ) {
        if (isUsableNSString(model.sex,@"")) {
            [_placeholderLabel setText:model.sex];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"生日:"] ) {
        if (isUsableNSString(model.birthday,@"")) {
            [_placeholderLabel setText:model.birthday];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"区域:"] ) {
        if (isUsableNSString(model.area,@"")) {
            [_placeholderLabel setText:model.area];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"地址:"]) {
        if (isUsableNSString(model.address,@"")) {
            [_placeholderLabel setText:model.address];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"身份证:"]) {
        if (isUsableNSString(model.identity,@"")) {
            [_placeholderLabel setText:model.identity];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"车牌号:"]) {
        if (isUsableNSString(model.plateNo,@"")) {
            [_placeholderLabel setText:model.plateNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"品牌型号:"]) {
        if (isUsableNSString(model.brand,@"")) {
            [_placeholderLabel setText:model.brand];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"初登日期:"]) {
        if (isUsableNSString(model.recordDate,@"")) {
//            NSMutableString *tmpDate = [NSMutableString stringWithString:model.recordDate];
//            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_placeholderLabel setText:model.recordDate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"车架号:"]) {
        if (isUsableNSString(model.vinNo,@"")) {
            [_placeholderLabel setText:model.vinNo];
        }else {
            [_placeholderLabel setText:@"  "];
        }
    }
    else if ([self.title isEqualToString:@"发动机号:"]) {
        if (isUsableNSString(model.engineNo,@"")) {
            [_placeholderLabel setText:model.engineNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
//    else if ([self.title isEqualToString:@"车型代码:"]) {
//        if ( isUsableNSString(model.model,@"")) {
//            [_placeholderLabel setText:model.model];
//        }else {
//            [_placeholderLabel setText:@" "];
//        }
//    }
    else if ([self.title isEqualToString:@"联系方式:"]) {
        if (isUsableNSString(model.phoneNo,@"")) {
            [_placeholderLabel setText:model.phoneNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"跟进类型:"]) {
        if (isUsableNSString(model.operate,@"")) {
            [_placeholderLabel setText:model.operate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
    else if ([self.title isEqualToString:@"跟进时间:"]) {
        if (isUsableNSString(model.nextFollowTime,@"")) {
            [_placeholderLabel setText:model.nextFollowTime];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
}

- (void)setupCellWithChargeBackModel:(XCCheckoutDetailBaseModel *)model
{
    if ([self.title isEqualToString:@"投保人:"]) {
        if (isUsableNSString(model.onwerName,@"")) {
            [_placeholderLabel setText:model.onwerName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"身份证:"]  ) {
        if (isUsableNSString(model.onwerIdentify,@"")&&isUsableNSString(model.onwerIdentify,@"null")) {
            [_placeholderLabel setText:model.onwerIdentify];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"车牌号:"] ) {
        if (isUsableNSString(model.plateNo,@"")) {
            [_placeholderLabel setText:model.plateNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"车架号:"] ) {
        if (isUsableNSString(model.vinNo,@"")) {
            [_placeholderLabel setText:model.vinNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"初登日期:"] ) {
        if (isUsableNSString(model.recordDate,@"")) {
//            NSMutableString *tmpDate = [NSMutableString stringWithString:model.recordDate];
//            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_placeholderLabel setText:model.recordDate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"发动机号:"] ) {
        if (isUsableNSString(model.engineNo,@"")) {
            [_placeholderLabel setText:model.engineNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"品牌型号:"]) {
        if (isUsableNSString(model.brand,@"")) {
            [_placeholderLabel setText:model.brand];
        }else {
            [_placeholderLabel setText:@" "];
        }
//    }else if ([self.title isEqualToString:@"车型代码:"]) {
//        if (isUsableNSString(model.model,@"")) {
//            [_placeholderLabel setText:model.model];
//        }else {
//            [_placeholderLabel setText:@" "];
//        }
    }else if ([self.title isEqualToString:@"(商业)起保日期:"]) {
        if (isUsableNSString(model.syEffectDate,@"")) {
//            NSMutableString *tmpDate = [NSMutableString stringWithString:model.syEffectDate];
//            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_placeholderLabel setText:model.syEffectDate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"(交强)起保日期:"]) {
        if (isUsableNSString(model.jqEffectDate,@"")) {
//            NSMutableString *tmpDate = [NSMutableString stringWithString:model.jqEffectDate];
//            NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
            [_placeholderLabel setText:model.jqEffectDate];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"保险公司:"] ) {
        if (isUsableNSString(model.insurerName,@"")) {
            [_placeholderLabel setText:model.insurerName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"缴费通知单号:"]) {
        if (isUsableNSString(model.payNoticeNo,@"")) {
            [_placeholderLabel setText:model.payNoticeNo];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"交强险(业务员)金额:"] ) {
        if (isUsable(model.jqMoney, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.jqMoney doubleValue]]];
        }else {
            [_placeholderLabel setText:@"0.00"];
        }
    }else if ([self.title isEqualToString:@"商业险(业务员)金额:"]) {
        if (isUsable(model.syMoney, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.syMoney doubleValue]]];
        }else {
            [_placeholderLabel setText:@"0.00"];
        }
    }else if ([self.title isEqualToString:@"交强险(出单员)金额:"]) {
        if (isUsable(model.jqMoneyExport, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.jqMoneyExport doubleValue]]];
        }else {
            [_placeholderLabel setText:@"0.00"];
        }
    }else if ([self.title isEqualToString:@"商业险(出单员)金额:"]) {
        if (isUsable(model.syMoneyExport, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithFormat:@"%.2f",[model.syMoneyExport doubleValue]]];
        }else {
            [_placeholderLabel setText:@"0.00"];
        }
    }else if ([self.title isEqualToString:@"出单员:"] ) {
        if (isUsableNSString(model.exportmanName,@"")) {
            [_placeholderLabel setText:model.exportmanName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }else if ([self.title isEqualToString:@"交强险:"] ) {
        if ( isUsable(model.jqValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.jqValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"机动车损险:"] ) {
        if (isUsable(model.csValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.csValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"第三责任险:"] ) {
        if (isUsable(model.szValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.szValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"车上(司机)险:"]) {
        if (isUsable(model.cssjValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.cssjValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"车上(乘客)险:"] ) {
        if (isUsable(model.csckValue, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.csckValue doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }else if ([self.title isEqualToString:@"出单员:"] ) {
        if (isUsableNSString(model.exportmanName,@"")) {
            [_placeholderLabel setText:model.exportmanName];
        }else {
            [_placeholderLabel setText:@" "];
        }
    }
}
- (void)setupCellWithShopServiceModel:(XCShopServiceModel *)model
{
    
    if ([self.titleLabel.text isEqualToString:@"当前状态:"]) {
        if (isUsableNSString(model.status, @"")) {
            if ([model.status isEqualToString:@"待审核"]) {
                [_placeholderLabel setText:@"审核中"];
            }
            else if ([model.status isEqualToString:@"审核通过"]) {
                [_placeholderLabel setText:@"已上架"];
            }
            else if ([model.status isEqualToString:@"审核不通过"]) {
                [_placeholderLabel setText:@"已拒绝"];
            }
            else if ([model.status isEqualToString:@"下架"]) {
                [_placeholderLabel setText:@"已下架"];
            }
        }else {
            [_placeholderLabel setText:@""];
        }
    }
    else if ([self.titleLabel.text isEqualToString:@"拒绝时间:"] ||
             [self.titleLabel.text isEqualToString:@"提交时间:"]||
             [self.titleLabel.text isEqualToString:@"下架时间:"]||[self.titleLabel.text isEqualToString:@"上架时间:"])
    {
        if ([self.titleLabel.text isEqualToString:@"拒绝时间:"]) {
            if (isUsableNSString(model.auditingTime, @"")) {
                [_placeholderLabel setText:model.auditingTime];
            }else {
                [_placeholderLabel setText:@""];
            }
        }
        else if ([self.titleLabel.text isEqualToString:@"提交时间:"])
        {
            if (isUsableNSString(model.updateTime, @"")) {
                [_placeholderLabel setText:model.updateTime];
            }else {
                [_placeholderLabel setText:@""];
            }
        }
        else if ([self.titleLabel.text isEqualToString:@"下架时间:"])
        {
            if (isUsableNSString(model.updateTime, @"")) {
                [_placeholderLabel setText:model.updateTime];
            }else {
                [_placeholderLabel setText:@""];
            }
        }
        else if ([self.titleLabel.text isEqualToString:@"上架时间:"])
        {
            if (isUsableNSString(model.updateTime, @"")) {
                [_placeholderLabel setText:model.updateTime];
            }else {
                [_placeholderLabel setText:@""];
            }
        }
    }
    else if ([self.titleLabel.text isEqualToString:@"品牌原价:"] )
    {
        if (isUsable(model.servicePrice, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.servicePrice doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }
    else if ([self.titleLabel.text isEqualToString:@"品牌会员价:"] )
    {
        if (isUsable(model.serviceVipPrice, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.serviceVipPrice doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }
    else if ([self.titleLabel.text isEqualToString:@"专属原价:"] )
    {
        _placeholderLabel.textColor = [UIColor redColor];
        if (isUsable(model.price, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.price doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }
    else if ([self.titleLabel.text isEqualToString:@"专属会员价:"] )
    {
        _placeholderLabel.textColor = [UIColor redColor];
        if (isUsable(model.vipPrice, [NSNumber class])) {
            [_placeholderLabel setText:[NSString stringWithMoneyNumber:[model.vipPrice doubleValue]]];
        }else {
            [_placeholderLabel setText:@"¥0.00"];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _titleLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(51, 51, 51)];
    [self addSubview:_titleLabel];
    
    _placeholderLabel = [UILabel createLabelWithTextFontSize:28 textColor:COLOR_RGB_255(165, 165, 165)];
    [self addSubview:_placeholderLabel];
    
    _separtatorLine = [[UIView alloc] init];
    [_separtatorLine setBackgroundColor:COLOR_RGB_255(229, 229, 229)];
    [self addSubview:_separtatorLine];
}

#pragma mark - Setter&Getter

- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title]) {
        return;
    }
    _title = title;
    [_titleLabel setText:_title];
    [_titleLabel sizeToFit];

}

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    _titlePlaceholder = titlePlaceholder;
    [_placeholderLabel setText:_titlePlaceholder];
    [_placeholderLabel sizeToFit];
}


@end
