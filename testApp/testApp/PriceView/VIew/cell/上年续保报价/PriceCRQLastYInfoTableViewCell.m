//
//  PriceCRQLastYInfoTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCRQLastYInfoTableViewCell.h"

@interface PriceCRQLastYInfoTableViewCell ()
@property (nonatomic, strong) UILabel *labelInfo;
@end
@implementation PriceCRQLastYInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.labelInfo = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelInfo];
        self.labelNum = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelNum];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6);
    self.labelName.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    
    self.labelNum.frame = CGRectMake(200 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, SCREEN_WIDTH - 230 * ViewRateBaseOnIP6, 26 * ViewRateBaseOnIP6);
    self.labelNum.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    self.labelNum.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelNum.textAlignment = NSTextAlignmentRight;
    
    
    self.labelInfo.frame = CGRectMake(210 * ViewRateBaseOnIP6, 25 * ViewRateBaseOnIP6, 160 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6);
    self.labelInfo.backgroundColor = [UIColor colorWithHexString:@"#edf3f7"];
    self.labelInfo.textAlignment = NSTextAlignmentCenter;
    self.labelInfo.textColor = [UIColor colorWithHexString:@"#6899e8"];
    self.labelInfo.font = [UIFont systemFontOfSize:24 * ViewRateBaseOnIP6];
    self.labelInfo.text = @"不计免赔";
}

- (void)setCellMianPei:(BOOL)isMianPei{
    self.labelInfo.hidden = !isMianPei;
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
