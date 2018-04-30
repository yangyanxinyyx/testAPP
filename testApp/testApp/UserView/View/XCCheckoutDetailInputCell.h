//
//  XCCheckoutDetailInputCell.h
//  testApp
//
//  Created by Melody on 2018/3/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCCheckoutDetailInputCell : UITableViewCell

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, assign) BOOL isContinue ;

@end
