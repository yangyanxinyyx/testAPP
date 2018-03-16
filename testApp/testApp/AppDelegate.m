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
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    CoverMainViewController *cover = [[CoverMainViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:cover];
    navVC.tabBarItem.title = @"首页";
    navVC.tabBarItem.selectedImage = [UIImage imageNamed:@"首页"];
    navVC.tabBarItem.image = [UIImage imageNamed:@"首页"];

    PriceViewController *price = [[PriceViewController alloc] init ];
    UINavigationController *navPrice = [[UINavigationController alloc] initWithRootViewController:price];
    navPrice.tabBarItem.title = @"报价";
    navPrice.tabBarItem.selectedImage = [UIImage imageNamed:@"报价"];
    navPrice.tabBarItem.image = [UIImage imageNamed:@"报价"];

    GetCarViewController *getCar = [[GetCarViewController alloc] init ];
    UINavigationController *navGetCar = [[UINavigationController alloc] initWithRootViewController:getCar];
    navGetCar.tabBarItem.title = @"接车";
    navGetCar.tabBarItem.image = [UIImage imageNamed:@"接车"];
    navGetCar.tabBarItem.selectedImage = [UIImage imageNamed:@"接车"];

    UserViewController *user = [[UserViewController alloc] init ];
    UINavigationController *navUser = [[UINavigationController alloc ] initWithRootViewController:user];
    navUser.tabBarItem.title = @"我的";
    navUser.tabBarItem.image = [UIImage imageNamed:@"我的"];
    navUser.tabBarItem.selectedImage = [UIImage imageNamed:@"我的"];


    UITabBarController *tabC = [[UITabBarController alloc] init];
    tabC.viewControllers = [NSArray arrayWithObjects:navVC,navPrice,navGetCar,navUser, nil];
    tabC.tabBar.translucent = NO;
    tabC.delegate = self;
    self.window.rootViewController =tabC;

    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:104/255.0 green:153/255.0 blue:232/255.0 alpha:1]];


    return YES;
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
