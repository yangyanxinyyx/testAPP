//
//  XCUserListModel.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUserListModel : NSObject

@property (nonatomic, strong) NSString * title ;

@property (nonatomic, strong) NSString * iconPath ;

@property (nonatomic, strong) NSString * urlString ;

- (instancetype)initWithItemInfo:(NSDictionary*)itemInfo;

@end
