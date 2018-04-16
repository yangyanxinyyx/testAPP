//
//  GetCarViewController.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "BaseViewController1.h"

@protocol GetCarViewControllerDelegate <NSObject>

- (void)reloadGetCarListWithPlateNO;

@end

@interface GetCarViewController : BaseViewController1

@property (nonatomic,weak)id<GetCarViewControllerDelegate>delegate;

@property (nonatomic,strong) NSNumber *orderID;
@property (nonatomic,assign) BOOL isFix;

@end
