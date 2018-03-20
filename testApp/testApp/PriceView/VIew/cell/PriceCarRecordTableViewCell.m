//
//  PriceCarRecordTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCarRecordTableViewCell.h"

@interface PriceCarRecordTableViewCell ()
@property (nonatomic, strong) UIImageView *imageViewLeft;
@end

@implementation PriceCarRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.labelTime = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTime];
        
        self.labelNum = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelNum];
        
        self.imageViewLeft = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageViewLeft];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelName.frame = CGRectMake(29 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 28 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:28 * ViewRateBaseOnIP6];
    
    
    self.labelTime.frame = CGRectMake(29 * ViewRateBaseOnIP6, 74 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 17 * ViewRateBaseOnIP6);
    self.labelTime.textColor = [UIColor colorWithHexString:@"#a5a5a5"];
    self.labelTime.font = [UIFont systemFontOfSize:17 * ViewRateBaseOnIP6];
    
    self.labelNum.frame = CGRectMake(200 * ViewRateBaseOnIP6, 49 * ViewRateBaseOnIP6, SCREEN_WIDTH - 267 * ViewRateBaseOnIP6, 23 * ViewRateBaseOnIP6);
    self.labelNum.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelNum.font = [UIFont systemFontOfSize:23 * ViewRateBaseOnIP6];
    self.labelNum.textAlignment = NSTextAlignmentRight;
    
    self.imageViewLeft.frame = CGRectMake(700 * ViewRateBaseOnIP6, 42 * ViewRateBaseOnIP6, 20 * ViewRateBaseOnIP6, 36 * ViewRateBaseOnIP6);;
    self.imageViewLeft.image = [UIImage imageNamed:@"右"];
    
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
