//
//  GetCarImageCell.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarImageCell.h"

@implementation GetCarImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
