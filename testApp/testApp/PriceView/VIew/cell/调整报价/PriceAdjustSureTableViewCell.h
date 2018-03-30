//
//  PriceAdjustSureTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/30.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceAdjustSureTableViewCellDelegate <NSObject>
- (void)confirmAdjustmentPrice;
@end
@interface PriceAdjustSureTableViewCell : UITableViewCell
@property (nonatomic, weak) id<PriceAdjustSureTableViewCellDelegate> delegate;
@end
