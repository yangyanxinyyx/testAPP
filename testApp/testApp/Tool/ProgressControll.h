//
//  BCProgressControll.h
//
//  Created by 杨焱鑫 on 16/10/20.
//  Copyright outPutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProgressControll : NSObject


+ (void)showToastWithText:(NSString *)text;

+ (void)showProgressNormal;

+ (void)onlyShowProgress;

+ (void)showProgressNormalWithOffsetY:(float)originY;

+ (void)showProgressWithText:(NSString *)text;

+ (void)dismissProgress;
@end
