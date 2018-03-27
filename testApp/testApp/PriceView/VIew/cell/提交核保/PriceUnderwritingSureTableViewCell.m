//
//  ProceUnderwritingSureTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceUnderwritingSureTableViewCell.h"

@interface PriceUnderwritingSureTableViewCell()
@property (nonatomic, strong) UIButton *buttonSure;
@end

@implementation PriceUnderwritingSureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        self.buttonSure = [[UIButton alloc] init];
        [self.contentView addSubview:self.buttonSure];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.buttonSure.frame = CGRectMake(0, 60 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
    [self.buttonSure setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [self.buttonSure setTitle:@"确认提交" forState:UIControlStateNormal];
    self.buttonSure.titleLabel.font = [UIFont systemFontOfSize:36 * ViewRateBaseOnIP6];
    [self.buttonSure addTarget:self action:@selector(touchButtonSure:) forControlEvents:UIControlEventTouchDown];
    self.buttonSure.backgroundColor = [UIColor colorWithHexString:@"#004da2"];
}

- (void)touchButtonSure:(UIButton *)button{
    [self.delegate comfirmToSubmit];
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
