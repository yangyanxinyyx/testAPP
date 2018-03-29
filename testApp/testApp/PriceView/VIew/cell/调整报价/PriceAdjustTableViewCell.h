//
//  PriceAdjustTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceAdjustTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;               //属性
@property (nonatomic, strong) UILabel *labelTag;                //投保
- (void)hiddenFranchiseView:(BOOL)isHidden;
- (void)franchiseIsSelect:(BOOL)isSelect;
@end
