//
//  SelectSheetView.h
//  案列
//
//  Created by admin on 29/3/18.
//  Copyright © 2018年 Yanyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSheetView : UIView
@property (nonatomic, copy)void (^block)(NSInteger);
- (void)setDataWithDataArray:(NSArray<NSString*> *)dataArray;

@end
