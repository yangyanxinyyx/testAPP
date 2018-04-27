//
//  XCUserListFooterView.h
//  testApp
//
//  Created by Melody on 2018/4/27.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XCUserListFooterViewDelegate <NSObject>
- (void)XCUserListFooterViewClickCancelBtn:(UIButton *)button;
@end

@interface XCUserListFooterView : UICollectionReusableView
@property (nonatomic, weak) id<XCUserListFooterViewDelegate> delegate ;
+ (CGFloat)getFooterViewHeight;
@end
