//
//  SelectStateView.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "priceModel.h"
@protocol SelectStateViewDelegate <NSObject>
- (void)didSelectCell:(NSString *)data count:(NSInteger)count priceCount:(NSInteger)priceCount;
@end
@interface SelectStateView : UIView

@property (nonatomic,weak)id<SelectStateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame datArray:(NSArray *)dataArray;
// =================== modify by Liangyz
- (instancetype)initWithFrame:(CGRect)frame datArray:(NSArray *)dataArray indexName:(NSString *)indexName WithCompletionHandler:(void (^)(NSString *))complete;
// ===================
- (instancetype)initWithFrame:(CGRect)frame datArray:(NSArray *)dataArray WithCompletionHandler:(void (^)(NSString *))complete;
@end
