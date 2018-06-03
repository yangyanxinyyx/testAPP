//
//  XCUserCaseDetailProgressCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCUserCaseDetailProgressCell : UITableViewCell

/** 标题 */
@property (nonatomic, strong) NSString * processStr ;
/** <# 注释 #> */
@property (nonatomic, strong) NSArray * processStrArr ;

@property (nonatomic, assign) BOOL isFinish;

+ (CGFloat)getCellHeight;
@end
