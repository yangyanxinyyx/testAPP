//
//  XCShopInputTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopInputTableViewCell.h"

@implementation XCShopInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        self.textFieldInput = [[UITextField alloc] init];
        [self.contentView addSubview:self.textFieldInput];
        
    }
    return self;
}


- (void)layoutSubviews{
   [super layoutSubviews];
}

- (void)setLabelNameText:(NSString *)labelNameText textFieldPlaceholder:(NSString *)textFieldPlaceholder{
    self.labelName.text = labelNameText;
    self.textFieldInput.placeholder = textFieldPlaceholder;
    self.labelName.font = [UIFont systemFontOfSize:27 * ViewRateBaseOnIP6];
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.frame = CGRectMake(30 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 200, 27 * ViewRateBaseOnIP6);
    [self.labelName sizeToFit];
    
    
    
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
