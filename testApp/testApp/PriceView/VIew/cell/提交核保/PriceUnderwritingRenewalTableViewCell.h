//
//  PriceUnderwritingRenewalTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/26.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceUnderwritingRenewalTableViewCellDelegate <NSObject>
- (void)getRenewalStatus:(BOOL)status;
@end
@interface PriceUnderwritingRenewalTableViewCell : UITableViewCell
@property (nonatomic, weak) id<PriceUnderwritingRenewalTableViewCellDelegate>delegate;
@end
