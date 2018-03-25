//
//  MyMedalView.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/24.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyMedalViewDelegate <NSObject>

- (void)MyMedalViewDidSelectToDetail:(NSString *)title;

@end;

@interface MyMedalView : UIView
@property (nonatomic,weak) id<MyMedalViewDelegate>delegate;

- (instancetype)initWithInfo:(NSArray *)info title:(NSString *)title;
@end
