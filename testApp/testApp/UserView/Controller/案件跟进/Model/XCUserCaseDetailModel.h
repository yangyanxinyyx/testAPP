//
//  XCUserCaseDetailModel.h
//  testApp
//
//  Created by Melody on 2018/4/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUserCaseDetailModel : NSObject
/** 联系人 */
@property (nonatomic, copy) NSString * contacts;
/** 联系电话 */
@property (nonatomic, copy) NSString * phone;
/** 案件发生时间 */
@property (nonatomic, copy) NSString * occurTime;
/** 提交时间 */
@property (nonatomic, copy) NSString * createTime;
/** 选择门店 */
@property (nonatomic, copy) NSString * name;
///** 咨询电话 */
//@property (nonatomic, copy) <# 类型 #> * <# 类型名称 #>;
/** 车牌号 */
@property (nonatomic, copy) NSString * plateNo;
/** 情况说明 */
@property (nonatomic, copy) NSString * remark;
/** 处理状态 */
@property (nonatomic, copy) NSString * status;
/** 案件类型 */
@property (nonatomic, copy) NSString * caseType;
/** 客户名称 */
@property (nonatomic, copy) NSString * customerName;
/** url1 */
@property (nonatomic, copy) NSString * url1;
/** url2 */
@property (nonatomic, copy) NSString * url2;
/** url3 */
@property (nonatomic, copy) NSString * url3;
/** url4 */
@property (nonatomic, copy) NSString * url4;
/** url5 */
@property (nonatomic, copy) NSString * url5;
/** url6 */
@property (nonatomic, copy) NSString * url6;
/** 司机证件照1 */
@property (nonatomic, copy) NSString * driverPapersUrl1;
/** 司机证件照2 */
@property (nonatomic, copy) NSString * driverPapersUrl2;
/** 司机证件照3 */
@property (nonatomic, copy) NSString * driverPapersUrl3;
/** 司机证件照4 */
@property (nonatomic, copy) NSString * driverPapersUrl4;
/** 被保人身份证照1（正反面） */
@property (nonatomic, copy) NSString * recognizeeIdcard1;
/** 被保人身份证照2（正反面） */
@property (nonatomic, copy) NSString * recognizeeIdcard2;
@end
