//
//  PriceCustomerInformEntryTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/19.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceCustomerInformEntryTableViewCellDelegate <NSObject>
- (void)textFieldBeginEditing:(UITextField *)textField;
- (void)textFieldendEditing:(UITextField *)textField;
@end
@interface PriceCustomerInformEntryTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id <PriceCustomerInformEntryTableViewCellDelegate> delegate;
- (void)setLabelNameText:(NSString *)text;
@end
