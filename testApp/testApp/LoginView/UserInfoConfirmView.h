//
//  UserInfoComfirmVIew.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoComfirmVIewDelegate <NSObject>

- (void)didConfirmUserInfo;

@end

@interface UserInfoConfirmView : UIView

@property (nonatomic,weak) id<UserInfoComfirmVIewDelegate>delegate;

@end
