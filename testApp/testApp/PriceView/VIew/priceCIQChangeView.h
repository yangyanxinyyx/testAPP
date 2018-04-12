//
//  priceCIQChangeView.h
//  testApp
//
//  Created by 严玉鑫 on 2018/3/18.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol priceCIQChangeViewDelegate <NSObject>
- (void)changeModel:(BOOL)isLaseY;
@end
@interface priceCIQChangeView : UIView
@property (nonatomic, weak) id <priceCIQChangeViewDelegate>delegate;
- (void)setleftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;
@end
