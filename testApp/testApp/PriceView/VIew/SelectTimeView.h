//
//  SelectTimeView.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/28.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTimeView : UIView
@property (nonatomic, copy)void (^block)(NSString*);
@end
