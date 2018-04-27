//
//  MedalDetailCell.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "MedalDetailCell.h"

@interface MedalDetailCell()



@end

@implementation MedalDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.line = [[UIView alloc] init];
        _line.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self.contentView addSubview:_line];

        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];

        _label0 = [[UILabel alloc] init];
        _label0.font = [UIFont systemFontOfSize:12];
        _label0.textColor = COLOR_RGB_255(51, 51, 51);
        _label0.textAlignment = NSTextAlignmentCenter;
        [self.imageV addSubview:_label0];

        _label1 = [[UILabel alloc] init];
        _label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_label1];

        _label2 = [[UILabel alloc] init];
        _label2.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_label2];

        _label3 = [[UILabel alloc] init];
        _label3.font = [UIFont systemFontOfSize:12];
        _label3.textColor = COLOR_RGB_255(254, 173, 53);
        [self.contentView addSubview:_label3];

        _label4 = [[UILabel alloc] init];
        _label4.font = [UIFont systemFontOfSize:12];
        _label4.text = @"详情";
        [self.contentView addSubview:_label4];

        _label5 = [[UILabel alloc] init];
        _label5.font = [UIFont systemFontOfSize:11];
        _label5.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label5];

        _label6 = [[UILabel alloc] init];
        _label6.font = [UIFont systemFontOfSize:11];
        _label6.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label6];

        _label7 = [[UILabel alloc] init];
        _label7.font = [UIFont systemFontOfSize:11];
        _label7.textColor = COLOR_RGB_255(131, 131, 131);
        [self.contentView addSubview:_label7];

        self.imageArrow = [[UIImageView alloc] init];
        _imageArrow.image = [UIImage imageNamed:@"down.png"];
        [self.contentView addSubview:_imageArrow];

        self.line2 = [[UIView alloc] init];
        _line2.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self.contentView addSubview:_line2];
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];



    _line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);

    _imageV.frame = CGRectMake(15, 25, 80, 80);
    _label0.frame = CGRectMake(0, 60, 80, 12);

    _label1.frame = CGRectMake(109, 25 + 10, 85, 15);

    _label2.frame = CGRectMake(107, 54 + 10, 93, 12);

    _label3.frame = CGRectMake(107, 75 + 10, 93, 12);

    _label4.frame = CGRectMake(SCREEN_WIDTH - 24 - 38, 50 + 10, 26, 12);

    _label5.frame = CGRectMake(15, 126 + 10, 180, 11);

    _label6.frame = CGRectMake(15, 147 + 10, 180, 11);

    _label7.frame = CGRectMake(15, 168 + 10, 180, 11);

    _imageArrow.frame = CGRectMake(SCREEN_WIDTH - 15 - 14, 53 + 10, 14, 7);

    _line2.frame = CGRectMake(0, 110 + 10, SCREEN_WIDTH, 1);
}

- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    if (isOpen) {
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.3f];
        self.imageArrow.transform = CGAffineTransformRotate( self.imageArrow.transform, -3.141593 );
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.3f];
        self.imageArrow.transform = CGAffineTransformRotate( self.imageArrow.transform, 3.141593 );
        [UIView commitAnimations];
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
