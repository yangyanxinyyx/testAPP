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
        self.line = [[UIView alloc] init];
        _line.backgroundColor = COLOR_RGB_255(242, 242, 242);
        [self.contentView addSubview:_line];

        self.imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageV];

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

        self.imageArrow = [[UIImageView alloc] init];
        _imageArrow.backgroundColor = [UIColor redColor];
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
    _imageV.layer.cornerRadius = 40;
    _imageV.layer.masksToBounds = YES;

    _label1.frame = CGRectMake(109, 25 + 10, 85, 15);

    _label2.frame = CGRectMake(107, 54 + 10, 93, 12);

    _label3.frame = CGRectMake(107, 75 + 10, 93, 12);

    _label4.frame = CGRectMake(SCREEN_WIDTH - 24 - 38, 50 + 10, 26, 12);

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
