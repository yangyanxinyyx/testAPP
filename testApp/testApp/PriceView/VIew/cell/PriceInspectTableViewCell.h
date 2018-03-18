//
//  PriceInspectTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceInspectTableViewCellDelegate <NSObject>
- (void)inspectPriceDelegate;
@end
@interface PriceInspectTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *labelName;
@property (nonatomic, strong)UIButton *buttoninspect;
@property (nonatomic, weak) id <PriceInspectTableViewCellDelegate>delegate;
@end
