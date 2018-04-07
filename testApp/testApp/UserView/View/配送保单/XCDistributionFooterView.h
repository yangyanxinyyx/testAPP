//
//  XCDistributionFooterView.h
//  testApp
//
//  Created by Melody on 2018/4/6.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XCDistributionFooterViewDelegate <NSObject>

- (void)XCDistributionFooterViewClickConfirmBtn:(UIButton *)confirmBtn;

@end

@interface XCDistributionFooterView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title ;
@property (nonatomic, weak) id<XCDistributionFooterViewDelegate> delegate;

@end
