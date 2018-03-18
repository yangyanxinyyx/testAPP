//
//  PriceInfoSaveTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceInfoSaveTableViewCell.h"

@interface PriceInfoSaveTableViewCell()
@property (nonatomic, strong) UIButton *buttonSave;
@property (nonatomic, strong) UIButton *buttonSubmit;
@end
@implementation PriceInfoSaveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        self.buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.buttonSave];
        [self.contentView addSubview:self.buttonSubmit];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.buttonSave.frame = CGRectMake(540 * ViewRateBaseOnIP6, 30 * ViewRateBaseOnIP6, 180 * ViewRateBaseOnIP6, 60 * ViewRateBaseOnIP6);
    self.buttonSave.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
    [self.buttonSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSave setTitle:@"保存" forState:UIControlStateNormal];
    self.buttonSave.layer.cornerRadius = 5 * ViewRateBaseOnIP6;
    self.buttonSave.layer.masksToBounds = YES;
    [self.buttonSave addTarget:self action:@selector(savePriveInfo:) forControlEvents:UIControlEventTouchDown];
    

    self.buttonSubmit.frame = CGRectMake(0, 154 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
    self.buttonSubmit.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
    [self.buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSubmit setTitle:@"提交核保" forState:UIControlStateNormal];
    [self.buttonSubmit addTarget:self action:@selector(submitNuclearIns:) forControlEvents:UIControlEventTouchDown];
}

- (void)savePriveInfo:(UIButton *)button{
    [self.delegate savePriveInfoDelegate];
}

- (void)submitNuclearIns:(UIButton *)button{
    [self.delegate submitNuclearInsDelegate];
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
