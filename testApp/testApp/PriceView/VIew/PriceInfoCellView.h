//
//  PriceInfoCellView.h
//  testApp
//
//  Created by 严玉鑫 on 2018/4/3.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceInfoCellView : UIView
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelContent;
- (instancetype)initWithFrame:(CGRect)frame withLabelNameText:(NSString *)labelNameText;
@end
