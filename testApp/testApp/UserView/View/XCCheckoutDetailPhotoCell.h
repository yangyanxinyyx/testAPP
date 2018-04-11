//
//  XCCheckoutDetailPhotoCell.h
//  testApp
//
//  Created by Melody on 2018/4/7.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XCCheckoutDetailPhotoCellDelegate <NSObject>

- (void)XCCheckoutDetailPhotoCellClickAddPhotosBtn:(UIImageView *)imageView;

- (void)XCCheckoutDetailPhotoCellClickphotoImageView:(UIImage *)image index:(NSInteger)index;

@end

@interface XCCheckoutDetailPhotoCell : UITableViewCell
@property (nonatomic, strong) NSString * title ;
@property (nonatomic, strong) NSArray * photoArr ;

@property (nonatomic, assign) NSInteger  maxPhoto ;

/** <# 类型描述  #> */
@property (nonatomic, weak) id<XCCheckoutDetailPhotoCellDelegate> delegate ;
+ (CGFloat)getCellHeight;
@end
