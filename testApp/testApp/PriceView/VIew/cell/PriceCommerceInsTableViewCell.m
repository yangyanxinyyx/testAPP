//
//  PriceCommerceInsTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/17.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCommerceInsTableViewCell.h"

@implementation PriceCommerceInsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelTag = [[UILabel alloc] init];
        self.labelInsure = [[UILabel alloc] init];
        self.labelAnnotate = [[UILabel alloc] init];
        self.labelNumber = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTag];
        [self.contentView addSubview:self.labelInsure];
        [self.contentView addSubview:self.labelAnnotate];
        [self.contentView addSubview:self.labelNumber];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelTag.frame = CGRectMake(30 *ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 200 * ViewRateBaseOnIP6, 27 *ViewRateBaseOnIP6);
    self.labelTag.backgroundColor = [UIColor clearColor];
    self.labelTag.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    self.labelTag.textAlignment = NSTextAlignmentLeft;
    
    self.labelInsure.frame = CGRectMake(209 * ViewRateBaseOnIP6, 24 * ViewRateBaseOnIP6, 140 * ViewRateBaseOnIP6, 40 * ViewRateBaseOnIP6);
    self.labelInsure.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:243.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
    self.labelInsure.textColor = [UIColor colorWithHexString:@"#6899e8"];
    self.labelInsure.font = [UIFont systemFontOfSize:22 * ViewRateBaseOnIP6];
    self.labelInsure.textAlignment = NSTextAlignmentCenter;
    
    
    self.labelAnnotate.frame = CGRectMake(449 * ViewRateBaseOnIP6, 34 * ViewRateBaseOnIP6, 47 * ViewRateBaseOnIP6, 23 * ViewRateBaseOnIP6);
    self.labelAnnotate.backgroundColor = [UIColor clearColor];
    self.labelAnnotate.textColor = [UIColor colorWithHexString:@"#a5a5a5"];
    self.labelAnnotate.textAlignment = NSTextAlignmentLeft;
    self.labelAnnotate.font = [UIFont systemFontOfSize:23 * ViewRateBaseOnIP6];
    
    
    self.labelNumber.frame = CGRectMake(200 * ViewRateBaseOnIP6, 32 * ViewRateBaseOnIP6, SCREEN_WIDTH - 230 * ViewRateBaseOnIP6, 22 * ViewRateBaseOnIP6);
    self.labelNumber.textAlignment = NSTextAlignmentRight;
    self.labelNumber.backgroundColor = [UIColor clearColor];
    self.labelNumber.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelNumber.font = [UIFont systemFontOfSize:22 * ViewRateBaseOnIP6];
    
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
