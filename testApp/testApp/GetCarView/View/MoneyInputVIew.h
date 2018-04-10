//
//  MoneyInputVIew.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/9.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoneyInputVIewDelegate <NSObject>

-(void)MoneyDidInputWithInsurance:(NSString *)insurance selfMoney:(NSString *)selfMoney;

@end

@interface MoneyInputVIew : UIView<UITextFieldDelegate>

@property (nonatomic,weak) id<MoneyInputVIewDelegate>delefate;

@end
