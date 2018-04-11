//
//  XCShopAMapViewController.m
//  testApp
//
//  Created by Melody on 2018/4/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopAMapViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface XCShopAMapViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView * mapView ;
@end

@implementation XCShopAMapViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.view addSubview:self.mapView];

}
#pragma mark - Init Method

#pragma mark - Action Method

#pragma mark - Delegates & Notifications
#pragma mark - MAMapViewDelegate


#pragma mark - Privacy Method

#pragma mark - Setter&Getter
@end
