//
//  GetCarListCell.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "GetCarListCell.h"

@interface GetCarListCell()

@property (nonatomic,strong) UILabel *label1;

@property (nonatomic,strong) UILabel *label2;

@property (nonatomic,strong) UILabel *label3;

@property (nonatomic,strong) UIView *line1;

@property (nonatomic,strong) UIView *line2;


@end

@implementation GetCarListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.carNumberLabel = [[UILabel alloc] init];
        _carNumberLabel.font = [UIFont systemFontOfSize:13];
        _carNumberLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_carNumberLabel];

        self.label1 = [[UILabel alloc] init];
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label1];

        self.label2 = [[UILabel alloc] init];
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label2];

        self.label3 = [[UILabel alloc] init];
        _label3.font = [UIFont systemFontOfSize:13];
        _label3.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label3];

        self.ownerLabel = [[UILabel alloc] init];
        _ownerLabel.font = [UIFont systemFontOfSize:13];
        _ownerLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_ownerLabel];

        self.itemsLabel = [[UILabel alloc] init];
        _itemsLabel.font = [UIFont systemFontOfSize:13];
        _itemsLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_itemsLabel];

        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_timeLabel];

        _line1 = [[UIView alloc] init];
        [self.contentView addSubview:_line1];

        _line2 = [[UIView alloc] init];
        [self.contentView addSubview:_line2];

        
        

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
