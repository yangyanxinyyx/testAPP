//
//  ProceUnderwritingSureTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceUnderwritingSureTableViewCellDelegate <NSObject>
- (void)comfirmToSubmit;
@end

@interface PriceUnderwritingSureTableViewCell : UITableViewCell
@property (nonatomic, weak) id<PriceUnderwritingSureTableViewCellDelegate> delegate;
@end
