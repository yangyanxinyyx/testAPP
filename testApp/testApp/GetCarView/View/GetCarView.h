//
//  GetCarView.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCarDetailModel.h"

@interface GetCarView : UIView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame model:(GetCarDetailModel *)model isFix:(BOOL)isFix;

@end
