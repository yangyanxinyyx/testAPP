//
//  XCDistributionInputCell.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XCDistributionInputCellDelegate <NSObject>

- (void)XCDistributionInputCellClickSelectView:(BOOL)isselected;

@end
@interface XCDistributionInputCell : UITableViewCell

@property (nonatomic, copy) NSString * title;
@property (nonatomic, weak) id<XCDistributionInputCellDelegate> delegate;
@property (nonatomic, assign) BOOL  isSelect ;
@end
