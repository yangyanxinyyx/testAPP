//
//  PriceUnderwritingImportTableViewCell.m
//  testApp
//
//  Created by 严玉鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "PriceUnderwritingImportTableViewCell.h"
@interface PriceUnderwritingImportTableViewCell()<UITextViewDelegate>

@end
@implementation PriceUnderwritingImportTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
        self.labelName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelName];
        
        self.textView = [[UITextView alloc] init];
        [self.contentView addSubview:self.textView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.labelName.frame  = CGRectMake(30 * ViewRateBaseOnIP6, 27 * ViewRateBaseOnIP6, 100 * ViewRateBaseOnIP6, 26 * ViewRateBaseOnIP6);
    self.labelName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.labelName.font = [UIFont systemFontOfSize:26 * ViewRateBaseOnIP6];
    self.labelName.text = @"备注";
    
    self.textView.frame = CGRectMake(30 * ViewRateBaseOnIP6, 73 * ViewRateBaseOnIP6, 690 * ViewRateBaseOnIP6, 140 *ViewRateBaseOnIP6);
    self.textView.font = [UIFont systemFontOfSize:24 * ViewRateBaseOnIP6];
    self.textView.delegate = self;
    self.textView.text = @"请输入...";
    self.textView.textColor = [UIColor colorWithHexString:@"#838383"];
    self.textView.layer.borderWidth = 1 * ViewRateBaseOnIP6;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    self.textView.layer.cornerRadius = 20 * ViewRateBaseOnIP6;
    self.textView.layer.masksToBounds = YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewENDWithTextView:)]) {
        [self.delegate textViewENDWithTextView:textView];
    }
    if (textView.text.length < 1) {
        textView.text = @"请输入...";
        textView.textColor = [UIColor colorWithHexString:@"#838383"];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewBeginWithTextView:)]) {
        [self.delegate textViewBeginWithTextView:textView];
    }
    if ([textView.text isEqualToString:@"请输入..."]) {
        textView.text = @"";
        textView.textColor = [UIColor colorWithHexString:@"#444444"];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewChangeWithTextView:)]) {
    [self.delegate textViewChangeWithTextView:textView];
    }
}

- (void)InfoNotificationAction:(NSNotification *)notification{
    [self.textView resignFirstResponder];
    
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
