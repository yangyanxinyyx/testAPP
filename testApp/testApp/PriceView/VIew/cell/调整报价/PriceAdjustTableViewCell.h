//
//  PriceAdjustTableViewCell.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/29.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceAdjustTableViewCellDeleagte <NSObject>
- (void)getFranchiseState:(BOOL)state count:(NSInteger)count;
- (void)openToubao:(BOOL)state count:(NSInteger)count;
@end
@interface PriceAdjustTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelName;               //属性
@property (nonatomic, strong) UILabel *labelTag;                //投保
@property (nonatomic, weak) id<PriceAdjustTableViewCellDeleagte>delegate;
- (void)hiddenFranchiseView:(BOOL)isHidden;
- (void)franchiseIsSelect:(BOOL)isSelect;
- (void)selectToubaoState:(BOOL)state;
@end
