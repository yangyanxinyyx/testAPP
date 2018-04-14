//
//  PriceInfoSaveTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceInfoSaveTableViewCellDelegate <NSObject>
- (void)savePriveInfoDelegate;
- (void)submitNuclearInsDelegate;
@end


@interface PriceInfoSaveTableViewCell : UITableViewCell
@property (nonatomic, weak)id <PriceInfoSaveTableViewCellDelegate> delegate;
- (void)setCellState:(BOOL)isSave;

@end
