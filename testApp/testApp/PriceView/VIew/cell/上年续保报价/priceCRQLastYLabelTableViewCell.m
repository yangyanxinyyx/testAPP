//
//  priceCRQLastYLabelTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "priceCRQLastYLabelTableViewCell.h"

@implementation priceCRQLastYLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.labelInfo = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelInfo];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 200, 30 * ViewRateBaseOnIP6);
    self.labelName.textAlignment = NSTextAlignmentLeft;
    self.labelName.font = [UIFont systemFontOfSize:30 * ViewRateBaseOnIP6];
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    
    
    self.labelInfo.frame = CGRectMake(200 * ViewRateBaseOnIP6, 29 * ViewRateBaseOnIP6, SCREEN_WIDTH - 230 * ViewRateBaseOnIP6, 29 * ViewRateBaseOnIP6);
    self.labelInfo.font = [UIFont systemFontOfSize:29 * ViewRateBaseOnIP6];
    self.labelInfo.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelInfo.textAlignment = NSTextAlignmentRight;
    
    
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
