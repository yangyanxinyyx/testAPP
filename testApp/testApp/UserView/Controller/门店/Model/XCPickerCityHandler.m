//
//  XCPickerCityHandler.m
//  testApp
//
//  Created by Melody on 2018/5/1.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCPickerCityHandler.h"



@implementation XCPickerCityHandler

+(NSArray *)pickerCityWithIndexStr:(NSString *)provence
{
    
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *dateSource = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * tempArray = [NSMutableArray array];
    
    for (NSDictionary * tempDic in dateSource) {
        
        for (int i = 0; i < tempDic.allKeys.count; i ++) {
            [tempArray addObject:tempDic.allKeys[i]];
        }
        
    }
    //省
    NSArray *provinceArray =  [tempArray copy];
    NSInteger provinceIndex = 0;

    for (NSInteger p = 0; p < provinceArray.count; p++) {
        if ([provinceArray[p] isEqualToString:provence]) {
            provinceIndex = p;
            NSDictionary * tempDic = [dateSource[provinceIndex] objectForKey:provence];
            NSMutableArray * cityArray = [NSMutableArray array];
            for (NSDictionary * valueDic in tempDic.allValues) {
                for (int i = 0; i < valueDic.allKeys.count; i ++) {
                    [cityArray addObject:valueDic.allKeys[i]];
                }
            }
            return [cityArray copy];
        }
    }
    
    provinceIndex = 0;
    NSDictionary * tempDic = [dateSource[provinceIndex] objectForKey:provence];
    NSMutableArray * cityArray = [NSMutableArray array];
    for (NSDictionary * valueDic in tempDic.allValues) {
        for (int i = 0; i < valueDic.allKeys.count; i ++) {
            [cityArray addObject:valueDic.allKeys[i]];
        }
    }
    return [cityArray copy];
}

+(NSArray *)pickerCityWithIndexStr:(NSString *)provence cityStr:(NSString *)city
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *dateSource = [NSArray arrayWithContentsOfFile:path];
    NSInteger provinceIndex = 0;
    NSInteger cityIndex = 0;
    NSMutableArray * tempArray = [NSMutableArray array];
    for (NSDictionary * tempDic in dateSource) {
        for (int i = 0; i < tempDic.allKeys.count; i ++) {
            [tempArray addObject:tempDic.allKeys[i]];
        }
    }
    //省
    NSArray *provinceArray =  [tempArray copy];
    for (NSInteger p = 0; p < provinceArray.count; p++) {
        if ([provinceArray[p] isEqualToString:provence]) {
            provinceIndex = p;
            NSDictionary * tempDic = [dateSource[provinceIndex] objectForKey:provence];
            for (NSDictionary * valueDic in tempDic.allValues) {
                for (int i = 0; i < valueDic.allKeys.count; i ++) {
                    if ([valueDic.allKeys[i] isEqualToString:city]) {
                        if ([valueDic.allKeys[i] isEqualToString:city]) {
                            cityIndex = i;
                            NSArray *areaArr = [valueDic objectForKey:city];
                            return areaArr;
                        }
                    }
                }
            }
        }
    }
    
    return nil;
}

////获取plist区域数组
//- (NSArray *)getAreaNamesFromProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex
//{
//    
//    NSDictionary * tempDic = [self.dataSource[provinceIndex] objectForKey:self.provinceArray[provinceIndex]];
//    NSArray * array = [NSArray array];
//    
//    NSDictionary * dic = tempDic.allValues[cityIndex];
//    array = [dic objectForKey:self.cityArray[cityIndex]];
//    
//    return array;
//}
////获取plist城市数组
//- (NSArray *)getCityNamesFromProvinceIndex:(NSInteger)provinceIndex
//{
//    NSDictionary * tempDic = [self.dataSource[provinceIndex] objectForKey:self.provinceArray[provinceIndex]];
//    NSMutableArray * cityArray = [NSMutableArray array];
//    for (NSDictionary * valueDic in tempDic.allValues) {
//        
//        for (int i = 0; i < valueDic.allKeys.count; i ++) {
//            [cityArray addObject:valueDic.allKeys[i]];
//        }
//    }
//    return [cityArray copy];
//}
@end
