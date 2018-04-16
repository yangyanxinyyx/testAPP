//
//  MoneyInputVIew.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/9.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoneyInputVIewDelegate <NSObject>

-(void)reloadGetCarListWithPlateNO;

@end

@interface MoneyInputVIew : UIView<UITextFieldDelegate>

@property (nonatomic,weak) id<MoneyInputVIewDelegate>delegate;

@property (nonatomic,strong) NSNumber *orderId;

@end
