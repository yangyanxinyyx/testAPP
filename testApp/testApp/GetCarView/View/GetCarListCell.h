//
//  GetCarListCell.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetCarListCell;

typedef NS_ENUM(NSInteger, GetCarBtnType) {
    GetCarBtnTypeGet = 0,
    GetCarBtnTypePay,
    GetCarBtnTypeFinish,
};

@protocol GetCarListCellDelegate <NSObject>

- (void)pressGetCarBtn:(GetCarListCell *)cell;

@end

@interface GetCarListCell : UITableViewCell

@property (nonatomic,strong) UILabel *carNumberLabel;

@property (nonatomic,strong) UILabel *ownerLabel;

@property (nonatomic,strong) UILabel *itemsLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIButton *getCarBtn;

@property (nonatomic,assign) GetCarBtnType getCarBtnType;

@property (nonatomic,weak) id<GetCarListCellDelegate>delegate;
@end
