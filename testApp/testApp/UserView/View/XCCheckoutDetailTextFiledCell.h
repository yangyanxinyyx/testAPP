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

@end
