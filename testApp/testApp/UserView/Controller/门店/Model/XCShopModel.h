//
//  XCShopModel.h
//  testApp
//
//  Created by Melody on 2018/4/12.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
@interface XCShopModel : NSObject
/** 门店名称 */
@property (nonatomic, copy) NSString * name;
/** 联系方式（门店电话） */
@property (nonatomic, copy) NSString * tel;
/** 负责人名称 */
@property (nonatomic, copy) NSString * corporateName;
/** 负责人手机号 */
@property (nonatomic, copy) NSString * corporateCellphone;
/** 业务员提成佣金比例 */
@property (nonatomic, copy) NSNumber * salesmanCommission;
/** 业务经理佣金比例 */
@property (nonatomic, copy) NSNumber * managerCommission;
/** 所属城市 */
@property (nonatomic, copy) NSString * city;
/** 所在地区 */
@property (nonatomic, copy) NSString * area;
/** 门店审核状态 */
@property (nonatomic, copy) NSString * storeStatus;
/** 拒绝原因 */
@property (nonatomic, copy) NSString * repulseRemark;
/** 营业执照图片URLStr */
@property (nonatomic, copy) NSString * licenseUrl;
/** 门店图片1URL */
@property (nonatomic, copy) NSString * url1;
/** 门店图片2URL */
@property (nonatomic, copy) NSString * url2;
/** 门店图片3URL */
@property (nonatomic, copy) NSString * url3;
/** 门店图片4URL */
@property (nonatomic, copy) NSString * url4;
/** 标签1 */
@property (nonatomic, copy) NSString * label1;
/** 标签2 */
@property (nonatomic, copy) NSString * label2;
/** 标签3 */
@property (nonatomic, copy) NSString * label3;
/** 标签4 */
@property (nonatomic, copy) NSString * label4;
/** 标签5 */
@property (nonatomic, copy) NSString * label5;

//提交审核相关
/** 门店id long*/
@property (nonatomic, copy) NSNumber * storeID;
/** 地址 */
@property (nonatomic, copy) NSString * address;
/** 经度 */
@property (nonatomic, copy) NSString * longitude;
/** 纬度 */
@property (nonatomic, copy) NSString * latitude;
/** 门店类型 */
@property (nonatomic, copy) NSString * type;

- (NSDictionary *)getUpdateStoreDictionary;

@end
