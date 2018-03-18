//
//  PriceInspectTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInspectTableViewCell.h"

@implementation PriceInspectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc]init];
        [self.contentView addSubview:self.labelName];
        self.buttoninspect = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.buttoninspect];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(31 * ViewRateBaseOnIP6, 44 * ViewRateBaseOnIP6, 250 * ViewRateBaseOnIP6, 31 * ViewRateBaseOnIP6);
    self.labelName.font = [UIFont systemFontOfSize:32 * ViewRateBaseOnIP6];
    self.labelName.backgroundColor = [UIColor clearColor];
    self.labelName.textColor = [UIColor colorWithHexString:@"#333333"];
    
    self.buttoninspect.frame = CGRectMake(607 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 111 * ViewRateBaseOnIP6, 60 * ViewRateBaseOnIP6);
    self.buttoninspect.backgroundColor = [UIColor clearColor];
    [self.buttoninspect setTitleColor:[UIColor colorWithHexString:@"#6899e8"] forState:UIControlStateNormal];
    self.buttoninspect.titleLabel.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    [self.buttoninspect setTitle:@"查看报价" forState:UIControlStateNormal];
    [self.buttoninspect addTarget:self action:@selector(inspectPrice:) forControlEvents:UIControlEventTouchDown];
    
    
}
- (void)inspectPrice:(UIButton *)button{
    [self.delegate inspectPriceDelegate];
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
