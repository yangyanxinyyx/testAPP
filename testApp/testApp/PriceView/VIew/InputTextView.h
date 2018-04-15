//
//  InputTextView.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/14.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InputTextViewDelegate <NSObject>
- (void)inputTextFieldWithText:(NSString *)text;
@end
@interface InputTextView : UIView
@property (nonatomic, weak) id <InputTextViewDelegate>delegate;
@end
