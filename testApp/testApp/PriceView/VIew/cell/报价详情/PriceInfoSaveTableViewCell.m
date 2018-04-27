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
@property (nonatomic, strong) UIView *viewBase;
@end
@implementation PriceInfoSaveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        self.buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        self.viewBase = [[UIView alloc] init];
        [self.contentView addSubview:self.viewBase];
        [self.viewBase addSubview:self.buttonSave];
        [self.viewBase addSubview:self.buttonSubmit];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.buttonSave addTarget:self action:@selector(savePriveInfo:) forControlEvents:UIControlEventTouchDown];
    
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

- (void)setCellState:(BOOL)isSave{
    if (isSave) {
        self.viewBase.frame = CGRectMake(0, 0, SCREEN_WIDTH, 252 * ViewRateBaseOnIP6);
        self.viewBase.backgroundColor = [UIColor clearColor];
        self.buttonSubmit.frame = CGRectMake(0, 154 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
        self.buttonSave.hidden = YES;
    } else {
        self.viewBase.frame = CGRectMake(0 , 154 * ViewRateBaseOnIP6, SCREEN_WIDTH, 98 * ViewRateBaseOnIP6);
        self.viewBase.backgroundColor = [UIColor whiteColor];
        
        self.buttonSave.hidden = NO;
        self.buttonSave.frame = CGRectMake(55 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6);
        self.buttonSubmit.frame = CGRectMake(395 * ViewRateBaseOnIP6, 9 * ViewRateBaseOnIP6, 300 * ViewRateBaseOnIP6, 80 * ViewRateBaseOnIP6);
        self.buttonSave.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        self.buttonSave.layer.masksToBounds = YES;
        self.buttonSave.backgroundColor = [UIColor whiteColor];
        self.buttonSave.layer.borderColor = [UIColor colorWithHexString:@"#004da2"].CGColor;
        self.buttonSave.layer.borderWidth = 1 * ViewRateBaseOnIP6;
        [self.buttonSave setTitleColor:[UIColor colorWithHexString:@"#004da2"] forState:UIControlStateNormal];
        [self.buttonSave setTitle:@"保存" forState:UIControlStateNormal];
        
        self.buttonSubmit.layer.cornerRadius = 10 * ViewRateBaseOnIP6;
        self.buttonSubmit.layer.masksToBounds = YES;
        
    }
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
