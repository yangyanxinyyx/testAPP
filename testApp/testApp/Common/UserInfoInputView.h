//
//  UserInfoInputView.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/12.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputViewType) {
    InputViewTypeTextField = 0,
    InputViewTypeDate,
    InputViewTypeSelect,
    InputViewTypeLabel
};

@interface UserInfoInputView : UIView

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UILabel *textLabel;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title type:(InputViewType)type param:(id)param WithCompletionHandler:(void (^)(NSString *))complete;

@end
