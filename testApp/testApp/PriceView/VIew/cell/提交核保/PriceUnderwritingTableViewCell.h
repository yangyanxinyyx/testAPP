//
//  PriceUnderwritingTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceUnderwritingTableViewCellDelegate <NSObject>
@optional
- (void)getUnderwritingTextField:(UITextField *)textField;
@end
@interface PriceUnderwritingTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelInfo;
@property (nonatomic, strong) UITextField *textFieldInfo;
@property (nonatomic, weak) id <PriceUnderwritingTableViewCellDelegate>delegate;
- (void)setTextFieldInfoHidden:(BOOL)isHidden;
@end
