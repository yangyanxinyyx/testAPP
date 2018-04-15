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

@property (nonatomic,strong) UIView *line0;


@end

@implementation GetCarListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.carNumberLabel = [[UILabel alloc] init];
        _carNumberLabel.font = [UIFont systemFontOfSize:13];
        _carNumberLabel.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_carNumberLabel];

        self.label1 = [[UILabel alloc] init];
        _label1.text = @"车主:";
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label1];

        self.label2 = [[UILabel alloc] init];
        _label2.text = @"项目:";
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label2];

        self.label3 = [[UILabel alloc] init];
        _label3.text = @"接车时间:";
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
        _line1.backgroundColor = COLOR_RGB_255(242, 242, 242);

        _line0 = [[UIView alloc] init];
        [self.contentView addSubview:_line0];
        _line0.backgroundColor = COLOR_RGB_255(242, 242, 242);

        _getCarBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_getCarBtn];
        [_getCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_getCarBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _getCarBtn.layer.cornerRadius = 3;
        _getCarBtn.layer.masksToBounds = YES;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _line0.frame = CGRectMake(0, 0, SCREEN_WIDTH, 5);

    self.carNumberLabel.frame = CGRectMake(16, 5, 100, 40);

    _line1.frame = CGRectMake(0, 40, SCREEN_WIDTH, 1);

    self.label1.frame = CGRectMake(16, CGRectGetMaxY(_line1.frame) + 15, 40, 12);

    self.ownerLabel.frame = CGRectMake(CGRectGetMaxX(self.label1.frame), CGRectGetMaxY(_line1.frame) + 15, 100, 12);

    self.label2.frame = CGRectMake(16, CGRectGetMaxY(_label1.frame) + 10, 40, 12);

    self.itemsLabel.frame = CGRectMake(CGRectGetMaxX(self.label2.frame), CGRectGetMaxY(_label1.frame) + 10, 100, 12);

    self.label3.frame = CGRectMake(16, CGRectGetMaxY(_label2.frame) + 10, 57, 12);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.label3.frame)+10, CGRectGetMaxY(_label2.frame) + 10, 150, 12);

    self.getCarBtn.frame = CGRectMake(SCREEN_WIDTH - 115, CGRectGetMaxY(_line1.frame) + 26, 80, 30);
}

- (void)setGetCarBtnType:(GetCarBtnType)getCarBtnType
{
    _getCarBtnType = getCarBtnType;

    if (_getCarBtnType == GetCarBtnTypeGet) {
        [self.getCarBtn setTitle:@"接车" forState:UIControlStateNormal];
        self.getCarBtn.backgroundColor = COLOR_RGB_255(0, 72, 162);
    }else if (_getCarBtnType == GetCarBtnTypePay){
        [self.getCarBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.getCarBtn.backgroundColor = COLOR_RGB_255(57, 174, 54);
    }else{
        [self.getCarBtn setTitle:@"交易完成" forState:UIControlStateNormal];
        self.getCarBtn.backgroundColor = COLOR_RGB_255(182, 182, 182);
    }

}

- (void)pressBtn:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressGetCarBtn:)]) {
        [self.delegate pressGetCarBtn:self];
    }
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
