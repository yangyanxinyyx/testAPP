//
//  PriceCustomerInformEntrySubmitTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceCustomerInformEntrySubmitTableViewCell.h"

@interface PriceCustomerInformEntrySubmitTableViewCell ()
@property (nonatomic, strong) UILabel *labelSubmit;
@end

@implementation PriceCustomerInformEntrySubmitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelSubmit = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelSubmit];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.labelSubmit.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
    self.labelSubmit.backgroundColor = [UIColor colorWithHexString:@"#004da2"];
    self.labelSubmit.font = [UIFont systemFontOfSize:36 * ViewRateBaseOnIP6];
    self.labelSubmit.textColor = [UIColor whiteColor];
    self.labelSubmit.textAlignment = NSTextAlignmentCenter;
    self.labelSubmit.text = @"确认提交";
    
    
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
