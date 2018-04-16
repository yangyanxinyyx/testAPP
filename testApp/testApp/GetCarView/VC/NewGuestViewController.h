//
//  NewGuestViewController.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"

@interface NewGuestViewController : BaseViewController1

@property (nonatomic,strong) NSArray *serviceArray;
- (instancetype)initWithIsOrder:(BOOL)isOrder;

@end
