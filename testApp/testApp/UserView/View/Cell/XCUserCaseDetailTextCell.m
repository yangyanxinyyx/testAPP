//
//  XCUserCaseDetailTextCell.m
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserCaseDetailTextCell.h"
#import "UILabel+createLabel.h"
#import "NSString+MoneyString.h"
@interface XCUserCaseDetailTextCell()
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topView ;
/** <# 注释 #> */
@property (nonatomic, strong) UILabel * titleLabel ;
/** <# 注释 #> */
@property (nonatomic, strong) UIView * topLine ;

/** <# 注释 #> */
@property (nonatomic, strong) NSMutableArray * labelArrM ;

/** <# 注释 #> */
@property (nonatomic, strong) UILabel * mutableTextLabel ;

/** <# 注释 #> */
@property (nonatomic, strong) NSArray * titleValueArr ;

/** <# 注释 #> */
@property (nonatomic, strong) XCUserCaseDetailModel * caseModel ;
@end

@implementation XCUserCaseDetailTextCell

+ (CGFloat)getCellHeight
{
    return (20 + 557 - (24+24)) * ViewRateBaseOnIP6;
}

+ (CGFloat)getCellHeightWithCount:(NSUInteger)count
{
    if (count > 0 ) {
        return (20 + 88 + 1) * ViewRateBaseOnIP6  + (count - 1) * (30+24) * ViewRateBaseOnIP6 + 30 * ViewRateBaseOnIP6;
    }else {
        return (20 + 88 + 1) * ViewRateBaseOnIP6 + 30 * ViewRateBaseOnIP6;
    }
  
}

+ (CGFloat)getCaseCellHeightWithClip:(BOOL)clip
{
    if(clip) {
        return (392 +24+24) * ViewRateBaseOnIP6;
    }else {
        return (392 + 24+24 +24+24) * ViewRateBaseOnIP6;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _labelArrM = [[NSMutableArray alloc] init];
        _isMutableTextType = NO;
        _isWeizhangType = NO ;
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
    CGFloat leftMargin = 30 * ViewRateBaseOnIP6;
    
    [_topView setFrame:CGRectMake(0, 0, self.bounds.size.width, 20 * ViewRateBaseOnIP6 )];
    [_titleLabel sizeToFit];
    CGSize labelSize = _titleLabel.frame.size;
    [_titleLabel setFrame:CGRectMake(leftMargin,CGRectGetMaxY(_topView.frame) + ((88 - 29) * ViewRateBaseOnIP6 ) * 0.5, labelSize.width, 29 * ViewRateBaseOnIP6)];
    [_topLine setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_topView.frame) + 88 * ViewRateBaseOnIP6, self.bounds.size.width - leftMargin * 2, 1)];
    
    CGFloat startY = CGRectGetMaxY(_topLine.frame);
    CGFloat topMargin = 30 * ViewRateBaseOnIP6;
    CGFloat labelTopMargin = 24 * ViewRateBaseOnIP6;
    if (_isMutableTextType) {
        [_mutableTextLabel sizeToFit];
        labelSize = _mutableTextLabel.frame.size;
        [_mutableTextLabel setFrame:CGRectMake(leftMargin, (startY + topMargin)  , 645 * ViewRateBaseOnIP6, labelSize.height)];
        if (_labelArrM.count > 0 ) {
            for (int i = 0 ; i < _labelArrM.count; i++) {
                UILabel *label = _labelArrM[i];
                [label setFrame:CGRectZero];
            }
        }
    }else {
        [_mutableTextLabel setFrame:CGRectZero];
        if (_labelArrM.count > 0 ) {
            UILabel *lastLabel = nil;
            for (int i = 0 ; i < _labelArrM.count; i++) {
                UILabel *label = _labelArrM[i];
                [label sizeToFit];
                labelSize = label.frame.size;

                if (_isWeizhangType) {
                    //车务VC违章模式
                    if (i == 0) {
                        [label setFrame:CGRectMake(leftMargin, (startY + topMargin) , labelSize.width, 24 * ViewRateBaseOnIP6)];
                        lastLabel = label;
                    }
                    else if(i == 9){
                        [label sizeToFit];
                        CGFloat height = [UILabel getXCTextHeightLineWithString:label.text withWidth:self.bounds.size.width - leftMargin * 2 withFontSize:26];
                        [label setFrame:CGRectMake(leftMargin, CGRectGetMaxY(lastLabel.frame) + labelTopMargin  , self.bounds.size.width - leftMargin * 2, height)];
                        lastLabel = label;
                    }
                    else {
                        [label setFrame:CGRectMake(leftMargin,  CGRectGetMaxY(lastLabel.frame) + labelTopMargin , self.bounds.size.width - leftMargin * 2, 24 * ViewRateBaseOnIP6)];
                        lastLabel = label;
                    }
                }else {
                    //普通模式
                    if (i == 0) {
                        [label setFrame:CGRectMake(leftMargin, (startY + topMargin) , labelSize.width, 24 * ViewRateBaseOnIP6)];
                        lastLabel = label;
                    }
                    else {
                        [label setFrame:CGRectMake(leftMargin,  CGRectGetMaxY(lastLabel.frame) + labelTopMargin , self.bounds.size.width - leftMargin * 2, 24 * ViewRateBaseOnIP6)];
                        lastLabel = label;
                    }
                }
            }
        }
    }
  
}

#pragma mark - Action Method

- (void)setupCellWithCarTransactionDetailModel:(XCCarTransactioDetailModel *)model
{
//    NSArray *baseTitleNameArr = @[@"客户名称:",@"车牌号:",@"品牌型号:",
//                                  @"车架号:",@"发动机号:",
//                                  @"联系电话:",@"年审到期时间:",@"备注:"];
    NSArray *baseTitleNameArr = @[@"客户名称:",@"联系电话:",@"车牌号:",
                                  @"品牌型号:",@"车架号:",@"发动机号:",
                                  @"车类型:",@"年审费用:",@"年审到期时间:",
                                  @"备注:"];
    
    NSString * name = @"";
    NSString * phone = @"";
    NSString * plateNo = @"";
    NSString * brand = @"";
    NSString * vinNo = @"";
    NSString * engineNo = @"";
    NSString * carType = @"";
    NSString * annualPrice = @"";
    NSString * time = @"";
    NSString * remark = @"";
    
    
    if (isUsableNSString(model.customerName, @"")) {
        name = model.customerName;
    }
    if (isUsableNSString(model.plateNo, @"")) {
        plateNo = model.plateNo;
    }
    if (isUsableNSString(model.brand, @"")) {
        brand = model.brand;
        carType = model.brand;
    }
    if (isUsableNSString(model.vinNo, @"")) {
        vinNo = model.vinNo;
    }
    if (isUsableNSString(model.engineNo,@"")) {
        engineNo = model.engineNo;
    }
    if (isUsableNSString(model.phone, @"")) {
        phone = model.phone;
    }
    if (isUsableNSString(model.phone, @"")) {
        phone = model.phone;
    }
    if (isUsable(model.orderPrice, [NSNumber class])) {
        annualPrice = [NSString stringWithMoneyNumber:[model.orderPrice doubleValue]];
    }
    if (isUsableNSString(model.motTestTime, @"")) {
        time = model.motTestTime;
    }
    if (isUsableNSString(model.remark, @"")) {
        remark = model.remark;
    }
//    self.titleValueArr = @[name,plateNo,brand,vinNo,engineNo,phone,time,remark];
self.titleValueArr = @[name,phone,plateNo,brand,vinNo,engineNo,carType,annualPrice,time,remark];
    for (int i = 0 ; i < _labelArrM.count; i++) {
        NSString * title = baseTitleNameArr[i];
        UILabel *label = _labelArrM[i];
        [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
    }
    
}

- (void)setupCellWithViolationCarTranDetailModel:(XCCarTransactioDetailModel *)model
{
    NSArray *baseTitleNameArr = @[@"客户名称:",@"车牌号:",@"品牌型号:",
                                  @"车架号:",@"发动机号:",
                                  @"违章地点:",@"违章城市:",@"违章时间:",
                                  @"违章分数:",@"违章条款:",@"总费用:"
                                  ,@"备注:"];
    
    NSString * name = @"";
    NSString * plateNo = @"";
    NSString * brand = @"";
    NSString * vinNo = @"";
    NSString * engineNo = @"";
//    NSString * Carmodel = @"";
    NSString * weizhangArea = @"";
    NSString * weizhangCity = @"";
    NSString * weizhangDate = @"";
    NSString * buckleScores = @"0分";
    NSString * weizhangClause = @"";
    NSString * orderPrice = @"¥0.00";
    NSString * remark = @"";
    
    
    if (isUsableNSString(model.customerName, @"")) {
        name = model.customerName;
    }
    if (isUsableNSString(model.plateNo, @"")) {
        plateNo = model.plateNo;
    }
    if (isUsableNSString(model.brand, @"")) {
        brand = model.brand;
    }
    if (isUsableNSString(model.vinNo, @"")) {
        vinNo = model.vinNo;
    }
    if (isUsableNSString(model.engineNo,@"")) {
        engineNo = model.engineNo;
    }
//    if (isUsableNSString(model.model, @"")) {
//        Carmodel = model.model;
//    }
    if (isUsableNSString(model.weizhangArea, @"")) {
        weizhangArea = model.weizhangArea;
    }
    if (isUsableNSString(model.weizhangCity, @"")) {
        weizhangCity = model.weizhangCity;
    }
    if (isUsableNSString(model.weizhangDate, @"")) {
        weizhangDate = model.weizhangDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.weizhangDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        weizhangDate = [tmpArr firstObject];
    }
    if (isUsable(model.buckleScores, [NSNumber class])) {
        buckleScores = [NSString stringWithFormat:@"%@分",model.buckleScores];
    }
    if (isUsableNSString(model.weizhangClause, @"")) {
        weizhangClause = model.weizhangClause;
    }

    if (isUsable(model.orderPrice, [NSNumber class])) {
        orderPrice = [NSString stringWithMoneyNumber:[model.orderPrice doubleValue]];
    }
    if (isUsableNSString(model.remark, @"")) {
        remark = model.remark;
    }
    self.titleValueArr = @[name,plateNo,brand,
                           vinNo,engineNo,
                           weizhangArea,weizhangCity,
                           weizhangDate,buckleScores,weizhangClause,orderPrice,
                           remark];
    
    for (int i = 0 ; i < _labelArrM.count; i++) {
        NSString * title = baseTitleNameArr[i];
        UILabel *label = _labelArrM[i];
        [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];

    }
}

- (void)setupCellWithRepairCarTranDetailModel:(XCCarTransactioDetailModel *)model
{
    NSArray *baseTitleNameArr = @[@"客户名称:",@"车牌号:",@"品牌型号:",
                                  @"车架号:",@"发动机号:",
                                  @"联系电话:",@"预约时间:",@"保险金额:",
                                  @"自费金额:",@"门店名称:",@"备注:"];
    
    NSString * name = @"";
    NSString * plateNo = @"";
    NSString * brand = @"";
    NSString * vinNo = @"";
    NSString * engineNo = @"";
//    NSString * Carmodel = @"";
    NSString * phone = @"";
    NSString * appointmentTime = @"";
    NSString * insurance = @"¥0.00";
    NSString * weixiuZifei = @"¥0.00";
    NSString * storeName = @"";
    NSString * remark = @"";
    
    if (isUsableNSString(model.customerName, @"")) {
        name = model.customerName;
    }
    if (isUsableNSString(model.plateNo, @"")) {
        plateNo = model.plateNo;
    }
    if (isUsableNSString(model.brand, @"")) {
        brand = model.brand;
    }
    if (isUsableNSString(model.vinNo, @"")) {
        vinNo = model.vinNo;
    }
    if (isUsableNSString(model.engineNo,@"")) {
        engineNo = model.engineNo;
    }
//    if (isUsableNSString(model.model, @"")) {
//        Carmodel = model.model;
//    }
    if (isUsableNSString(model.phone, @"")) {
        phone = model.phone;
    }
    if (isUsableNSString(model.appointmentTime, @"")) {
        appointmentTime = model.appointmentTime;
    }
    if (isUsable(model.insurance, [NSNumber class])) {
        insurance = [NSString stringWithMoneyNumber:[model.insurance doubleValue]];
    }
    if (isUsable(model.insurance, [NSNumber class])) {
        weixiuZifei = [NSString stringWithMoneyNumber:[model.weixiuZifei doubleValue]];
    }
    if (isUsableNSString(model.storeName, @"")) {
        storeName = model.storeName;
    }
    if (isUsableNSString(model.remark, @"")) {
        remark = model.remark;
    }
    self.titleValueArr = @[name,plateNo,brand,
                           vinNo,engineNo,
                           phone,appointmentTime,insurance,
                           weixiuZifei,storeName,remark];
    
    for (int i = 0 ; i < _labelArrM.count; i++) {
        NSString * title = baseTitleNameArr[i];
        UILabel *label = _labelArrM[i];
        [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
    }
}

- (void)setupCellWithCaseDetailModel:(XCUserCaseDetailModel *)model clipName:(BOOL)clip
{
    _caseModel = model;
    NSString *contacts = @" ";
    NSString *phone = @" ";
    NSString *carNum = @" ";
    NSString *occurTime = @" ";
    NSString *createTime = @" ";
    NSString *name = @" "; //选择门店
#warning 缺少咨询电话
    NSString *namePhone = THREECASEDETAIL_CUSTOMERPHOT;
    if (isUsableNSString(model.contacts, @"")) {
        contacts = model.contacts;
    }
    if (isUsableNSString(model.phone, @"")) {
        phone = model.phone;
    }
    if (isUsableNSString(model.plateNo, @"")) {
        carNum = model.plateNo;
    }
    if (isUsableNSString(model.occurTime, @"")) {
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.occurTime];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        occurTime = [tmpArr firstObject];
        occurTime = model.occurTime;
    }
    if (isUsableNSString(model.createTime, @"")) {
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.createTime];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        occurTime = [tmpArr firstObject];
        createTime = model.createTime;
    }
    if (isUsableNSString(model.name, @"")) {
        name = model.name;
    }
    NSArray *baseTitleNameArr;
    if (clip) {
        baseTitleNameArr = @[@"联 系 人 :",@"联系电话:",@"车 牌 号 :", @"案发时间:",
                                       @"提交时间:",@"咨询电话:"];
        self.titleValueArr = @[contacts,phone,carNum,occurTime,
                               createTime,namePhone];
    }else {
        baseTitleNameArr = @[@"联 系 人 :",@"联系电话:",@"车 牌 号 :",@"案发时间:",
                                       @"提交时间:",@"选择门店:",@"咨询电话:"];
        self.titleValueArr = @[contacts,phone,carNum,occurTime,
                               createTime,name,namePhone];
    }
   
    
    for (int i = 0 ; i < _labelArrM.count; i++) {
        NSString * title = baseTitleNameArr[i];
        UILabel *label = _labelArrM[i];
        if (i == 1) {
            if (isUsableNSString(model.phone, @"")) {
                NSTextAttachment *foreAttachment = [[NSTextAttachment alloc]init];
                foreAttachment.image = [UIImage imageNamed:@"callphone"];
                foreAttachment.bounds = CGRectMake(0, -3, 26 * ViewRateBaseOnIP6, 26 * ViewRateBaseOnIP6);
                NSAttributedString *phoneCallString = [NSAttributedString attributedStringWithAttachment:foreAttachment];
                
                NSMutableAttributedString *kongAttributString = [[NSMutableAttributedString alloc]initWithString:@""];
                
                NSMutableAttributedString *newAttributString = [[NSMutableAttributedString alloc]initWithString:model.phone];
                [newAttributString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:26 * ViewRateBaseOnIP6] range:NSMakeRange(0, model.phone.length)];
                [newAttributString addAttribute:NSForegroundColorAttributeName value:COLOR_RGB_255(0, 77, 161) range:NSMakeRange(0, model.phone.length)];
                [newAttributString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, model.phone.length)];
                
                NSMutableAttributedString * attrStrM = [[NSMutableAttributedString alloc] initWithString:@"联系电话: "];
                [attrStrM appendAttributedString:phoneCallString];
                [attrStrM appendAttributedString:kongAttributString];                          
                [attrStrM appendAttributedString:newAttributString];
                label.attributedText = attrStrM;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabelCappPhone:)];
                [label addGestureRecognizer:tap];
                label.userInteractionEnabled = YES;
            }else {
                [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
            }
        }else {
            [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
        }
    }
    
}

- (void)clickLabelCappPhone:(UILabel *)lable
{
    NSLog(@"====>打电话");
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_caseModel.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    

}

- (void)setupDistributionCellWithDetailBaseModel:(XCCheckoutDetailBaseModel *)model
{
    self.labelTitleArrM = @[@"投保人:",@"身份证:",@"车牌号:",
                                 @"车架号:",@"初登日期:",@"发动机号:",
                                 @"品牌型号:",@"(商业)起保日期:",
                                 @"(交强)起保日期:",@"保险公司:",@"缴费通知单号:",
                                 @"交强险(保单)金额:",@"商业险(保单)金额:",@"交强险保单最终金额:",
                                 @"商业险保单最终金额:",@"交强险保单:",@"商业险保单:",
                                 @"出单员:",@"备注:"];
    NSString * onwerName = @" ";
    NSString * onwerIdentify = @" ";
    NSString * plateNo = @" ";
    NSString * vinNo = @" ";
    NSString * recordDate = @" ";
    NSString * engineNo = @" ";
    NSString * brand = @" ";
//    NSString * carModel = @" ";
    NSString * syEffectDate = @" ";
    NSString * jqEffectDate = @" ";
    NSString * insurerName = @" ";
    NSString * payNoticeNo = @" ";
    NSString * jqMoney = @"0.00";
    NSString * syMoney = @"0.00";
    NSString * jqMoneyFinal = @"0.00";
    NSString * syMoneyFinal = @"0.00";
    NSString * jqNumber = @" ";
    NSString * syNumber = @" ";
    NSString * exportmanName = @" ";
    NSString * remark = @" ";
    if (isUsableNSString(model.onwerName, @"")) {
        onwerName = model.onwerName;
    }
    if (isUsableNSString(model.onwerIdentify, @"")) {
        onwerIdentify = model.onwerIdentify;
    }
    if (isUsableNSString(model.plateNo, @"")) {
        plateNo = model.plateNo;
    }
    if (isUsableNSString(model.vinNo, @"")) {
        vinNo = model.vinNo;
    }
    if (isUsableNSString(model.recordDate, @"")) {
        recordDate = model.recordDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.recordDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        recordDate = [tmpArr firstObject];
    }
    if (isUsableNSString(model.engineNo, @"")) {
        engineNo = model.engineNo;
    }
    if (isUsableNSString(model.brand, @"")) {
        brand = model.brand;
    }
//    if (isUsableNSString(model.model, @"")) {
//        carModel = model.model;
//    }
    if (isUsableNSString(model.syEffectDate, @"")) {
        syEffectDate = model.syEffectDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.syEffectDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        recordDate = [tmpArr firstObject];
    }
    if (isUsableNSString(model.jqEffectDate, @"")) {
        jqEffectDate = model.jqEffectDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.jqEffectDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        recordDate = [tmpArr firstObject];
    }
    if (isUsableNSString(model.insurerName, @"")) {
        insurerName = model.insurerName;
    }
    if (isUsableNSString(model.payNoticeNo, @"")) {
        payNoticeNo = model.payNoticeNo;
    }
    if (isUsable(model.jqMoneyExport, [NSNumber class])) {
        jqMoney = [NSString stringWithMoneyNumber:[model.jqMoneyExport doubleValue]];
    }
    if (isUsable(model.syMoneyExport, [NSNumber class])) {
        syMoney =  [NSString stringWithMoneyNumber:[model.syMoneyExport doubleValue]];
    }
    if (isUsable(model.jqMoneyFinal, [NSNumber class])) {
        jqMoneyFinal =  [NSString stringWithMoneyNumber:[model.jqMoneyFinal doubleValue]];
    }
    if (isUsable(model.syMoneyFinal, [NSNumber class])) {
        syMoneyFinal =  [NSString stringWithMoneyNumber:[model.syMoneyFinal doubleValue]];
    }
    if (isUsableNSString(model.jqNumber, @"")) {
        jqNumber = [NSString stringWithMoneyNumber:[model.jqNumber doubleValue]];
    }
    if (isUsableNSString(model.syNumber, @"")) {
        syNumber = [NSString stringWithMoneyNumber:[model.syNumber doubleValue]];
    }
    if (isUsableNSString(model.exportmanName, @"")) {
        exportmanName = model.exportmanName;
    }
    if (isUsableNSString(model.remark, @"")) {
        remark = model.remark;
    }
    self.titleValueArr = @[onwerName,onwerIdentify,plateNo,
                           vinNo,recordDate,engineNo,
                           brand,syEffectDate,
                           jqEffectDate,insurerName,payNoticeNo,
                            syMoney,jqMoney,jqMoneyFinal,
                           syMoneyFinal,jqNumber,syNumber,
                           exportmanName,remark];
    
    for (int i = 0 ; i < _labelArrM.count ; i++) {
        NSString * title = _labelTitleArrM[i];
        UILabel *label = _labelArrM[i];
        [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
    }

}

- (void)setupFinaAudiaCellWithDetailBaseModel:(XCCheckoutDetailBaseModel *)model
{
    self.labelTitleArrM  = @[@"投保人:",@"身份证:",@"车牌号:",
                                  @"车架号:",@"初登日期:",@"发动机号:",
                                  @"品牌型号:",@"(商业)起保日期:",
                                  @"(交强)起保日期:",@"保险公司:",@"缴费通知单号:",
                                  @"交强险(保单)金额:",@"商业险(保单)金额:",@"交强险保单最终金额:",
                                  @"商业险保单最终金额:",@"交强险保单:",@"商业险保单:",
                                  @"交强险佣金:",@"商业险佣金:",@"交强险提成:",
                                  @"商业险提成:",@"出单员:",@"备注:"];
    
    NSString * onwerName = @"";
    NSString * onwerIdentify = @"";
    NSString * plateNo = @"";
    NSString * vinNo = @"";
    NSString * recordDate = @"";
    NSString * engineNo = @"";
    NSString * brand = @"";
//    NSString * carModel = @"";
    NSString * syEffectDate = @"";
    NSString * jqEffectDate = @"";
    NSString * insurerName = @"";
    NSString * payNoticeNo = @"";
    NSString * jqMoney = @"¥0.00";
    NSString * syMoney = @"¥0.00";
    NSString * jqMoneyFinal = @"¥0.00";
    NSString * syMoneyFinal = @"¥0.00";
    NSString * jqNumber = @"";
    NSString * syNumber = @"";
    NSString * jqBonus = @"¥0.00";
    NSString * syBonus = @"¥0.00";
    NSString * jqCommission = @"¥0.00";
    NSString * syCommission = @"¥0.00";
    NSString * exportmanName = @"";
    NSString * remark = @"";
    if (isUsableNSString(model.onwerName,@"")) {
        onwerName = model.onwerName;
    }
    if (isUsableNSString(model.onwerIdentify, @"")) {
        onwerIdentify = model.onwerIdentify;
    }
    if (isUsableNSString(model.plateNo, @"")) {
        plateNo = model.plateNo;
    }
    if (isUsableNSString(model.vinNo, @"")) {
        vinNo = model.vinNo;
    }
    if (isUsableNSString(model.recordDate, @"")) {
                recordDate = model.recordDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.recordDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        recordDate = [tmpArr firstObject];
    }
    if (isUsableNSString(model.engineNo, @"")) {
        engineNo = model.engineNo;
    }
    if (isUsableNSString(model.brand, @"")) {
        brand = model.brand;
    }
//    if (isUsableNSString(model.model, @"")) {
//        carModel = model.model;
//    }
    if (isUsableNSString(model.syEffectDate, @"")) {
                syEffectDate = model.syEffectDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.syEffectDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        syEffectDate = [tmpArr firstObject];
    }
    if (isUsableNSString(model.jqEffectDate, @"")) {
                jqEffectDate = model.jqEffectDate;
//        NSMutableString *tmpDate = [NSMutableString stringWithString:model.jqEffectDate];
//        NSArray *tmpArr = [tmpDate componentsSeparatedByString:@" "];
//        jqEffectDate = [tmpArr firstObject];
    }
    if (isUsableNSString(model.insurerName, @"")) {
        insurerName = model.insurerName;
    }
    if (isUsableNSString(model.payNoticeNo, @"")) {
        payNoticeNo = model.payNoticeNo;
    }
    if (isUsable(model.jqMoney, [NSNumber class])) {
        jqMoney = [NSString stringWithMoneyNumber:[model.jqMoney doubleValue]];
    }
    if (isUsable(model.syMoney, [NSNumber class])) {
        syMoney = [NSString stringWithMoneyNumber:[model.syMoney doubleValue]];
    }
    if (isUsable(model.jqMoneyFinal, [NSNumber class])) {
        jqMoneyFinal = [NSString stringWithMoneyNumber:[model.jqMoneyFinal doubleValue]];
    }
    if (isUsable(model.syMoneyFinal, [NSNumber class])) {
        syMoneyFinal = [NSString stringWithMoneyNumber:[model.syMoneyFinal doubleValue]];
    }
    if (isUsableNSString(model.jqNumber, @"")) {
        jqNumber = model.jqNumber;
    }
    if (isUsableNSString(model.syNumber, @"")) {
        syNumber =  model.syNumber;
    }
    if (isUsable(model.jqBonus, [NSNumber class])) {
        jqBonus = [NSString stringWithMoneyNumber:[model.jqBonus doubleValue]];
    }
    if (isUsable(model.syBonus, [NSNumber class])) {
        syBonus = [NSString stringWithMoneyNumber:[model.syBonus doubleValue]];
    }
    if (isUsable(model.jqCommission, [NSNumber class])) {
        jqCommission =  [NSString stringWithMoneyNumber:[model.jqCommission doubleValue]];
    }
    if (isUsable(model.syCommission, [NSNumber class])) {
        syCommission = [NSString stringWithMoneyNumber:[model.syCommission doubleValue]];
    }
    if (isUsableNSString(model.exportmanName, @"")) {
        exportmanName = model.exportmanName;
    }
    if (isUsableNSString(model.remark, @"")) {
        remark = model.remark;
    }
    self.titleValueArr = @[onwerName,onwerIdentify,plateNo,
                           vinNo,recordDate,engineNo,
                           brand,syEffectDate,
                           jqEffectDate,insurerName,payNoticeNo,
                           jqMoney,syMoney,jqMoneyFinal,
                           syMoneyFinal,jqNumber,syNumber,
                           jqBonus,syBonus,jqCommission,
                           syCommission,exportmanName,remark];
    
    for (int i = 0 ; i < _labelArrM.count; i++) {
        NSString * title = _labelTitleArrM[i];
        UILabel *label = _labelArrM[i];
        [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
    }
}

-(void)setupCommonDFBillCellWithDetailBaseModel:(XCCheckoutDetailBaseModel *)model
{
    self.labelTitleArrM = @[@"交强险:",@"机动车损险:",@"第三责任险:",
                                  @"车上(司机)险:",@"车上(乘客)险:"];
    NSString * jqValue = @"¥0.00";
    NSString * csValue = @"¥0.00";
    NSString * szValue = @"¥0.00";
    NSString * cssjValue = @"¥0.00";
    NSString * csckValue = @"¥0.00";
    if (isUsable(model.jqValue, [NSNumber class])) {
        jqValue = [NSString stringWithMoneyNumber:[model.jqValue doubleValue]];
    }
    if (isUsable(model.csValue, [NSNumber class])) {
        csValue = [NSString stringWithMoneyNumber:[model.csValue doubleValue]];
    }
    if (isUsable(model.szValue, [NSNumber class])) {
        szValue = [NSString stringWithMoneyNumber:[model.szValue doubleValue]];
    }
    if (isUsable(model.cssjValue, [NSNumber class])) {
        cssjValue = [NSString stringWithMoneyNumber:[model.cssjValue doubleValue]];
    }
    if (isUsable(model.csckValue, [NSNumber class])) {
        csckValue = [NSString stringWithMoneyNumber:[model.csckValue doubleValue]];
    }
    self.titleValueArr = @[jqValue,csValue,szValue,cssjValue,csckValue];
    for (int i = 0 ; i < _labelArrM.count; i++) {
        NSString * title = _labelTitleArrM[i];
        UILabel *label = _labelArrM[i];
        [label setText:[NSString stringWithFormat:@"%@ %@",title,self.titleValueArr[i]]];
    }
}


#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

- (void)configSubVies
{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = COLOR_RGB_255(242, 242, 242);
    
    _titleLabel = [UILabel createLabelWithTextFontSize:30 textColor:COLOR_RGB_255(68, 68, 68)  ];
    
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = COLOR_RGB_255(242, 242, 242);
    
    _mutableTextLabel = [[UILabel alloc] init];
    [_mutableTextLabel setTextColor:COLOR_RGB_255(136, 136, 136)];
    [_mutableTextLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:24 * ViewRateBaseOnIP6]];
    _mutableTextLabel.numberOfLines = 0;
    [self addSubview:_topView];
    [self addSubview:_titleLabel];
    [self addSubview:_topLine];
    [self addSubview:_mutableTextLabel];
    
}

#pragma mark - Setter&Getter
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    [_titleLabel setText:_titleStr];
}

- (void)setLongString:(NSString *)longString
{
    _longString = longString;
     [_mutableTextLabel setText:longString];
}

- (void)setLabelTitleArrM:(NSArray *)labelTitleArrM
{
    if (!labelTitleArrM) {
        return;
    }
  
    if (_labelArrM.count > 0) {
        for (UILabel * label in _labelArrM) {
            for (UIView *subView in self.subviews) {
                if ([label isEqual:subView]) {
                    [label removeFromSuperview];
                }
            }
        }
        [_labelArrM removeAllObjects];
    }
    
    _labelTitleArrM = labelTitleArrM;
    for (int i = 0 ; i < labelTitleArrM.count; i++) {
        NSString *title = labelTitleArrM[i];
        UILabel *label = [UILabel createLabelWithTextFontSize:26 textColor:COLOR_RGB_255(51, 51, 51)];
        if(i == 9){
            label.numberOfLines = 0;
        }
        [label setText:title];
        [self addSubview:label];
        [_labelArrM addObject:label];
    }
    
}


@end
