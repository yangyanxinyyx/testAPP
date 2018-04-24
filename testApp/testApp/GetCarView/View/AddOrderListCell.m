//
//  AddOrderListCell.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/4/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "AddOrderListCell.h"

@implementation AddOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.line1 = [[UIView alloc] init];
        _line1.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self.contentView addSubview:_line1];

        self.line2 = [[UIView alloc] init];
        _line2.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self.contentView addSubview:_line2];

        self.selectImageV = [[UIImageView alloc] init];
        _selectImageV.image = [UIImage imageNamed:@"未选中.png"];
        [self.contentView addSubview:_selectImageV];

        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = COLOR_RGB_255(68, 68, 68);
        [self.contentView addSubview:_titleLabel];

        self.ownerLabel = [[UILabel alloc] init];
        _ownerLabel.font = [UIFont systemFontOfSize:13];
        _ownerLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_ownerLabel];

        self.carLabel = [[UILabel alloc] init];
        _carLabel.font = [UIFont systemFontOfSize:13];
        _carLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_carLabel];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _line1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);

    _line2.frame = CGRectMake(0, 40, SCREEN_WIDTH, 1);

    _selectImageV.frame = CGRectMake(SCREEN_WIDTH - 35, 20, 20, 20);

    _titleLabel.frame = CGRectMake(15, 23, 150, 14);

    _ownerLabel.frame = CGRectMake(15, 55, 150, 13);

    _carLabel.frame = CGRectMake(15, 78, 150, 13);


}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    if (isSelect) {
        _selectImageV.image = [UIImage imageNamed:@"选中.png"];
    }else{
        _selectImageV.image = [UIImage imageNamed:@"未选中.png"];

    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
}

- (void)setOwn:(NSString *)own
{
    _own = own;
    _ownerLabel.text = [NSString stringWithFormat:@"车主:%@",own];
}

- (void)setCar:(NSString *)car
{
    _car = car;
    _carLabel.text = [NSString stringWithFormat:@"品牌:%@",car];
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
