//
//  XCCheckoutDetailTextFiledCell.h
//  testApp
//
//  Created by Melody on 2018/3/25.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCCheckoutDetailTextFiledCellDelegate <NSObject>

- (void)XCCheckoutDetailTextFiledSubmitTextField:(NSString *)textFiledString;

@end

@interface XCCheckoutDetailTextFiledCell : UITableViewCell

@property (nonatomic, weak) id<XCCheckoutDetailTextFiledCellDelegate> delegate;

@property (nonatomic, strong) NSString * title ;
@property (nonatomic, strong) NSString * titlePlaceholder ;
/** 默认为NO */
@property (nonatomic, assign) BOOL  isCenterSeparator ;
//显示分割线 默认为NO
@property (nonatomic, assign) BOOL shouldShowSeparator ;
/** 设置TextFiled背景颜色 默认为灰色 */
@property (nonatomic, strong) UIColor * textFiledBGColor ;
+(CGFloat)getCellHeight;

@end
