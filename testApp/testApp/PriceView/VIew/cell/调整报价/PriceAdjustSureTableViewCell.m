//
//  PriceAdjustSureTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceAdjustSureTableViewCell.h"
@interface PriceAdjustSureTableViewCell()
@property (nonatomic, strong) UIButton *buttonSure;
@end;
@implementation PriceAdjustSureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.buttonSure = [[UIButton alloc] init];
        [self.contentView addSubview:self.buttonSure];
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.buttonSure.frame = CGRectMake(30 * ViewRateBaseOnIP6, 60 *ViewRateBaseOnIP6, 690 * ViewRateBaseOnIP6, 88 * ViewRateBaseOnIP6);
    [self.buttonSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSure setBackgroundColor:[UIColor colorWithHexString:@"#004da2"]];
    self.buttonSure.titleLabel.font = [UIFont systemFontOfSize:34 * ViewRateBaseOnIP6];
    [self.buttonSure setTitle:@"确认" forState:UIControlStateNormal];
    self.buttonSure.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
    self.buttonSure.layer.masksToBounds = YES;
    [self.buttonSure addTarget:self action:@selector(toucheSureButton:) forControlEvents:UIControlEventTouchDown];
}

- (void)toucheSureButton:(UIButton *)button{
    [self.delegate confirmAdjustmentPrice];
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
