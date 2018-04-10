//
//  XCShopDetailListCell.h
//  testApp
//
//  Created by Melody on 2018/4/10.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XCShopDetailListCell <NSObject>
- (void)XCShopDetailListCellClickEditedButton:(UIButton *)button;

@end
@interface XCShopDetailListCell : UICollectionViewCell

@end
