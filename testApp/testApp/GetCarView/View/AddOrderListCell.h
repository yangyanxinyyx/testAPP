//
//  AddOrderListCell.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddOrderListCell : UITableViewCell

@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;

@property (nonatomic,strong) UIImageView *selectImageV;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *ownerLabel;
@property (nonatomic,strong) UILabel *carLabel;

@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *own;
@property (nonatomic,strong) NSString *car;


@end
