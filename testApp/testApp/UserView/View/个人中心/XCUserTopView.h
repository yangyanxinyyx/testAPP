//
//  XCUserTopView.h
//  testApp
//
//  Created by Melody on 2018/3/15.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCUserTopViewDelegate <NSObject>
@optional
- (void)XCUserTopViewMyCommissionButtonClickHandler:(UIButton *)button;
- (void)XCUserTopViewModifyPasswordButtonClickHandler:(UIButton *)button;
@end

@interface XCUserTopView : UIView

@property (nonatomic, weak) id<XCUserTopViewDelegate> delegate ;

@property (nonatomic, copy) NSString * userIconUrlString;

@property (nonatomic, copy) NSString * userName;

@end
