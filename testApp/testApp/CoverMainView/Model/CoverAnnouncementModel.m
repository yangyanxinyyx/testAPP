//
//  CoverAnnouncementModel.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/5.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "CoverAnnouncementModel.h"

@implementation CoverAnnouncementModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if (key) {
        if([key isEqualToString:@"id"]) {
            _announcementId = value;
        }
    }

}

@end
