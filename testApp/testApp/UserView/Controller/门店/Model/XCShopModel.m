//
//  XCShopModel.m
//  testApp
//
//  Created by Melody on 2018/4/12.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopModel.h"

@implementation XCShopModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"storeID" : @"id",
             };
}

- (NSDictionary *)getUpdateStoreDictionary
{
    NSMutableDictionary *updateStoreInfo = [[NSMutableDictionary alloc] init];
    
    if (!isUsable(self.storeID, [NSNumber class])) {
        return nil;
    }
    [updateStoreInfo setValue:self.storeID forKey:@"id"];
    if (isUsableNSString(self.tel, @"")) {
        [updateStoreInfo setValue:self.tel forKey:@"tel"];
    }
    else if (isUsableNSString(self.corporateName, @"")) {
        [updateStoreInfo setValue:self.corporateName forKey:@"corporateName"];
    }
    else if (isUsableNSString(self.corporateCellphone, @"")) {
        [updateStoreInfo setValue:self.corporateCellphone forKey:@"corporateCellphone"];
    }
    else if (isUsableNSString(self.address, @"")) {
        [updateStoreInfo setValue:self.address forKey:@"address"];
    }
    else if (isUsableNSString(self.longitude, @"")) {
        [updateStoreInfo setValue:self.longitude forKey:@"longitude"];
    }
    else if (isUsableNSString(self.latitude, @"")) {
        [updateStoreInfo setValue:self.latitude forKey:@"latitude"];
    }
    else if (isUsableNSString(self.type, @"")) {
        [updateStoreInfo setValue:self.type forKey:@"type"];
    }
    else if (isUsableNSString(self.area, @"")) {
        [updateStoreInfo setValue:self.area forKey:@"area"];
    }
    else if (isUsable(self.salesmanCommission, [NSNumber class])) {
        [updateStoreInfo setValue:self.salesmanCommission forKey:@"salesmanCommission"];
    }
    else if (isUsable(self.managerCommission, [NSNumber class])) {
        [updateStoreInfo setValue:self.managerCommission forKey:@"managerCommission"];
    }
    else if (isUsableNSString(self.licenseUrl, @"")) {
        [updateStoreInfo setValue:self.licenseUrl forKey:@"licenseUrl"];
    }
    else if (isUsableNSString(self.url2, @"")) {
        [updateStoreInfo setValue:self.url2 forKey:@"url2"];
    }
    else if (isUsableNSString(self.url3, @"")) {
        [updateStoreInfo setValue:self.url3 forKey:@"url3"];
    }
    else if (isUsableNSString(self.url4, @"")) {
        [updateStoreInfo setValue:self.url4 forKey:@"url4"];
    }
    else if (isUsableNSString(self.label1, @"")) {
        [updateStoreInfo setValue:self.label1 forKey:@"label1"];
    }
    else if (isUsableNSString(self.label2, @"")) {
        [updateStoreInfo setValue:self.label2 forKey:@"label2"];
    }
    else if (isUsableNSString(self.label3, @"")) {
        [updateStoreInfo setValue:self.label3 forKey:@"label3"];
    }
    else if (isUsableNSString(self.label4, @"")) {
        [updateStoreInfo setValue:self.label4 forKey:@"label4"];
    }
    else if (isUsableNSString(self.label5, @"")) {
        [updateStoreInfo setValue:self.label5 forKey:@"label5"];
    }
    return updateStoreInfo;
}



- (NSArray *)getAllPropertyNames{
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    return allNames;
}
@end
