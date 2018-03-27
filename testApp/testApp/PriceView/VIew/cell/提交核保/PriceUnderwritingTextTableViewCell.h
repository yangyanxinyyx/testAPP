//
//  PriceUnderwritingTextTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceUnderwritingTextTableViewCellDelegate <NSObject>
- (void)textFieldBeginWithTextField:(UITextField *)textField;
- (void)textFieldENDWithTextField:(UITextField *)textField;

@end

@interface PriceUnderwritingTextTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UITextField *textFieldMoney;
@property (nonatomic, weak) id <PriceUnderwritingTextTableViewCellDelegate>delegate;
@end
