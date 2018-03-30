//
//  XCMyCommissionListCell.m
//  testApp
//
//  Created by Melody on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCMyCommissionListCell.h"

@interface XCMyCommissionListCell ()

@end

@implementation XCMyCommissionListCell

#pragma mark - Init Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
        [self configSubVies];
    }
    return self;
}

- (void)configSubVies
{
    
}
#pragma mark - Action Method

#pragma mark - Delegates & Notifications

#pragma mark - Privacy Method

#pragma mark - Setter&Getter

@end
