//
//  XCShopAMapViewController.h
//  testApp
//
//  Created by Melody on 2018/4/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCUserBaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapSearchKit/AMapSearchKit.h>

@protocol XCShopAMapViewControllerDelegate <NSObject>
- (void)XCShopAMapViewControllerDidConfirmWithAMapAddressComponent:(AMapAddressComponent *)selectComponent coordinate:(CLLocationCoordinate2D)coordiante;

@end
@interface XCShopAMapViewController : BaseViewController1<BaseNavigationBarDelegate>
/**
 自定义导航栏
 */
@property (nonatomic, strong) BaseNavigationBar *topBar ;
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic, weak) id<XCShopAMapViewControllerDelegate> delegate ;
- (instancetype)initWithTitle:(NSString *)title;

@end
