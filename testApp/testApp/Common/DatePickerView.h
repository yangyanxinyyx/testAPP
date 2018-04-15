//
//  DatePickerView.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/13.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView

@property (nonatomic, copy) void (^block)(NSString *);

@end
