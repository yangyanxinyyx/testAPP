//
//  XCUserCaseScrollerViewCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCUserCaseScrollerViewCell : UITableViewCell
/** <# 注释 #> */
@property (nonatomic, copy) NSString * titleStr ;
/** <# 注释 #> */
@property (nonatomic, strong) NSArray<NSURL *> * photoURLArr ;

+ (CGFloat)getCellHeight;
@end
