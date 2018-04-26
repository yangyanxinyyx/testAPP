//
//  AppDelegate.m
//  testApp
//
//  Created by 杨焱鑫 on 2018/3/11.
//  Copyright © 2018年 outPutTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "CoverMainViewController.h"
#import "PriceViewController.h"
#import "GetCarViewController.h"
#import "UserViewController.h"
#import "BaseTabbarController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Bugly/Bugly.h>
/**当前app版本号*/
#define BC_AppCurrentBuildVerison @"CurrentBuildVersion"
@interface AppDelegate ()<UIScrollViewDelegate,UITabBarControllerDelegate>
@property (nonatomic, copy)UIView *bgView;

@property (nonatomic, retain)UIScrollView *myScrollView;
@property (nonatomic, copy)NSArray *imageArray;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //高德地图
    [AMapServices sharedServices].apiKey = @"780fe25c204479d57fd155664e193fa6";
    //bugly
    [Bugly startWithAppId:@"bb500984-d6de-417d-800f-6541fbce73e6"];

    
    BaseTabbarController *tab = [[BaseTabbarController alloc] init];
    tab.delegate = self;
    self.window.rootViewController = tab;
    
    NSString *currentBuildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *defaultsBuildVersion = [[NSUserDefaults standardUserDefaults] objectForKey:BC_AppCurrentBuildVerison];
    if (![currentBuildVersion isEqualToString:defaultsBuildVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentBuildVersion forKey:BC_AppCurrentBuildVerison];
        self.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"guide1"],[UIImage imageNamed:@"guide2"],[UIImage imageNamed:@"guide3"],nil];
        self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        [self.bgView addSubview:self.myScrollView];
        [self.window addSubview:self.bgView];
        for (int i = 0; i < self.imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.myScrollView.frame.size.width*i, 0, self.myScrollView.frame.size.width ,self.myScrollView.frame.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.image = [self.imageArray objectAtIndex:i];
            [self.myScrollView addSubview:imageView];
            
            if (i==2) {
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.myScrollView.frame.size.width*2, self.myScrollView.frame.size.height-75, SCREEN_WIDTH ,150)];
                
                [btn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
                [self.myScrollView addSubview:btn];
            }
        }
    } else {
        
    }

    return YES;
}

- (void)closeView {
    
    [self.bgView removeFromSuperview];
}
- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _myScrollView.pagingEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator =  NO;
        _myScrollView.backgroundColor = [UIColor blackColor];
        _myScrollView.delegate = self;
        
    }
    return _myScrollView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
