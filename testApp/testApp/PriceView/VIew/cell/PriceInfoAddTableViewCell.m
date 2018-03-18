//
//  PriceInfoAddTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInfoAddTableViewCell.h"

@interface PriceInfoAddTableViewCell()
@property (nonatomic, strong) UIImageView *imageViewAdd;
@end

@implementation PriceInfoAddTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageViewAdd = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewAdd];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewAdd.frame = CGRectMake(356 * ViewRateBaseOnIP6, 25 * ViewRateBaseOnIP6, 38 * ViewRateBaseOnIP6, 38 * ViewRateBaseOnIP6);
    self.imageViewAdd.image = [UIImage imageNamed:@""];
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
