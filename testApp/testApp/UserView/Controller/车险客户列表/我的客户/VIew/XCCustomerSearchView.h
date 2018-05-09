//
//  XCCustomerSearchView.h
//  testApp
//
//  Created by Melody on 2018/5/9.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCCustomerSearchViewDelegate <NSObject>

- (void)XCCustomerSearchViewClickSerachWithText:(NSString *)text textFiled:(UITextField *)textfiled;

@end

@interface XCCustomerSearchView : UIView
/** <# 注释 #> */
@property (nonatomic, weak) id<XCCustomerSearchViewDelegate> delegate ;
@end
