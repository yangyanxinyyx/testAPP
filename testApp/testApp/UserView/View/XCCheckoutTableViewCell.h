//
//  XCCheckoutTableViewCell.h
//  testApp
//
//  Created by Melody on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCCheckoutTableViewCellDelegate <NSObject>

- (void)XCCheckoutCellClickCheckoutButtonHandler:(UIButton *)button;

@end

@interface XCCheckoutTableViewCell : UITableViewCell

/** 标记车牌号 */
@property (nonatomic, copy) NSString * carNumber;
/** 标记车主 */
@property (nonatomic, copy) NSString * userName;
/** 标记出单时间 */
@property (nonatomic, copy) NSString * issureTime;

@property (nonatomic, weak) id <XCCheckoutTableViewCellDelegate> delegate;

@end
