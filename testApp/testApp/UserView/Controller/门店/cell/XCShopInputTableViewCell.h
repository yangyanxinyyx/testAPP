//
//  XCShopInputTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/8.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCShopInputTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UITextField *textFieldInput;
- (void)setLabelNameText:(NSString *)labelNameText textFieldPlaceholder:(NSString *)textFieldPlaceholder;
@end
