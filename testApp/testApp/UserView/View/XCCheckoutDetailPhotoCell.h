//
//  XCCheckoutDetailPhotoCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XCCheckoutDetailPhotoCellDelegate <NSObject>

- (void)XCCheckoutDetailPhotoCellClickAddPhotosBtn:(UIButton *)button;

- (void)XCCheckoutDetailPhotoCellClickphotoImageView:(UIImage *)image index:(NSInteger)index;

@end

@interface XCCheckoutDetailPhotoCell : UITableViewCell
@property (nonatomic, strong) NSString * title ;
/** <# 注释 #> */
@property (nonatomic, strong) NSArray * photoArr ;
@end
