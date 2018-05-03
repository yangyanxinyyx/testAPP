//
//  GetCarView.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCarDetailModel.h"

@protocol GetCarViewDelegate <NSObject>

- (void)GetCarViewDidSelectImageIndex:(NSInteger)index source:(NSMutableArray *)source;

@end

@interface GetCarView : UIView<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,weak)id<GetCarViewDelegate>delegate;


- (instancetype)initWithFrame:(CGRect)frame model:(GetCarDetailModel *)model isFix:(BOOL)isFix orderCategory:(NSString*)orderCategory;


@end
