//
//  XCCheckoutBaseFooterView.m
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCCheckoutBaseFooterView.h"
@interface XCCheckoutBaseFooterView ()
{
    UILabel *_textLabel;
}
@end

@implementation XCCheckoutBaseFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
         _textLabel = [[UILabel alloc] init];
        [_textLabel setText:@"到底啦~"];
        [self.contentView addSubview:_textLabel];
        [self setBackgroundColor:COLOR_RGB_255(242, 242, 242)];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_textLabel sizeToFit];
    [_textLabel setCenter:self.contentView.center];
}

@end
