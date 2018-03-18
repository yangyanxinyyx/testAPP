//
//  XCUserListModel.m
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserListModel.h"

@implementation XCUserListModel

- (instancetype)initWithItemInfo:(NSDictionary*)itemInfo
{
    if (self = [super init]) {
        
        NSString *title = [itemInfo objectForKey:@"title"];
        NSString *iconName = [itemInfo objectForKey:@"iconName"];
        NSString *urlString = [itemInfo objectForKey:@"url"];
        if (title) {
            _title = title;
        }
        if (iconName) {
//           NSString *filePath = [[NSBundle mainBundle] pathForResource:iconName ofType:@"png"];
            _iconPath = iconName;
        }
        if (urlString) {
            _urlString = urlString;
        }
    }
    return self;
}


@end
