//
//  XCShopAMapViewController.m
//  testApp
//
//  Created by Melody on 2018/4/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "XCShopAMapViewController.h"
#import <MAMapKit/MAMapKit.h>

#define kannotaionID @"myAnnotationID"
@interface XCShopAMapViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView * mapView ;
/** <# 注释 #> */
@property (nonatomic, strong) UIButton * locationBtn ;
/** <# 注释 #> */
@property (nonatomic, strong) UILongPressGestureRecognizer * longPress ;

/** <# 注释 #> */
@property (nonatomic, strong) MAPointAnnotation * selectAnnotion ;
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
    _mapView.zoomLevel = 15;
    [self.view addSubview:self.mapView];
    
    self.locationBtn = [UIButton buttonWithType:0];
    [self.locationBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [self.locationBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.locationBtn addTarget:self action:@selector(localMyPosition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.locationBtn];

    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAddAnnotation:)];
    _longPress.minimumPressDuration = 0.3;
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
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        UIImage *image = [UIImage imageNamed:@"red"];
        annotationView.image = image;
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        [annotationView setDraggable:NO];
        
        return annotationView;
    }
    return nil;
}
#pragma mark - BaseNavigationBarDelegate

- (void)baseNavigationDidPressCancelBtn:(BOOL)isCancel
{
    if (isCancel) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Privacy Method

#pragma mark - Setter&Getter
@end
