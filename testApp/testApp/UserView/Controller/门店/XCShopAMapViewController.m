//
//  XCShopAMapViewController.m
//  testApp
//
//  Created by Melody on 2018/4/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopAMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#define kannotaionID @"myAnnotationID"
@interface XCShopAMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) MAMapView * mapView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * locationBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) UILongPressGestureRecognizer * longPress ;

/** <# 注释 #> */
@property (nonatomic, strong) MAPointAnnotation * selectAnnotion ;

/** <# 注释 #> */
@property (nonatomic, strong) AMapSearchAPI * searchAPI ;
/** <# 注释 #> */
@property (nonatomic, strong) AMapAddressComponent * currentComponent ;
@end

@implementation XCShopAMapViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = self;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kHeightForNavigation, SCREEN_WIDTH, SCREEN_HEIGHT - kHeightForNavigation)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.userInteractionEnabled = YES;
    _mapView.zoomLevel = 15;
    [self.view addSubview:self.mapView];
    
    self.locationBtn = [UIButton buttonWithType:0];
    [self.locationBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [self.locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.locationBtn setBackgroundColor:[UIColor orangeColor]];
    [self.locationBtn addTarget:self action:@selector(localMyPosition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.locationBtn];

    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAddAnnotation:)];
    _longPress.delegate = self;
//    _longPress.minimumPressDuration = 0.7;
    [self.mapView addGestureRecognizer:_longPress];
}

- (void)viewWillLayoutSubviews
{
    CGSize buttonSize = CGSizeMake(200, 60);
    
    [self.locationBtn setFrame:CGRectMake(15 * ViewRateBaseOnIP6, CGRectGetMaxY(_mapView.frame) - 15 * ViewRateBaseOnIP6 - buttonSize.height, buttonSize.width, buttonSize.height)];
}

#pragma mark - Init Method
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.view.backgroundColor = COLOR_RGB_255(242, 242, 242);
        _topBar = [[BaseNavigationBar alloc] init];
        _topBar.delegate  = self;
        _topBar.title = title;
        self.navTitle = title;
        [self.view addSubview:_topBar];
    }
    return self;
}

#pragma mark - Action Method
- (void)localMyPosition:(UIButton *)button
{
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate];
    if (self.selectAnnotion) {
        [_mapView removeAnnotation:self.selectAnnotion];
    }
    self.selectAnnotion = [[MAPointAnnotation alloc] init];
    self.selectAnnotion.coordinate = _mapView.userLocation.coordinate;
    [_mapView addAnnotation:self.selectAnnotion];
}

- (void)longPressAddAnnotation:(UILongPressGestureRecognizer *)longPress
{
    [_mapView removeAnnotation:self.selectAnnotion];

    CGPoint point =  [longPress locationInView:_mapView];
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:_mapView];
    self.selectAnnotion = [[MAPointAnnotation alloc] init];
    self.selectAnnotion.coordinate = coordinate;
    [_mapView addAnnotation:self.selectAnnotion];
    
}

#pragma mark - Delegates & Notifications
#pragma mark - MAMapViewDelegate

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = kannotaionID;
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.pinColor =  MAPinAnnotationColorRed;
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:annotation.coordinate.latitude longitude: annotation.coordinate.longitude];
        
        [self.searchAPI  AMapReGoecodeSearch:regeo];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        [annotationView setDraggable:NO];
        self.selectAnnotion = annotation;
        
        UIButton *button = [UIButton buttonWithType:0];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button sizeToFit];
        [button addTarget:self action:@selector(mapViewCalloutClickButton:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.leftCalloutAccessoryView =button;
        
        return annotationView;
    }
    return nil;
}

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    AMapGeocodeSearchRequest *req = [[AMapGeocodeSearchRequest alloc] init];
    req.address = response.regeocode.formattedAddress;
    [self.searchAPI AMapGeocodeSearch:req];
    
    AMapReGeocode *regeocode = response.regeocode;
    AMapAddressComponent *addressComponent = regeocode.addressComponent;
    [self.selectAnnotion setTitle:addressComponent.streetNumber.street];
    [self.selectAnnotion setSubtitle:addressComponent.building];
    self.currentComponent = regeocode.addressComponent;
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - longPressDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Privacy Method
- (void)mapViewCalloutClickButton:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XCShopAMapViewControllerDidConfirmAddressCity:area:coordinate:)]) {
        [self.delegate XCShopAMapViewControllerDidConfirmAddressCity:self.currentComponent.city area:self.currentComponent.district coordinate:self.selectAnnotion.coordinate];
    }
    NSLog(@"click");
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Setter&Getter
@end
