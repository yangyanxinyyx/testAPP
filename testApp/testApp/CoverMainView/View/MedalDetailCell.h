//
//  MedalDetailCell.h
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedalDetailCell : UITableViewCell

@property (nonatomic,assign) BOOL isOpen;


@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UIView *line2;

@property (nonatomic,strong) UIImageView *imageV;

@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@property (nonatomic,strong) UILabel *label5;
@property (nonatomic,strong) UILabel *label6;
@property (nonatomic,strong) UILabel *label7;

@property (nonatomic,strong) UIImageView *imageArrow;
@end
