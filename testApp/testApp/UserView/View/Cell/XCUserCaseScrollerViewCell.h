//
//  XCUserCaseScrollerViewCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  XCUserCaseScrollerViewCell;
@protocol XCUserCaseScrollerViewCellDelegate <NSObject>
- (void)XCUserCaseScrollerViewCellClickphotoWithURL:(NSURL  *)photoURL index:(NSInteger)index cell:(XCUserCaseScrollerViewCell *)cell;
@end
@interface XCUserCaseScrollerViewCell : UITableViewCell
/** <# 注释 #> */
@property (nonatomic, copy) NSString * titleStr ;
/** <# 注释 #> */
@property (nonatomic, strong) NSArray * photoURLArr ;
@property (nonatomic, weak) id<XCUserCaseScrollerViewCellDelegate> delegate ;

+ (CGFloat)getCellHeight;
@end
